# panda_gz_moveit2

A complete ROS 2 workspace demonstrating the integration of **Gazebo simulator**, **MoveIt 2**, and **ros2_control** for robotic manipulation with the Franka Emika Panda robot.

https://github.com/user-attachments/assets/a9c81687-97bb-421d-9789-131ebb6f25f2

## Supported versions

The repository supports different version of ROS 2 together with their corresponding Gazebo version associated with the ROS 2 version. Select the branch that correspond to the desired version:

* [`jazzy`](../../tree/jazzy): ROS 2 Jazzy with Gazebo Harmonic
* [`humble`](../../tree/humble): ROS 2 Humble with Gazebo Fortress
* [`galactic`](../../tree/galactic): ROS 2 Galactic with Gazebo Garden

## 🏗️ Architecture Overview

This repository demonstrates a modern robotics stack integration where **Gazebo** provides physics simulation, **ros2_control** manages hardware interfaces, and **MoveIt 2** handles motion planning and execution.

### Integration Components

* **🎯 MoveIt 2**: Motion planning, collision detection, and trajectory execution
* **🎮 ros2_control**: Unified interface for robot control with pluggable hardware backends
* **🌍 Gazebo**: High-fidelity physics simulation with sensor modeling
* **🔗 gz_ros2_control**: Bridge plugin connecting ros2_control to Gazebo's physics engine

## 🚀 Quick Start

### Prerequisites

* **ROS 2 Jazzy** ([Installation Guide](https://docs.ros.org/en/jazzy/Installation.html))
* **Gazebo Harmonic** ([Installation Guide](https://gazebosim.org/docs/harmonic))
* **Docker** (optional, for containerized development)

### Option 1: Native Installation

```bash
# Create and enter workspace
mkdir -p ~/panda_ws/src && cd ~/panda_ws/src
git clone https://github.com/AndrejOrsula/panda_gz_moveit2.git
cd ~/panda_ws
rosdep install -y -r -i --rosdistro jazzy --from-paths src
colcon build --merge-install --symlink-install
source install/local_setup.bash
```

### Option 2: Docker Development (Recommended)

```bash
git clone https://github.com/AndrejOrsula/panda_gz_moveit2.git
cd panda_gz_moveit2
./.docker/build.bash
./.docker/run.bash
# Inside container - workspace is already built and sourced!
```

The Docker approach provides:

* ✅ Pre-configured environment with all dependencies
* ✅ GUI application support (RViz, Gazebo)
* ✅ Automatic workspace building and sourcing
* ✅ Isolated development environment

## 🎮 Usage Examples

### 1. Full Physics Simulation in Gazebo

Complete robotic simulation with realistic physics:

```bash
ros2 launch panda_moveit_config ex_gz_control.launch.py
```

**What happens:**

* Starts Gazebo with Panda robot model
* Launches MoveIt 2 connected to simulated robot
* Enables realistic physics, dynamics, and timing
* Provides sensor feedback and collision detection

### 2. Motion Planning with Fake Controllers

Perfect for testing motion planning algorithms without physics simulation
using ros2_control [Controller Manager](https://control.ros.org/jazzy/doc/ros2_control/controller_manager/doc/userdoc.html):

```bash
ros2 launch panda_moveit_config ex_fake_control.launch.py
```

**What happens:**

* Launches MoveIt 2 with fake joint trajectory controllers
* Opens RViz with motion planning interface
* Allows interactive motion planning and visualization
* No physics simulation - instant execution


### 3. Custom Configuration

Use the core launch file with custom parameters:

```bash
ros2 launch panda_moveit_config move_group.launch.py \
    ros2_control_plugin:=gz \
    ros2_control_command_interface:=effort \
    enable_rviz:=true
```

## 📁 Repository Structure

```
panda_gz_moveit2/
├── 📦 panda/                        # Metapackage orchestrating the build
|
│   ├── launch/
│   │   ├── fake.launch.py           # Motion planning with fake controllers
│   │   └── gz.launch.py             # Full Gazebo simulation with physics
│   └── CMakeLists.txt               # Auto-generates URDF/SDF/SRDF from xacros
│
├── 🤖 panda_description/            # Robot modeling and description
│   ├── urdf/
│   │   ├── panda.urdf.xacro         # xacro: main robot description
│   │   ├── panda_arm.xacro          # xacro: arm kinematics and dynamics
│   │   ├── panda.ros2_control       # xacro: ros2_control configuration
│   │   ├── panda.gazebo             # xacro: Gazebo-specific plugins (gz_ros2_control)
│   │   ├── ...                      # more xacro files
│   │   └── panda.urdf               # Generated URDF file from xacro
|   |
|   ├── scripts/                     # script to transform Xacro to SDF/URDF
|   |
│   ├── panda/
│   │   ├── meshes/                  # Visual and collision meshes
│   │   └── model.sdf                # Generated SDF for Gazebo
│   └── config/
│       └── initial_joint_positions.yaml
│
├── 🎯 panda_moveit_config/         # MoveIt 2 configuration and examples
│   ├── config/
│   │   ├── controllers_*.yaml      # ros2_control controller configurations
│   │   ├── kinematics.yaml         # Kinematic solver settings
│   │   ├── joint_limits.yaml       # Safety limits and constraints
│   │   ├── ompl_planning.yaml      # Motion planning algorithms
│   │   ├── servo.yaml              # Real-time servo control
│   │   └── moveit_controller_manager.yaml
│   ├── launch/
│   │   ├── move_group.launch.py        # Core MoveIt 2 setup
│   │   ├── ex_fake_control.launch.py   # Example: Fake controllers
│   │   └── ex_gz_control.launch.py     # Example: Gazebo simulation
│   ├── srdf/
│   │   └── panda.srdf.xacro        # Semantic robot description
│   └── rviz/
│       └── moveit.rviz             # Pre-configured RViz setup
│
└── 🐳 .docker/                     # Containerized development environment
    ├── build.bash                  # Docker image builder
    ├── run.bash                    # Container launcher with GUI support
    └── devel.bash                  # Development container access
```


*This repository serves as a reference implementation for integrating modern robotics simulation and control stacks. Feel free to adapt it for your specific robotic applications!*
