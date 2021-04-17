cmake_minimum_required(VERSION 3.5)
project(
	cpp-shiva
	VERSION 0.1
	DESCRIPTION "C / C++ debugging and testing - may shiva rattle your bugs "
	LANGUAGES C CXX)

set(SRC_D src)
set(TESTS_D tests)

# Only do these if this is the main project, and not if it is included through add_subdirectory
if(CMAKE_PROJECT_NAME STREQUAL PROJECT_NAME)
	# global compilation standards
	#set(CMAKE_C_STANDARD 99)
	#set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -Wall -Werror -Wextra")
	
	#set(CMAKE_CXX_STANDARD 98)
	#set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -Wall -Werror -Wextra")
	set(CMAKE_C_FLAGS "-Wall -Wextra -Werror")
	set(CMAKE_C_FLAGS_DEBUG "-g -fsanitize=address")
	set(CMAKE_C_FLAGS_RELEASE "-O3")
	set(CMAKE_C_FLAGS_RELWITHDEBINFO "-g")

	set(CMAKE_CXX_FLAGS "-Wall -Wextra -Werror")
	set(CMAKE_CXX_FLAGS_DEBUG "-g -fsanitize=address")
	set(CMAKE_CXX_FLAGS_RELEASE "-O3")
	set(CMAKE_CXX_FLAGS_RELWITHDEBINFO "-g")

	option(BUILD_TESTING "Build unittests and standlone torture 'apps' " OFF)
	if(BUILD_TESTING)
		include(CTest)
	endif()

	if(CMAKE_BUILD_TYPE STREQUAL "Debug" OR BUILD_TESTING)
		set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -fsanitize=address")
		set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -fsanitize=address")

		add_compile_definitions(DEBUG=1)
		add_compile_definitions(DEBUG_FILE="./minishell.log")
	else()
		add_compile_definitions(DEBUG=0)
	endif()

	# Let's nicely support folders in IDEs
	set_property(GLOBAL PROPERTY USE_FOLDERS ON)

	# Add custom rule to dispose of generateable files from .gitignore
	add_custom_target(distclean
	  COMMAND ${CMAKE_COMMAND} -E echo "Cleaning all files not in source control."
	  COMMAND git clean -d -f -X
	    WORKING_DIRECTORY ${vector_SOURCE_DIR}
	)
endif()

# FetchContent 
include(FetchContent)

# Target directories
add_subdirectory(${SRC_D})

# Testing only available if this is the main app
# Emergency override MODERN_CMAKE_BUILD_TESTING provided as well
if((CMAKE_PROJECT_NAME STREQUAL PROJECT_NAME OR MODERN_CMAKE_BUILD_TESTING)
   AND BUILD_TESTING)
  add_subdirectory(${TESTS_D})
endif()
