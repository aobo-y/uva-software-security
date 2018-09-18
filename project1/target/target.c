#include <stdio.h>
#include <stdlib.h>

int main(int argc, char** argv)
{
	double dblData[20];
	int nCntDbl;
	float flData[20];
	int nCntFl;
	char* strTestString = "String Test\n";
	char strData[255];
	int nStrLen;
	int bGoWrong = (argc > 1);

	int i;

	for( i = 0; i < 20; i++ ){
		dblData[i] = (double)rand()/i+1;
		nCntDbl++;
	}

	for( i = 0; i < 20; i++ ){
		flData[i] = (float)rand()/i+1;
		nCntFl++;
	}

	for( i = 0; i < strlen(strTestString ); i++ ) {
		strData[i] = strTestString [i];
		nStrLen++;
	}
	strData[i] = 0;

	// access violation

	if( bGoWrong ) {
		printf("gowrong\n");
		char* pbuf = (char*)dblData;
		for( i = 0; i < strlen(strTestString); i++ ) {
			pbuf[i] = strTestString[i];
		}
	}


	printf("%f %lf %s\n", dblData[1], flData[2], strData);

	return 0;
}
