# cpack-exercise

```bash
cmake -S . -B build -DCMAKE_INSTALL_PREFIX=/usr
cmake --build build
DESTDIR=$HOME/tmp cmake -DCOMPONENT=runtime -P build/cmake_install.cmake
```
