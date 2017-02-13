cmake_minimum_required(VERSION 2.8)

project(rsb-chat-2)

find_package(RSB REQUIRED)
find_package(RST REQUIRED) # for data types

add_definitions(${RST_CFLAGS})
include_directories(SYSTEM
                    ${RSB_INCLUDE_DIRS}
                    ${RST_INCLUDE_DIRS})
link_directories(${RSB_LIBRARY_DIRS}
                 ${RST_LIBRARY_DIRS})

set(PROGRAM_NAME rsb-chat-2)
add_executable(${PROGRAM_NAME} src/chat.cpp)
target_link_libraries(${PROGRAM_NAME} ${RSB_LIBRARIES}
                                      ${RST_LIBRARIES})

install(TARGETS ${PROGRAM_NAME}
        RUNTIME DESTINATION bin)
