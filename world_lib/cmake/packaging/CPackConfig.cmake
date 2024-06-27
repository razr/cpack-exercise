# Include CPack configuration
include(InstallRequiredSystemLibraries)

set(CPACK_PACKAGE_NAME "world")
set(CPACK_PACKAGE_VERSION "1.0.0")
set(CPACK_PACKAGE_DESCRIPTION_SUMMARY "World Library")
set(CPACK_PACKAGE_VENDOR "Your Name")
set(CPACK_PACKAGE_CONTACT "your.email@example.com")
set(CPACK_PACKAGE_FILE_NAME "${CPACK_PACKAGE_NAME}-${CPACK_PACKAGE_VERSION}-${CMAKE_SYSTEM_NAME}-${CMAKE_SYSTEM_PROCESSOR}")


# Specify the generator for Debian packages
set(CPACK_GENERATOR "DEB")

# Set Debian package specific settings
set(CPACK_DEBIAN_PACKAGE_MAINTAINER "your.email@example.com") # Required
set(CPACK_DEBIAN_PACKAGE_SECTION "libs")
set(CPACK_DEBIAN_PACKAGE_PRIORITY "optional")
set(CPACK_DEBIAN_PACKAGE_VERSION "${CPACK_PACKAGE_VERSION}")
set(CPACK_DEBIAN_PACKAGE_RELEASE "1")
set(CPACK_DEBIAN_ARCHITECTURE ${CMAKE_SYSTEM_PROCESSOR})
set(CPACK_DEBIAN_ENABLE_COMPONENT_DEPENDS ON)

set(CPACK_DEB_COMPONENT_INSTALL ON)
set(CPACK_DEBIAN_PACKAGE_SHLIBDEPS ON)

include(CPack)
# Define components
cpack_add_component(Runtime
    DISPLAY_NAME "Runtime"
    DESCRIPTION "World Library Runtime"
)

cpack_add_component(Development
    DISPLAY_NAME "Development"
    DESCRIPTION "World Library Development Files"
    DEPENDS Runtime
)
