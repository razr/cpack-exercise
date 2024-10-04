# cpack-exercise

There are two deb packages built: Runtime and Development

```bash
mkdir build && cd build
cmake .. -DCMAKE_INSTALL_PREFIX=/usr
cmake --build .
make list_install_components
cpack -G DEB
cpack -G DEB -D CPACK_COMPONENTS_ALL=Runtime
cpack -G DEB -D CPACK_COMPONENTS_ALL=Development
find . -name "*.deb" -exec sh -c 'echo "Contents of {}:"; dpkg -c {}' \;
DESTDIR=$HOME/tmp cmake -DCOMPONENT=Runtime -P cmake_install.cmake
```
