
#include <stdio.h>

void A();
void B();
void C();
void D();
void E();
void F();

int main(int argc, char** argv)
{
	A();
	C();
	E();
	F();
	return 0;
}

void A()
{
	//printf("Func A\n");
}

void B()
{
	//printf("Func B\n");
	C();
}

void C()
{
	//printf("Func C\n");
	D();
	E();
}

void D()
{
	//printf("Func D\n");
}

void E()
{
	//printf("Func E\n");
}

void F()
{
	printf("Func F\n");
}

