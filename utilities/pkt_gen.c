#include <stdio.h>
#include <string.h>
#include <stdlib.h>

int main(int argc, char *argv[])
{
    FILE *fp = NULL;
    char filename[50] = {0};
    unsigned char *data = NULL;
    unsigned int len = 0,index = 0, val = 0;

    if(argc < 2)
    {
        printf("\nFile extension should be .bin\nFILENAME : ");
        scanf("%s",filename);
    }
    else
    {
        strcpy(filename, argv[1]);
    }

    if ((fp =fopen(filename,"wb")) == 0)
    {
        printf("\n Error opening file \n");
        exit(1);
    }

    if(argc < 3)
    {
        printf("Enter the Length of bytes to read : ");
	scanf("%d",&len);

	printf("Enter %u Bytes of data : \n",len);
	data = (unsigned char *)malloc(len);

	printf("Enter all the %d values in hexadecimal with each value seperated by a space\n", len);
	for(index = 0; index < len; index++)
	{
	    scanf("%x",&val);
	    data[index] = (unsigned char)val;
	    printf("data[%d] = %x\n",index, data[index]);
	}
    }
    else
    {
        len = argc - 2;
        data = (unsigned char *)malloc(len);

        for(index = 0; index < len; index++)
        {
            val = strtoul(argv[index+2],NULL,16);
            data[index] = (unsigned char)val;
            printf("data[%d] = %x\n",index, data[index]);
        }
    }

    fwrite(data,1,len,fp);
    free(data);
    fclose(fp);
    return 0;
}
