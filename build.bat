@echo off

:: Make the build directory
mkdir build

echo ::: Building tools :::
cmake -B tools/compress/build -DCMAKE_BUILD_TYPE=Release -DCMAKE_EXE_LINKER_FLAGS="/SAFESEH:NO" -A Win32 tools/compress
cmake --build tools/compress/build

echo ::: Compressing assets :::
call grit assets\intro.bmp -gB8 -p! -ftb -gb -o build\asset_intro
call tools\compress\build\Debug\compress.exe build\asset_intro.img.bin build\asset_intro.compressed

:: armasm doesn't support incbin with offsets and sizes. So we'll have to make our own.
echo ::: Including missing pieces :::
call tools\incbin.bat baserom.gba 0x04 0xA0
call tools\incbin.bat baserom.gba 0x0158 0x3d4d0
call tools\incbin.bat baserom.gba 0x03d548 0x03d5b8
call tools\incbin.bat baserom.gba 0x03d5b8 0x03d63c
call tools\incbin.bat baserom.gba 0x03d63c 0x03d730
call tools\incbin.bat baserom.gba 0x03d740 0x03d784
call tools\incbin.bat baserom.gba 0x03d784 0x049114
call tools\incbin.bat baserom.gba 0x049120 0x055620
call tools\incbin.bat baserom.gba 0x0561c4 0x05792c
call tools\incbin.bat baserom.gba 0x06d4e0 0x800000

echo ::: Building ASM files :::
armasm		asm/buu.s -o build/buu.o
armasm		asm/rest_of_the_game.s -o build/rest_of_the_game.o

echo ::: Compiling source files :::
armcpp		-c src/strings.cpp -o build/strings.o

echo ::: Linking ^& Building image :::
armlink		build/strings.o build/buu.o build/rest_of_the_game.o -noremove -scatter scatter.ld -o build/buu.axf
fromelf    	build/buu.axf -bin -o image.gba

echo ::: Comparing Images :::
:: call fc /b "baserom.gba" "image.gba"
call tools\sha1.bat image.gba

:: Clean
rmdir /S /Q build