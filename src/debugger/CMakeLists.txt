# File glob containing all sources files
file(GLOB SRC_LIST CONFIGURE_DEPENDS "*.c")

# Make an automatic library - will be static or dynamic based on user setting
add_library(shiva-debugger ${SRC_LIST})

# Set the compilation standards
set_property(TARGET shiva-debugger PROPERTY C_STANDARD 99)

# We need this directory, and users of our library will need it too
target_include_directories(shiva-debugger PUBLIC ./)
