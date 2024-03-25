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
	STRINGS 0x0805792c
    {
		strings.o (+RW +ZI)
    }
	EVERYTHING_ELSE 0x0806d4e0
    {
		rest_of_the_game.o (+Code)
    }
}