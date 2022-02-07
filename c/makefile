# > cd git/addons/math/arrayfire/c
# > rm base ; make target=base or sparse or ...
# > ./base or sparse or ...
LIBS=-lafcpu
LIB_PATHS=-L/opt/arrayfire/lib64
INCLUDES=-I/opt/arrayfire/include

CC=g++	$(COMPILER_OPTIONS)
COMPILER_OPTIONS=-std=c++11 -g

#CC=gcc	$(COMPILER_OPTIONS)
#COMPILER_OPTIONS=-g

$(target): $(target).c 
	$(CC) $(target).c -o $(target) $(INCLUDES)	$(LIBS)	$(LIB_PATHS)

