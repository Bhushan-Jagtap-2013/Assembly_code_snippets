#include<conio.h>
#include<stdio.h>
#include<stdlib.h>
#include<dos.h>
void main()
{
	clrscr();
	char buff[512];
	union REGS regs;

	regs.h.al=0;
	regs.x.cx=1;
	regs.x.dx=0;
	regs.x.bx= FP_OFF(buff);
	int86(0x25,&regs,&regs);

	if(regs.x.cflag==1)
	{
		printf("\nFloppy not found.");
		exit(0);
	}
	printf("\nFloppy Found:\n");
	printf("\nOEM name and Version\t:\t");
	for(int i=0x3;i<0xB;i++)
		printf("%c",buff[i]);

	printf("\nByte per sector		:\t");
	printf("%d",*(int*)&buff[0x0b]);

	printf("\nSector per cluster		:\t");
	printf("%d",(int)buff[0x0d]);

	printf("\nReserved sector		:\t");
	printf("%d",*(int*)&buff[0xe]);

	printf("\nNo of FAT 			:\t");
	printf("%d",(int)buff[0x010]);

	printf("\nNo of root directory Entries	:\t");
	printf("%d",*(int*)&buff[0x011]);

	printf("\nTotal sector in logical volume :\t");
	printf("%d",*(int*)&buff[0x013]);

	printf("\nMedia discriptor byte		  :\t");
	printf("%4x",buff[0x15]);

	printf("\nNo of sector per FAT		   :\t");
	printf("%d",*(int*)&buff[0x016]);

	printf("\nSector per track		    :\t");
	printf("%d",*(int*)&buff[0x018]);

	printf("\nNo of heads			     :\t");
	printf("%d",*(int*)&buff[0x01a]);

	printf("\nNo of Hidden sectors		      :\t");
	printf("%ld",*(long int*)&buff[0x01c]);

	printf("\nPhysical drive no. 		       :\t");
	printf("%d",(int)buff[0x024]);

	printf("\nExtended boot signature record        :\t");
	printf("%x",buff[0x026]);

	printf("\nVolume ID				 :\t");
	for(i=0x27;i<0x2b;i++)
	{
		printf("%x",buff[i]);
	}

	printf("\nVolume Label				  :\t");
	for(i=0x2b;i<0x36;i++)
	{
		printf("%c",buff[i]);
	}
	getch();
}