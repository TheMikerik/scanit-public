// ⚠️ This is a sanitized, public-safe example of a CameraPreviewView implementation.
// It demonstrates basic use of AVFoundation for synchronized RGB-D capture and data transmission.
// Sensitive project details and proprietary code have been omitted.

import UIKit
import AVFoundation

class CameraPreviewView: UIView {
    private let session = AVCaptureSession()
    private var previewLayer: AVCaptureVideoPreviewLayer!
    private var outputSynchronizer: AVCaptureDataOutputSynchronizer!
    static weak var currentInstance: CameraPreviewView?
    
    private let videoDataOutput = AVCaptureVideoDataOutput()
    private let depthDataOutput = AVCaptureDepthDataOutput()

    private let dataOutputQueue = DispatchQueue(label: "scanit.output.queue", qos: .userInitiated)











//  removed code












    func startSession() {
        guard !isSessionRunning else { return }
        
        DispatchQueue.global(qos: .userInitiated).async { [weak self] in
            guard let self = self else { return }
            self.session.startRunning()
            self.isSessionRunning = true
            print("Camera session started")
        }
    }
    











//  removed code










    
    private func sendRGBDPacket(depthBytes: Data, colorBytes: Data,
                                depthWidth: Int, depthHeight: Int,
                                colorWidth: Int, colorHeight: Int) {
        let header: [String: Any] = [
            "type": "rgbd",
            "depth": [
                "width": depthWidth,
                "height": depthHeight,
                "dtype": "float32"
            ],
            "color": [
                "width": colorWidth,
                "height": colorHeight,
                "format": "jpeg"
            ]
        ]
        
        guard let headerJSON = try? JSONSerialization.data(withJSONObject: header) else {
            print("Failed to serialize RGBD header")
            return
        }
        
        if let jsonString = String(data: headerJSON, encoding: .utf8) {
            print("→ RGBD header:\n\(jsonString)")
        }

        var packet = Data()
        var lenBE = UInt32(headerJSON.count).bigEndian
        packet.append(Data(bytes: &lenBE, count: 4))
        packet.append(headerJSON)
        packet.append(depthBytes)
        packet.append(colorBytes)

        DispatchQueue.global(qos: .utility).async {
            globalWebSocket.sendData(packet)
        }
        print("→ RGBD packet sent (\(packet.count) B)")
    }

    private func processDepthData(_ depthMap: CVPixelBuffer) -> Data? {
        let width = CVPixelBufferGetWidth(depthMap)
        let height = CVPixelBufferGetHeight(depthMap)

        CVPixelBufferLockBaseAddress(depthMap, .readOnly)
        defer { CVPixelBufferUnlockBaseAddress(depthMap, .readOnly) }
        
        guard let baseAddress = CVPixelBufferGetBaseAddress(depthMap) else {
            print("Failed to get base address for depth map")
            return nil
        }

        let floatBuffer = UnsafeBufferPointer(
            start: baseAddress.assumingMemoryBound(to: Float32.self),
            count: width * height
        )
        return Data(buffer: floatBuffer)
    }
    
    











//  removed code












}

extension CameraPreviewView: AVCaptureDataOutputSynchronizerDelegate {
    func dataOutputSynchronizer(_ synchronizer: AVCaptureDataOutputSynchronizer,
                                didOutput syncedData: AVCaptureSynchronizedDataCollection) {
        
        if (!calibrationDataSent || shouldSendCalibrationData) {
            guard let syncedDepthData = syncedData.synchronizedData(for: depthDataOutput) as? AVCaptureSynchronizedDepthData,
                  let syncedVideoData = syncedData.synchronizedData(for: videoDataOutput) as? AVCaptureSynchronizedSampleBufferData else {
                return
            }
            let depthData = syncedDepthData.depthData
            let convertedDepth = depthData.converting(toDepthDataType: kCVPixelFormatType_DisparityFloat32)
            if let calibData = convertedDepth.cameraCalibrationData {
                let map = convertedDepth.depthDataMap
                let w = CVPixelBufferGetWidth(map)
                let h = CVPixelBufferGetHeight(map)
                sendCalibrationData(calibData, depthWidth: w, depthHeight: h)
            }
        }
        
        guard isProcessing else { return }
        
        guard let syncedDepthData = syncedData.synchronizedData(for: depthDataOutput) as? AVCaptureSynchronizedDepthData,
              let syncedVideoData = syncedData.synchronizedData(for: videoDataOutput) as? AVCaptureSynchronizedSampleBufferData else {
            return
        }
        
        let depthData = syncedDepthData.depthData
        let sampleBuffer = syncedVideoData.sampleBuffer
            
        let convertedDepth = depthData.converting(toDepthDataType: kCVPixelFormatType_DepthFloat32)
        
        let now = CACurrentMediaTime()
        
        if now - lastRGBDSendTime >= 1.0 / rgbdFrameRate {
            lastRGBDSendTime = now
            sendRGBDData(depthData: convertedDepth, sampleBuffer: sampleBuffer)
        }
    }
}












//  removed code











