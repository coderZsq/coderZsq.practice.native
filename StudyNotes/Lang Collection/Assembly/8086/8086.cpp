#include <stdio.h>

int a = 20;
int b = 30;

int main(int argc, char* argv[])
{
	/*
	int array[] = { 10, 20 };
	00FF1728  mov         dword ptr[array], 0Ah
	00FF172F  mov         dword ptr[ebp - 8], 14h	
	*/
	
	/*
	struct Student
	{
		int age;
	    int no;
	} stu = { 10, 20 };
	00FF1728  mov         dword ptr[stu], 0Ah
	00FF172F  mov         dword ptr[ebp - 8], 14h
	*/

	/*
	int a = sizeof(int);
	00021736  mov         dword ptr [a],4
	*/
	 
	/*
	int a = 20;
	if (a > 10) {
		printf("a > 10");
	}
	else {
		printf("a <= 10");
	}
	00BF1E08  mov         dword ptr[a], 14h
	00BF1E0F  cmp         dword ptr[a], 0Ah
	00BF1E13  jle         main + 44h(0BF1E24h)
	00BF1E15  push        offset string "a > 10" (0BF7BCCh)
	00BF1E1A  call        _printf(0BF137Ah)
	00BF1E1F  add         esp, 4
	00BF1E22  jmp         main + 51h(0BF1E31h)
	00BF1E24  push        offset string "a <= 10" (0BF7BD4h)
	00BF1E29  call        _printf(0BF137Ah)
	00BF1E2E  add         esp, 4
	*/

	/*
	int c = a + b;
	int d = 20;
	d = c + d;
	printf("c is %d\n", c);
	012F1E08  mov         eax,dword ptr [a (012FA034h)]  
	012F1E0D  add         eax,dword ptr [b (012FA038h)]  
	012F1E13  mov         dword ptr [c],eax  
	012F1E16  mov         dword ptr [d],14h  
	012F1E1D  mov         eax,dword ptr [c]  
	012F1E20  add         eax,dword ptr [d]  
	012F1E23  mov         dword ptr [d],eax  
	012F1E26  mov         eax,dword ptr [c]  
	012F1E29  push        eax  
	012F1E2A  push        offset string "c is %d\n" (012F7BDCh)  
	012F1E2F  call        _printf (012F137Ah)  
	012F1E34  add         esp,8 
	*/
	return 0;
}