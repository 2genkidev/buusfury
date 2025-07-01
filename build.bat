@echo off

:: Make the build directory
mkdir build

echo ::: Building tools :::
cmake -B tools/compress/build -DCMAKE_BUILD_TYPE=Release -DCMAKE_EXE_LINKER_FLAGS="/SAFESEH:NO" -A Win32 tools/compress
cmake --build tools/compress/build

echo ::: Compressing assets :::
call grit assets\intro.bmp -gB8 -p! -ftb -gb -o build\asset_intro
call grit assets\splash.bmp -gB8 -p! -ftb -gb -o build\asset_splash
call grit assets\dialogbox.bmp -gB8 -p! -ftb -gb -o build\asset_dialogbox
call grit assets\dialogbox_small.bmp -gB8 -p! -ftb -gb -o build\asset_dialogbox_small
call tools\compress\build\Debug\compress.exe build\asset_intro.img.bin build\asset_intro.compressed
:: Not sure why these zeroes are there...
call tools\compress\build\Debug\compress.exe build\asset_splash.img.bin build\asset_splash.compressed 20516
call tools\compress\build\Debug\compress.exe build\asset_dialogbox.img.bin build\asset_dialogbox.compressed 788
call tools\compress\build\Debug\compress.exe build\asset_dialogbox_small.img.bin build\asset_dialogbox_small.compressed

:: armasm doesn't support incbin with offsets and sizes. So we'll have to make our own.
echo ::: Including missing pieces :::
call tools\incbin.bat baserom.gba 0x0158 0x3d4d0
call tools\incbin.bat baserom.gba 0x03d5b8 0x03d63c
call tools\incbin.bat baserom.gba 0x03d63c 0x03d730
call tools\incbin.bat baserom.gba 0x03d740 0x03d784
call tools\incbin.bat baserom.gba 0x03d784 0x049114
call tools\incbin.bat baserom.gba 0x049120 0x055620
call tools\incbin.bat baserom.gba 0x0561c4 0x05792c
call tools\incbin.bat baserom.gba 0x06d4e0 0x071758
:: <immediately after dialogboxes>
call tools\incbin.bat baserom.gba 0x071c90 0x3be3d4
:: <rest of the game>
call tools\incbin.bat baserom.gba 0x3c33f8 0x7b89a8
:: <null bytes>
call tools\incbin.bat baserom.gba 0x7b89a8 0x800000

echo ::: Building ASM files :::
armasm		asm/buu.s -o build/buu.o
armasm		asm/ewram.s -o build/ewram.o
armasm		asm/iwram.s -o build/iwram.o
armasm		asm/rest_of_the_game.s -o build/rest_of_the_game.o

echo ::: Compiling source files :::
armcpp		-c src/strings.cpp -o build/strings.o

echo ::: Linking ^& Building image :::
armlink		build/strings.o build/buu.o build/rest_of_the_game.o build/ewram.o build/iwram.o -noremove -scatter scatter.ld -o build/buu.axf
fromelf    	build/buu.axf -bin -o build/output
ren build\output\ROM_START image.gba
move build\output\image.gba image.gba

echo ::: Comparing Images :::
::call fc /b "baserom.gba" "image.gba"
call tools\sha1.bat image.gba

:: Clean
rmdir /S /Q build