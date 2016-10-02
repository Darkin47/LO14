# Vsh Script
> Manage text archives stored on a remote machine

Vsh is a bash script which allows you to manage text archives on a remote machine. As of now, you can browse an archive, to perform actions on the 'compressed' text files, or extract an archive. The browsing mode is a sort of Virtual Shell. The Ncat package is used for network communications. The main purpose of this project was to learn more about Bash scripting.

An archive is a text file composed of a header listing 'compressed' files and of a content of the 'compressed' files. Unfortunately, there is currently no function to create an archive based on an existing directory but there is some correct/incorrect archive examples provided in the `archives` directory, so that it is easy to understand.

## Table of Contents

1. [Getting Started](#getting-started)
1. [How to use](#how-to-use)
1. [About](#about)

## Getting Started

Please, make sure the package Ncat is installed on your machine.

## How to use

### Start/Stop Server

* Start a server listening on a specific port :
```sh
./vsh.sh -start [destination]* [port] [archive_directory]*
```

* Stop a server :
```sh
./vsh.sh -stop [destination]* [port]
```

> *: optional

### Client Connection

* Get the archives available on a server :
```sh
./vsh.sh -list [destination] [port]
```

* Browse an archive :
```sh
./vsh.sh -browse [destination] [port] [archive_name]
```

* Extract an archive on the client machine :
```sh
./vsh.sh -extract [destination] [port] [archive_name]
```

### Using browse mode

While using browse mode, there is a lot of linux-like command such as cd, ls, pwd, rm, etc.
Type help to show them all.

## About

### Authors

* **Julien Grave** - *Developer* - [Darkin47](https://github.com/darkin47)
* **Lucas Soulier** - *Developer* - [lonk](https://github.com/lonk)

See also the list of [contributors](https://github.com/Darkin47/Vsh-LO14-UTT/contributors) who participated in this project.

### License

This project is licensed under the MIT License (MIT). Please see the [LICENSE.md](https://github.com/Darkin47/LO14/blob/master/project/LICENSE) file for details.

**[Back to top](#table-of-contents)**
