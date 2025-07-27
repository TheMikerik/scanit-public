// ⚠️ This AppDelegate implementation is an anonymized, public-safe example.
// It demonstrates basic Flutter native integration with a WebSocket service
// and FlutterMethodChannel communication, omitting sensitive project details.


import Flutter
import UIKit

let sharedWebSocket = Websocket()
var methodChannel: FlutterMethodChannel!

@main
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
      let registrar = self.registrar(forPlugin: "custom-view-factory")!
      let factory = CustomViewFactory(messenger: registrar.messenger())
      registrar.register(factory, withId: "custom-view-factory")
      
      methodChannel = FlutterMethodChannel(name: "native-bridge", binaryMessenger: registrar.messenger())
      methodChannel.setMethodCallHandler { call, result in
            switch call.method {
            case "connect":
                CustomView.currentInstance?.resetState()
                
                sharedWebSocket.connect {
                    DispatchQueue.main.async {
                        methodChannel?.invokeMethod("connected", arguments: nil)
                        CustomView.currentInstance?.requestCalibration()
                    }
                }
                result(nil)
            case "disconnect":
                sharedWebSocket.close()
                CustomView.currentInstance?.stopSession()
                result(nil)
            case "start":
                CustomView.currentInstance?.startProcess()
                result(nil)
            case "stop":
                CustomView.currentInstance?.stopProcess()
                result(nil)

            default:
                result(FlutterMethodNotImplemented)
            }
        }
      
      GeneratedPluginRegistrant.register(with: self)
      return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
