#include<conio.h>
#include<stdio.h>
#include<dos.h>
#include<stdlib.h>
#include<string.h>
int next_cls(int cls)
{
	char fat[7200];
	int res,no;
	asm{
		mov ax,0x0
		mov dx,0x1
		lea bx,fat
		mov cx,0x9
		int 0x25
	}
	res=*(int *)&fat[(int)1.5*cls];
	no=cls*3;
	if(no%2==1)
		return(res>>4);
	else
		return(res&0x0fff);

}
void main()
{
	clrscr();
	int flag=0,cls,fatchain[20],addr;
	char buff[7200],name[20],fname[20],data[512];
	int i,j,k;
	asm{
		mov al,0x00
		lea bx,buff
		mov dx,19
		mov cx,14
		int 0x25
		jnc ok
	}
	printf("\nFloppy not found.");
	exit(0);
	ok:
	printf("\nEnter file name . extention:");
	scanf("%s",name);

	for(i=0;i<225;i++)
	{
		if(buff[i*32]==0x0)
			continue;
		if(buff[i*32]==0x05)
			continue;
		if(buff[i*32]==0xe5)
			continue;
		if(buff[i*32]==0x2e)
			continue;
		if(buff[i*32+0x0b]&4==4)
			continue;

		for(j=0x0;j<0x8&&buff[i*32+j]!=' ';j++)
		{
			fname[j]=buff[i*32+j];
		}
		fname[j++]='.';
		for(k=0x8;k<0xb;k++)
		{
			fname[j++]=buff[i*32+k];
		}
		fname[j++]='\0';
		printf("\n%s",fname);
		if(strcmpi(fname,name)==0)
		{
			printf("\nFile found.");
			flag=1;
			break;
		}
	}
	if(flag==1)
	{
		cls=*(int *)&buff[i*32+0x1a];
		k=0;
		while(cls>0&&cls<0xff8)
		{
			fatchain[k++]=cls;
			cls=next_cls(cls);
		}
		printf("\nFAT chain:");
		for(j=0;j<k;j++)
		{
			printf("\n %d \t:",fatchain[j]);
			addr=fatchain[j]+31;
			asm{
				mov al,0x0
				mov cx,0x1
				mov dx,addr
				lea bx,data
				int 0x25
			}
			printf("\n%s",data);
		}

	}
	else
		printf("\nFile not found");
	getch();
}