set CMAKE="cmake.exe"
set BUILD_DIR="build_vs2017_64"

if not exist %BUILD_DIR% mkdir %BUILD_DIR%
pushd %BUILD_DIR%
%CMAKE% -D CMAKE_INSTALL_PREFIX=%VCPKG_DIR%/installed/x64-windows-release -G "Visual Studio 15 2017 Win64" .. 
popd
