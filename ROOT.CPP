#include<conio.h>
#include<stdio.h>
#include<dos.h>
#include<process.h>
void main()
{
	clrscr();
	char buff[7200];
	int i,j;
	asm{
		mov al,0x0
		mov dx,0x13
		lea bx,buff
		mov cx,0xE
		int 0x25
		jnc ok
	}
	printf("\nFloppy not found.");
	getch();
	exit(0);
	ok:
	for(i=0;i<224;i++)
	{
		if(buff[i*32]==0x0)
			continue;
		if(buff[i*32]==0x05)
			continue;
		if(buff[i*32]==0xe5)
			continue;
		if(buff[i*32]==0x2e)
			continue;
		if((buff[i*32+0x0b]&4)==4)
			continue;

		if((buff[i*32+0x0b]&8)==8)
			continue;

		printf("\nFile name:");
		for(j=0x0;j<0x08;j++)
		{
			printf("%c",buff[i*32+j]);
		}
		printf("\nFile extention:");
		for(j=0x08;j<0x0b;j++)
		{
			printf("%c",buff[i*32+j]);
		}
		printf("\nFILE EXTENTION:");
		if((buff[i*32+0x0b]&1)==1)
			printf("\nReadonly");
		if((buff[i*32+0x0b]&2)==2)
			printf("\nHidden");
		if((buff[i*32+0x0b]&4)==4)
			printf("\nSystem File");
		if((buff[i*32+0x0b]&8)==8)
			printf("\nVolume lebal");
		if((buff[i*32+0x0b]&16)==16)
			printf("\nDirectory");
		if((buff[i*32+0x0b]&32)==32)
			printf("\nArchive");

		printf("\nTIME CREATED:");
		j=*(int*)&buff[i*32+0x16];
		printf(" %d:",j>>11);
		printf("%d:",(j>>5)&0x03f);
		printf("%d",j&0x01f);

		printf("\nDATE CREATED:");
		j=*(int*)&buff[i*32+0x18];
		printf(" %d:",j&0x1f);
		printf("%d:",(j>>5)&0xf);
		printf("%d",(j>>9)+1980);
		printf("\n");
	}
	getch();
}