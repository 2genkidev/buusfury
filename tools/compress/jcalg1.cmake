message(STATUS "Searching for JCALG1")

# searching for include directory
find_path(JCALG1_INCLUDE_DIR jcalg1.h)

# searching for library file
find_library(JCALG1_LIBRARY jcalg1_import)

if (JCALG1_INCLUDE_DIR AND JCALG1_LIBRARY)
    message(STATUS "Library JCALG1 found!")
    # you may need that if further action in your CMakeLists.txt depends
    # on detecting your library
    set(JCALG1_FOUND TRUE)

    # you may need that if you want to conditionally compile some parts
    # of your code depending on library availability
    add_definitions(-DHAVE_LIBSIFTGPU=1)

    # those two, you really need
    include_directories(${SIFTGPU_INCLUDE_DIR})
    set(YOUR_LIBRARIES ${YOUR_LIBRARIES} ${SIFTGPU_LIBRARY})
endif ()