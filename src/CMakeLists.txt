# Note that headers are optional, and do not affect add_library, but they will not
# show up in IDEs unless they are listed in add_library.

# File glob containing all sources files
file(GLOB_RECURSE SRC_LIST CONFIGURE_DEPENDS "${cpp-shiva_SOURCE_DIR}/src/*.(c|h|cpp|hpp)")

# Make an automatic library - will be static or dynamic based on user setting
add_library(cpp-shiva ${SRC_LIST} ${HEADER_LIST})

# Set the compilation standards
set_property(TARGET cpp-shiva PROPERTY C_STANDARD 99)
set_property(TARGET cpp-shiva PROPERTY CXX_STANDARD 98)

# We need this directory, and users of our library will need it too
target_include_directories(cpp-shiva PUBLIC ../includes)

# This depends on (header only)
#target_link_libraries(cpp-shiva PRIVATE )

# IDEs should put the headers in a nice place
source_group(
  TREE "${PROJECT_SOURCE_DIR}/includes"
  PREFIX "Header Files"
  FILES ${HEADER_LIST})
