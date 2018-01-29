# Docker Engine Utility for DeePMD-kit
[DeePMD-kit](https://github.com/deepmodeling/deepmd-kit#run-md-with-native-code) is a deep learning package for many-body potential energy representation and molecular dynamics.   
This docker project is set up to simplify the installation process of DeePMD-kit.

## QuickStart 
`git clone git@github.com:TimChen314/deepmd-kit_docker.git deepmd-kit_docker`   
`cd deepmd-kit_docker && docker build -f Dockerfile .`   
It will take a few minutes to download necessary package and install them.   
The `ENV` statement in Dockerfile sets the install prefix of packages. These environment variables can be set by users themselves.
