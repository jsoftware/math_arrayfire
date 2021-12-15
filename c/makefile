LIBS=-lafcpu
LIB_PATHS=-L/opt/arrayfire/lib64
INCLUDES=-I/opt/arrayfire/include
CC=g++ $(COMPILER_OPTIONS)
COMPILER_OPTIONS=-std=c++11 -g

all: ar.c 
	$(CC) ar.c -o test $(INCLUDES) $(LIBS) $(LIB_PATHS)
