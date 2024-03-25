cmake_minimum_required(VERSION 3.17)
project(compress)

set(CMAKE_CXX_STANDARD 14)
include_directories(jcalg1)

add_executable(compress main.cpp)

target_link_libraries(compress ${CMAKE_SOURCE_DIR}/jcalg1/jcalg1_static.lib)
