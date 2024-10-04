# cpack-exercise

There are two deb packages built: Runtime and Development

```bash
$ mkdir world/build && cd world/build
$ cmake ..
$ cmake --build .
$ make list_install_components
Available install components are: "Development" "Runtime"
$ DESTDIR=$HOME/tmp make install
[ 50%] Built target world
[100%] Built target world_static
Install the project...
-- Install configuration: "Release"
-- Up-to-date: /home/akholodn/tmp/usr/local/lib/libworld.so.1.0.0
-- Up-to-date: /home/akholodn/tmp/usr/local/lib/libworld.so.1
-- Up-to-date: /home/akholodn/tmp/usr/local/lib/libworld.so
-- Up-to-date: /home/akholodn/tmp/usr/local/lib/libworld.a
-- Up-to-date: /home/akholodn/tmp/usr/local/include
-- Up-to-date: /home/akholodn/tmp/usr/local/include/world.h
-- Up-to-date: /home/akholodn/tmp/usr/local/lib/cmake/WorldLibrary/WorldLibraryTargets.cmake
-- Up-to-date: /home/akholodn/tmp/usr/local/lib/cmake/WorldLibrary/WorldLibraryTargets-release.cmake
-- Up-to-date: /home/akholodn/tmp/usr/local/lib/cmake/WorldLibrary/WorldLibraryConfig.cmake
-- Up-to-date: /home/akholodn/tmp/usr/local/lib/cmake/WorldLibrary/WorldLibraryConfigVersion.cmake
```

```bash
$ mkdir hello/build && cd hello/build
$ cmake -DCMAKE_PREFIX_PATH=~/tmp/usr/local ..
-- The C compiler identification is GNU 11.4.0
-- Detecting C compiler ABI info
-- Detecting C compiler ABI info - done
-- Check for working C compiler: /usr/bin/cc - skipped
-- Detecting C compile features
-- Detecting C compile features - done
-- Configuring done
-- Generating done
-- Build files have been written to: /home/akholodn/github/razr/cpack-exercise/hello/build

$ make
$ ./hello
Hello, World!
```

```bash
$ cpack -G DEB
CPack: Create package using DEB
CPack: Install projects
CPack: - Run preinstall target for: WorldLibrary
CPack: - Install project: WorldLibrary []
CPack: -   Install component: Development
CPack: -   Install component: Runtime
CPack: Create package
CPackDeb: - Generating dependency list
-- CPACK_DEBIAN_PACKAGE_DEPENDS not set, the package will have no dependencies.
CPack: - package: world-1.0.0-Linux-x86_64-Development.deb generated.
CPack: - package: world-1.0.0-Linux-x86_64-Runtime.deb generated.

$ dpkg -c world-1.0.0-Linux-x86_64-Development.deb
drwxrwxr-x root/root         0 2024-10-04 23:15 ./usr/
drwxr-xr-x root/root         0 2024-10-04 23:15 ./usr/include/
-rw-r--r-- root/root       153 2024-10-04 16:24 ./usr/include/world.h
drwxrwxr-x root/root         0 2024-10-04 23:15 ./usr/lib/
drwxrwxr-x root/root         0 2024-10-04 23:15 ./usr/lib/cmake/
drwxrwxr-x root/root         0 2024-10-04 23:15 ./usr/lib/cmake/WorldLibrary/
-rw-r--r-- root/root       949 2024-10-04 23:01 ./usr/lib/cmake/WorldLibrary/WorldLibraryConfig.cmake
-rw-r--r-- root/root      1977 2024-10-04 23:01 ./usr/lib/cmake/WorldLibrary/WorldLibraryConfigVersion.cmake
-rw-r--r-- root/root      1369 2024-10-04 23:01 ./usr/lib/cmake/WorldLibrary/WorldLibraryTargets-release.cmake
-rw-r--r-- root/root      3543 2024-10-04 23:01 ./usr/lib/cmake/WorldLibrary/WorldLibraryTargets.cmake
-rw-r--r-- root/root      1566 2024-10-04 23:01 ./usr/lib/libworld.a
lrwxrwxrwx root/root         0 2024-10-04 23:15 ./usr/lib/libworld.so -> libworld.so.1

$ dpkg -c world-1.0.0-Linux-x86_64-Runtime.deb
drwxrwxr-x root/root         0 2024-10-04 23:15 ./usr/
drwxrwxr-x root/root         0 2024-10-04 23:15 ./usr/lib/
lrwxrwxrwx root/root         0 2024-10-04 23:15 ./usr/lib/libworld.so.1 -> libworld.so.1.0.0
-rw-r--r-- root/root     15208 2024-10-04 23:01 ./usr/lib/libworld.so.1.0.0
```

```bash
cpack -G DEB -D CPACK_COMPONENTS_ALL=Runtime
cpack -G DEB -D CPACK_COMPONENTS_ALL=Development
find . -name "*.deb" -exec sh -c 'echo "Contents of {}:"; dpkg -c {}' \;
DESTDIR=$HOME/tmp cmake -DCOMPONENT=Runtime -P cmake_install.cmake
```
