CMAKE_MINIMUM_REQUIRED(VERSION 2.8)
PROJECT(mmdbridge) # .sln

# for UTF8 source codes
add_compile_options("$<$<C_COMPILER_ID:MSVC>:/utf-8>")
add_compile_options("$<$<CXX_COMPILER_ID:MSVC>:/utf-8>")

# shared compiler options
SET(CMAKE_CXX_FLAGS "/EHsc /wd4267"
    )
# embeded pdb 
SET(CMAKE_CXX_FLAGS_DEBUG
    /Z7
    )

SET(CMAKE_INSTALL_PREFIX_RELEASE
    ${CMAKE_INSTALL_PREFIX}-release
    )
    
# path settings
#FIND_PACKAGE(PythonLibs REQUIRED)
SET(PYTHON_INCLUDE_DIRS
    ${CMAKE_INSTALL_PREFIX}/include/python3.10)
SET(PYTHON_LIBRARIES
    ${CMAKE_INSTALL_PREFIX}/lib/python310.lib)

#FIND_PACKAGE(pybind11 REQUIRED)
SET(pybind11_INCLUDE_DIRS
    ${CMAKE_INSTALL_PREFIX}/include
    ${PYTHON_INCLUDE_DIRS}
    )

if(DEFINED ENV{MMD_DIR})
    SET(MMD_DIR
        $ENV{MMD_DIR}
        )
else()
    GET_FILENAME_COMPONENT(MMD_DIR
        ${CMAKE_CURRENT_LIST_DIR}/MikuMikuDance_x64
        ABSOLUTE
        )
endif()

#FIND_PACKAGE(ilmbase REQUIRED)
SET(ilmbase_INCLUDE_DIRS 
    ${CMAKE_INSTALL_PREFIX}/include/Imath)
#FIND_PACKAGE(Alembic REQUIRED)
SET(ALEMBIC_INCLUDE_DIRS
    ${CMAKE_INSTALL_PREFIX}/include)
SET(ALEMBIC_LIBRARIES
    ${CMAKE_INSTALL_PREFIX}/lib/Alembic.lib
    ${CMAKE_INSTALL_PREFIX}/lib/hdf5.lib
    ${CMAKE_INSTALL_PREFIX}/lib/hdf5_hl.lib
    ${CMAKE_INSTALL_PREFIX}/lib/Imath-3_1.lib
    ${CMAKE_INSTALL_PREFIX}/lib/zlib.lib
    ${CMAKE_INSTALL_PREFIX}/lib/szip.lib)

# projects
ADD_SUBDIRECTORY(src)

# additional install files
INSTALL(FILES 
    ${CMAKE_INSTALL_PREFIX}/bin/python310.dll
    ${CMAKE_INSTALL_PREFIX}/bin/Alembic.dll
    ${CMAKE_INSTALL_PREFIX}/bin/hdf5.dll
    ${CMAKE_INSTALL_PREFIX}/bin/hdf5_hl.dll
    ${CMAKE_INSTALL_PREFIX}/bin/imath-3_1.dll
    ${CMAKE_INSTALL_PREFIX}/bin/zlib1.dll
    ${CMAKE_INSTALL_PREFIX}/bin/szip.dll
    DESTINATION ${MMD_DIR}
    )
FILE(GLOB python_sciprts Release/Win32/*.py
    )
INSTALL(FILES ${python_sciprts}
    DESTINATION ${MMD_DIR}
    )

FILE(INSTALL ${CMAKE_INSTALL_PREFIX}/tools/python3/Lib DESTINATION ${MMD_DIR})

INSTALL(DIRECTORY Release/Win32/alembic_assign_scripts 
    DESTINATION ${MMD_DIR}
    )
install(DIRECTORY 
    DESTINATION ${MMD_DIR}/out)

