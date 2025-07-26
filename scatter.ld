LOAD_ROM_2 0x02000000
{
    EWRAM 0x02000000 0x40000
    {
        ewram.o (+RW)
    }
}
LOAD_ROM_3 0x03000000
{
    IWRAM 0x03000000 0x8000
    {
        iwram.o (+RW)
    }
}
ROM_LOAD 0x08000000 {
	ROM_START 0x08000000
    {
        buu.o (GameStart, Head, Init)
    }
	MEMORY_START 0x0803d4d0
	{
		buu.o (GBARam)
	}
	AFTER_LIBS 0x08049114
	{
		buu.o (AfterLibs)
	}
	COLOR_TRANSFORMATIONS 0x0805672c
    {
		color_transforms.o (.constdata)
    }
	STRINGS 0x0805792c
    {
		strings.o (+RW +ZI)
    }
	EVERYTHING_ELSE 0x0806d4e0
    {
		rest_of_the_game.o (+Code)
    }
}