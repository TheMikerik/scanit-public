"""
⚠️ CONFIDENTIALITY NOTICE:
This code is a modified version of the original system used in a proprietary project.
Sensitive or internal data formats and models have been removed or replaced.
"""

import  os
import  cv2
import  json
import  numpy as np
import  open3d as o3d
from scipy import ndimage
import  json
import time

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#                            GLOBAL SETTINGS
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


#~~~~~~~~~~~~~~~~calibration data~~~~~~~~~~~~~~~~~#
with open(CALIBRATION_FILE, 'rb') as f:
    data        = f.read()
    calibration = json.loads(data.decode('utf-8'))

intrinsic_matrix                     = calibration["intrinsicMatrix"]
extrinsic_matrix                     = calibration["extrinsicMatrix"]
depth_dimensions                     = calibration["depthDimensions"]
reference_dimensions                 = calibration["referenceDimensions"]
lens_distortion_center               = calibration["lensDistortionCenter"]
lens_distortion_lookup_table         = calibration["lensDistortionLookupTable"]
inverse_lens_distortion_lookup_table = calibration["inverseLensDistortionLookupTable"]
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#


#~~~~~~~~~~~~~~~~intrinsic matrix~~~~~~~~~~~~~~~~~~~#
# | fx   0   cx |
# | 0    fy  cy |
# | 0    0    1 |
camera_width  = reference_dimensions["width"]
camera_height = reference_dimensions["height"]

width  = depth_dimensions["width"]
height = depth_dimensions["height"]

scale_x = width  / camera_width
scale_y = height / camera_height

K = np.array(intrinsic_matrix).reshape((3, 3), order='F')

fx = K[0, 0] * scale_x
fy = K[1, 1] * scale_y
cx = K[0, 2] * scale_x
cy = K[1, 2] * scale_y

pinhole_intrinsic = o3d.camera.PinholeCameraIntrinsic(width, height, fx, fy, cx, cy)
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#











# removed code












#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#                       PREPROCESSING METHODS
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~











# removed code













def create_point_cloud(color_o3d, depth_bin):
    height, width = depth_bin.shape
    
    x, y = np.meshgrid(np.arange(width), np.arange(height))
    z = depth_bin

    x3d = (x - cx) * z / fx
    y3d = (y - cy) * z / fy
    z3d = z
    
    points = np.stack((x3d, y3d, z3d), axis=-1).reshape(-1, 3)
    valid = (z > 0).reshape(-1)
    points = points[valid]

    color_np = np.asarray(color_o3d).reshape(-1, 3)
    colors = color_np[valid] / 255.0

    pcd = o3d.geometry.PointCloud()
    pcd.points = o3d.utility.Vector3dVector(points)
    pcd.colors = o3d.utility.Vector3dVector(colors.astype(np.float64))
    return pcd











# removed code











#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#                               MAIN 
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

if __name__ == "__main__":
    start_time = time.time()
    
    frames = sorted(
        [f for f in os.listdir(FRAMES_DIR) if f.endswith('_color.jpg')],
        key=extract_frame_number
    )
    
    for frame in range(len(frames) - 1):
        frame_id = frames[frame].split('_')[1]
        tsdf_pipeline(frame_id)











# removed code











