#include<stdio.h>
#include<windows.h>
#include<winuser.h>
#include <fstream>
#include <iostream>
#include <vector>
#include"jcalg1.h"


void *_stdcall
AllocFunc(DWORD
nMemSize)
{
return (void *)GlobalAlloc(GMEM_FIXED,nMemSize);
}

bool _stdcall

DeallocFunc(void *pBuffer) {
    GlobalFree((HGLOBAL) pBuffer);
    return true;
}

bool _stdcall
CallbackFunc(DWORD
pSourcePos,
DWORD pDestinationPos
)
{
//printf("\r %u",(unsigned int)pSourcePos);
return true;
}

std::vector<char> GetDataFromFile(const char *filename) {
    std::ifstream file(std::string(filename), std::ios::binary | std::ios::ate);

    if (!file.is_open()) {
        std::cerr << "Error opening file '" << filename << "'" << std::endl;
        exit(1);
    }

    std::streamsize size = file.tellg();
    file.seekg(0, std::ios::beg);

    std::vector<char> buffer(size);

    // Read the file into the buffer
    if (!file.read(buffer.data(), size)) {
        std::cerr << "Error reading file" << std::endl;
        exit(1);
    }

    return std::move(buffer);
}

void saveBufferToFile(std::vector<char> &buffer, const std::string &filePath, size_t minSize) {
    std::ofstream file(filePath, std::ios::binary);

    if (!file) {
        std::cerr << "Unable to open file '" << filePath << "' for writing" << std::endl;
        exit(1);
    }
	
	size_t bufferSize = buffer.size();
    file.write(buffer.data(), bufferSize);
	
	if (minSize && bufferSize < minSize) {
		size_t remainingBytesToFill = minSize - bufferSize;
		std::vector<char> padding(remainingBytesToFill, 0); // Fill with zeroes
		file.write(padding.data(), padding.size());
	}

    if (!file) {
        std::cerr << "Error occurred while writing to file." << std::endl;
        exit(1);
    }
	
}

std::vector<char> CompressFile(char *filename) {

    std::vector<char> buffer = GetDataFromFile(filename);
    std::vector<char> output(JCALG1_GetNeededBufferSize(buffer.size()));

    std::cout << "Compressing... ";
    unsigned int nCompressedSize =
            JCALG1_Compress((void *) buffer.data(), buffer.size(), (void *) output.data(), 1024 * 1024, &AllocFunc,
                            &DeallocFunc,
                            &CallbackFunc, true);

    if (nCompressedSize == 0) {
        std::cerr << "Compression failed" << std::endl;
        exit(1);
    }

    std::cout << "Done!" <<std::endl;

    output.resize(nCompressedSize);

    return std::move(output);

}

int main(int argc, char **argv) {

    if (argc < 3){
        printf("Compress utility for Buu's Fury\r\n");
        printf("Usage: compress <infile> <outfile> [<min size>]\r\n");
        exit(1);
    }

    std::vector<char> newBuffer = CompressFile(argv[1]);
    // Header for Buu's Fury looks like this:
    newBuffer[0] = 0;
    newBuffer[1] = 0;
    newBuffer.insert(newBuffer.begin(), {1, 0});

    // Remove checksum
    newBuffer.erase(newBuffer.begin() + 8, newBuffer.begin() + 8 + 4);
    
	if (argc == 3) {
		saveBufferToFile(newBuffer, argv[2], 0);
	} else if (argc == 4) { // TODO: Kinda hacky, we don't have named params yet...
		size_t minSize;
		sscanf(argv[3], "%lu", &minSize);
		saveBufferToFile(newBuffer, argv[2], minSize);
	}
	
    return 0;
}


