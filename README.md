# Docker Engine Utility for DeePMD-kit
[DeePMD-kit](https://github.com/deepmodeling/deepmd-kit#run-md-with-native-code) is a deep learning package for many-body potential energy representation and molecular dynamics.

## QuickStart 
`docker build -f Dockerfile -t timchen314/deepmd-kit .`
The `ENV` statement in Dockerfile sets the install prefix of packages. These environment variables can be set by users themselves.
