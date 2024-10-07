# cpack-exercise

Two `.deb` packages for the library are built for VxWorks 24.03 using `CPack`: one for `Runtime` and one for `Development`

## CMake

### Library

```bash
$ ~/WindRiver-24.03/wrenv.linux
$ export WIND_CC_SYSROOT=$WIND_HOME/workspace/rpi_4_vsb
$ mkdir world/build && cd world/build

$ cmake .. -DCMAKE_TOOLCHAIN_FILE=$WIND_CC_SYSROOT/mk/toolchain.cmake
$ cmake --build .
$ file libworld.so.1.0.0
libworld.so.1.0.0: ELF 64-bit LSB shared object, ARM aarch64, version 1 (SYSV), dynamically linked, not stripped

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

### Binary

Binary uses `find_package(WorldLibrary)` to find it

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

## CPack

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
CPack: - package: /home/akholodn/github/razr/cpack-exercise/world/build/world-1.0.0-VxWorks-aarch64-Development.deb generated.
CPack: - package: /home/akholodn/github/razr/cpack-exercise/world/build/world-1.0.0-VxWorks-aarch64-Runtime.deb generated.


# Development Package content
$ dpkg -c world-1.0.0-VxWorks-aarch64-Development.deb 
drwxrwxr-x root/root         0 2024-10-07 12:15 ./usr/
drwxr-xr-x root/root         0 2024-10-07 12:15 ./usr/include/
-rw-r--r-- root/root       153 2024-10-04 16:24 ./usr/include/world.h
drwxrwxr-x root/root         0 2024-10-07 12:15 ./usr/lib/
drwxrwxr-x root/root         0 2024-10-07 12:15 ./usr/lib/cmake/
drwxrwxr-x root/root         0 2024-10-07 12:15 ./usr/lib/cmake/WorldLibrary/
-rw-r--r-- root/root       949 2024-10-07 12:12 ./usr/lib/cmake/WorldLibrary/WorldLibraryConfig.cmake
-rw-r--r-- root/root      1861 2024-10-07 12:12 ./usr/lib/cmake/WorldLibrary/WorldLibraryConfigVersion.cmake
-rw-r--r-- root/root      1393 2024-10-07 12:12 ./usr/lib/cmake/WorldLibrary/WorldLibraryTargets-release.cmake
-rw-r--r-- root/root      4183 2024-10-07 12:12 ./usr/lib/cmake/WorldLibrary/WorldLibraryTargets.cmake
-rw-r--r-- root/root      1342 2024-10-07 12:12 ./usr/lib/libworld.a
lrwxrwxrwx root/root         0 2024-10-07 12:15 ./usr/lib/libworld.so -> libworld.so.1


# Runtime Package content
$ dpkg -c world-1.0.0-VxWorks-aarch64-Runtime.deb 
drwxrwxr-x root/root         0 2024-10-07 12:15 ./usr/
drwxrwxr-x root/root         0 2024-10-07 12:15 ./usr/lib/
lrwxrwxrwx root/root         0 2024-10-07 12:15 ./usr/lib/libworld.so.1 -> libworld.so.1.0.0
-rwxr-xr-x root/root     70560 2024-10-07 12:12 ./usr/lib/libworld.so.1.0.0
```

## Debian

```bash
$ dh_make --createorig -s -p world_1.0.0

# uncomment CMake rules
vi debian/rules
override_dh_auto_configure:
        dh_auto_configure -- \
        -DCMAKE_LIBRARY_PATH=$(DEB_HOST_MULTIARCH)

$ dpkg-buildpackage -S

$ cp ../world_1.0.0-1.dsc $HOME/tmp
$ cd $HOME/tmp
$ dpkg-source -x world_1.0.0-1.dsc

$ dpkg-buildpackage -us -uc
$ ls obj-x86_64-linux-gnu/
```

```bash
$ dpkg-buildpackage -b
$ cpack -G DEB -D CPACK_COMPONENTS_ALL=Runtime
$ cpack -G DEB -D CPACK_COMPONENTS_ALL=Development
$ find . -name "*.deb" -exec sh -c 'echo "Contents of {}:"; dpkg -c {}' \;
$ DESTDIR=$HOME/tmp cmake -DCOMPONENT=Runtime -P cmake_install.cmake
```

