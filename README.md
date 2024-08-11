# UFO_QML

UFO_QML is a straightforward CMake template project designed to kickstart QML development. While not flawless, it aims to help new programmers set up QML projects quickly and effectively. We plan to periodically enhance its features, so stay tuned for updates. We hope you find it valuable!


### Prerequisites

Before using this template, ensure your development environment meets the following requirements:
```diff
Qt                            (Minimum version required: 6.7)
Qt-CMake                      (Minimum version required: 3.16)
Qt-Compiler                   (MSVC, MinGW, GCC, Clang/LLVM, ...)
```

You can choose which Qt modules to use, but we recommend at least the following essential modules:
```diff
Qt-Core
Qt-Widgets
Qt-Gui
Qt-Quick
Qt-QuickControls2
Qt-Network
Qt-Sql
Qt-Multimedia
```

Since QML uses OpenGL, on Linux systems, you may need to install additional dependencies to avoid errors:

```diff
sudo apt install libglx-dev libgl1-mesa-dev
```


### Usage

Once you successfully download the project, you can start using the template with the QtCreator IDE. To open the project follow the steps below:
```diff
File Menu >> Open File or Project... >> "Path/To/CMakeLists.txt"
```

For a smooth experience with QtCreator IDE, ensure you configure your build directory as specified in the template.


## License

This project is licensed under the [MIT License](LICENSE).
