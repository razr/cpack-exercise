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

set_target_properties(
    world
    PROPERTIES
    VERSION "${CMAKE_PROJECT_VERSION}"
    SOVERSION "${CMAKE_PROJECT_VERSION_MAJOR}"
)

add_library(world_static STATIC)
target_sources(world_static PRIVATE src/world.c)
target_include_directories(world_static PUBLIC ${PROJECT_SOURCE_DIR}/include)
set_target_properties(world_static PROPERTIES OUTPUT_NAME world)
set_target_properties(world_static PROPERTIES LINKER_LANGUAGE C)

# Specify installation directories
install(TARGETS world
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
)

install(TARGETS world_static
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
)

install(DIRECTORY ${PROJECT_SOURCE_DIR}/include/
    DESTINATION include
)
