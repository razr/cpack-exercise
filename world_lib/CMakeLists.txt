cmake_minimum_required(VERSION 3.10)
project(WorldLibrary VERSION 1.0.0 LANGUAGES C)

# Add the library
add_library(world SHARED)

# Specify the library sources
target_sources(world PRIVATE src/world.c)

# Specify the include directories
target_include_directories(world PUBLIC
    ${PROJECT_SOURCE_DIR}/include
)

# Specify installation directories
install(TARGETS world
    LIBRARY DESTINATION lib
)

install(DIRECTORY ${PROJECT_SOURCE_DIR}/include/
    DESTINATION include
)
