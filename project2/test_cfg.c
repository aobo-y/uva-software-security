
#include <stdio.h>

int main(int argc, char** argv)
{
	int i, j;
    char str[10][50], temp[50];

    printf("Enter 10 words (longer than 3 characters):\n");

    for(i=0; i<10; ++i)
        scanf("%s[^\n]",str[i]);


	for(i=0; i<10; ++i) {
		if( strcmp(str[i], "") == 0 ) {
			printf("Please enter valid words.\n");
			return 0;
		} else if( strlen(str[i]) < 3 ) {
			printf("Please enter valid words (longer than 3 characters).\n");
			return 0;
		} else {
			continue;
		}
	}


    for(i=0; i<9; ++i)
        for(j=i+1; j<10 ; ++j)
        {
            if(strcmp(str[i], str[j])>0)
            {
                strcpy(temp, str[i]);
                strcpy(str[i], str[j]);
                strcpy(str[j], temp);
            }
        }

    printf("\nIn lexicographical order: \n");
    for(i=0; i<10; ++i)
    {
        puts(str[i]);
    }

    return 0;
}
