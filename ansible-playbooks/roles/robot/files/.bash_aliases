# Pandora launchers
alias robot-launch='roslaunch pandora_launchers integration_test.launch'
alias stabilizer='roslaunch pandora_launchers stabilizer.launch'

# Hardware launchers
alias motors='roslaunch pandora_motor_hardware_interface motor_hardware_interface_and_controllers.launch'
alias dynamixel='roslaunch pandora_dynamixel_hardware_interface dynamixel_hardware_interface_and_controllers.launch'
alias imu='roslaunch pandora_imu_hardware_interface imu_hardware_interface_and_controllers.launch device:=ahrs'
alias arm='roslaunch pandora_arm_hardware_interface arm_hardware_interface_and_controllers.launch'
alias hardware_tools='roslaunch pandora_hardware_tools hardware_tools.launch'

# Other launchers
alias agent='roscd pandora_fsm/src && ./agent_standalone.py ; cd -'
alias teleop='rosrun pandora_motor_control pandora_teleop_key'

# Monitor
alias cpu-temp='watch sensors'
alias batteries='rostopic echo /sensors/battery'

# Scripts
alias repostatus='repostatus.sh ~/pandora_ws/src'

# Connections
alias raspberry='ssh pandora@10.0.1.1'
