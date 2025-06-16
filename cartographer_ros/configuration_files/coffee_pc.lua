-- Copyright 2016 The Cartographer Authors
--
-- Licensed under the Apache License, Version 2.0 (the "License");
-- you may not use this file except in compliance with the License.
-- You may obtain a copy of the License at
--
--      http://www.apache.org/licenses/LICENSE-2.0
--
-- Unless required by applicable law or agreed to in writing, software
-- distributed under the License is distributed on an "AS IS" BASIS,
-- WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
-- See the License for the specific language governing permissions and
-- limitations under the License.

include "map_builder.lua"
include "trajectory_builder.lua"

options = {
  map_builder = MAP_BUILDER,
  trajectory_builder = TRAJECTORY_BUILDER,
  map_frame = "map",
  tracking_frame = "imu_link",
  published_frame = "base_link",
  odom_frame = "odom",
  provide_odom_frame = true,
  -- 20250411 modify tf adapt to rv1126
  provide_odom_tf = false,  --true,
  use_odometry = true,
  use_nav_sat = false,
  use_landmarks = false,
  publish_frame_projected_to_2d = false,
  ignore_out_of_order = false,
  num_laser_scans = 1,
  num_multi_echo_laser_scans = 0,
  num_subdivisions_per_laser_scan = 1,
  num_point_clouds = 0,
  rangefinder_sampling_ratio = 1.,
  odometry_sampling_ratio = 1.,
  fixed_frame_pose_sampling_ratio = 1.,
  imu_sampling_ratio = 1.,
  landmarks_sampling_ratio = 1.,
  lookup_transform_timeout_sec = 0.2,
  submap_publish_period_sec = 0.3,
  pose_publish_period_sec = 20e-3,
  trajectory_publish_period_sec = 30e-3,
  publish_to_tf = true,
  publish_tracked_pose = true,
  use_pose_extrapolator = false,
}

MAP_BUILDER.use_trajectory_builder_2d = true

TRAJECTORY_BUILDER_2D.use_imu_data = true
-- 20250325 distortion calibration
TRAJECTORY_BUILDER_2D.use_distortion_calibration = false  --true
-- 20250331 rotation check
TRAJECTORY_BUILDER_2D.use_rotation_check = true --false
TRAJECTORY_BUILDER_2D.min_range = 0.2 --0.
TRAJECTORY_BUILDER_2D.max_range = 10. --30.
TRAJECTORY_BUILDER_2D.missing_data_ray_length = 5.
TRAJECTORY_BUILDER_2D.use_online_correlative_scan_matching = false
-- 20250331 modify motion filter
TRAJECTORY_BUILDER_2D.motion_filter.max_time_seconds = 1e9  --5.
TRAJECTORY_BUILDER_2D.motion_filter.max_distance_meters = 0.3 --0.2
TRAJECTORY_BUILDER_2D.motion_filter.max_angle_radians = math.rad(3.) --math.rad(1.)
-- 20250328 modify pose extrapolator
TRAJECTORY_BUILDER_2D.pose_extrapolator.pose_extrapolate_mode = 0
TRAJECTORY_BUILDER_2D.submaps.num_range_data = 60 --90

-- 20250326 loop closure
POSE_GRAPH.use_loop_closure = true
POSE_GRAPH.optimize_every_n_nodes = 90
POSE_GRAPH.constraint_builder.sampling_ratio = 0.3
POSE_GRAPH.constraint_builder.max_constraint_distance = 10.  --15.
POSE_GRAPH.constraint_builder.min_score = 0.55
POSE_GRAPH.constraint_builder.fast_correlative_scan_matcher.linear_search_window = 7.
POSE_GRAPH.constraint_builder.fast_correlative_scan_matcher.angular_search_window = math.rad(30.)
POSE_GRAPH.global_sampling_ratio = 0.003
POSE_GRAPH.global_constraint_search_after_n_seconds = 60. --10.

return options
