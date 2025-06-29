# Dragon Ball Z: Buu's Fury

This is a disassembly of Buu's Fury for the GBA.

It builds the following ROM:
* baserom.gba `sha1: f1c4b07554d2a3b1ad2f325307051e775ce68087`

## Getting Started

To get started with the disassembly of Buu's Fury, you will need the following:

- A working installation of Arm Developer Suite v1.2. All the tools (`armasm`, `armcpp`, `tcpp`, `armlink`, `fromelf`, etc) must already be in your PATH.
- A copy of [grit](https://github.com/DylanGraham/grit), already in your path.
- [CMake](https://cmake.org/) for building the compression utility (If you're on Windows you can run `winget install cmake`).
- A copy of the game, saved as `baserom.gba` in the root directory

## Building

To compile the source code back into a GBA ROM:

1. Ensure all prerequisites are installed and set up correctly.
2. Clone the repo `git clone --recursive https://github.com/2genkidev/buusfury.git`
3. Run the build script located in the root directory: `.\build.bat`
4. The script will assemble the source code and produce a GBA ROM file.
5. If everything went okay, you should find a newly assembled `image.gba` 
