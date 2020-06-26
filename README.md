# i3-docker
A Dockerized wrapper of the I3 cryo-ET STA software

## Getting Started

These instructions will get you easily set up with I3 through this package, powered by Docker.

### External dependencies
The following external packages are required and should thus be installed first:

* Docker - https://docs.docker.com/engine/install/


### A quick introduction to Docker

Docker is a tool which simplifies the software development and distribution process using containers. A container is an isolated unit of software and its dependencies designed to be portable and reliably compatible with varying computing environments. In the case of I3 and this package, whenever the **start_i3.sh** script is called, it will spawn a Docker container on your machine which already contains I3 and all of its required dependencies (EMAN2 is optional and not included in this). Simply put, this container will act as an isolated, virtual machine (it's not really a virtual machine in the traditional sense but that is beyond the scope of this introduction) which can run I3 and has access to any files on the local machine you give it access to. The **start_i3.sh** script will open a shell into this I3 instance, and additional bash shells into it can be opened with the **open_i3_shell.sh**.

### Setting up i3-docker

To begin, navigate to a directory in which you want to place the package and run the following commands:

```
git clone https://github.com/kmshin1397/i3-docker.git

cd i3-docker

chmod +x start_i3.sh

chmod +x open_i3_shell.sh

chmod +x close_i3.sh
```
The scripts to enable your own I3 instances should now be enabled.


## Running I3

Running I3 with the i3-docker package revolves around the **start_i3.sh** script. When you first run the script, you will be prompted for a path to a directory to give I3 access to. The I3 container spawned by the script will only be able to see and access the directory given here within your local filesystem, so you should make sure any necessary data files and configuration files are under this directory. Remember that you can always close and start up a new I3 instance if you need access to different locations throughout the data processing pipeline.

Once the mount path is given, the **start_i3.sh script** will pull down the I3 Docker image from Docker Hub (https://hub.docker.com/repository/docker/kmshin1397/i3/general) and spawn a container from it on your machine. Note that if this is the first time you are running the script, or the Docker image has been updated since the last time you started an I3 container, it will need to download the latest image and thus may take awhile.  

Once the I3 container has been started, the script will transition into a bash shell allowing you to interface with the I3 instance where you can run any I3 command as you would on a machine with I3 naturally installed. 

When you are finished with I3 for now, you may call `exit` in this shell to close it; the script will then ask you if you want to shutdown the running container. You may keep it running for whatever reason, but you will need to manually shut it down later using **close_i3.sh** before spawning a new I3 container. The close_i3.sh can also be used to clean up any I3 containers if due to an error the original start\_i3.sh script is quit unnaturally.

## Authors

* **Kyung Min Shin** - California Institute of Technology

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details

## Acknowledgments

* This project only serves to package the existing I3 software for easier installation. All credit and ownership of I3 programs belongs to its original developer (https://www.electrontomography.org/).
