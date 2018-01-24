test:main.o file1.o
	gcc main.o file1.o -o test
main.o:main.c file1.h
	gcc -c main.c -o main.o
file1.o:file1.c file1.h 
	gcc -c file1.c -o file1.o
clean:
	rm -rf *.o test
