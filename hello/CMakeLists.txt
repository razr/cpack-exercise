cmake_minimum_required(VERSION 3.10)
project(HelloProject VERSION 1.0.0 LANGUAGES C)

# Find the WorldLibrary package
find_package(WorldLibrary REQUIRED)

# Create the executable
add_executable(hello src/main.c)

# Link against the WorldLibrary
target_link_libraries(hello PRIVATE WorldLibrary::world)

# Specify include directories if necessary
target_include_directories(hello PRIVATE ${WorldLibrary_INCLUDE_DIRS})

