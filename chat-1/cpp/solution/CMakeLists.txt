cmake_minimum_required(VERSION 2.8)

project(rsb-chat-1)

find_package(RSB REQUIRED)

include_directories(${RSB_INCLUDE_DIRS})
link_directories(${RSB_LIBRARY_DIRS})

set(PROGRAM_NAME rsb-chat-1)
add_executable(${PROGRAM_NAME} src/chat-1.cpp)
target_link_libraries(${PROGRAM_NAME} ${RSB_LIBRARIES})