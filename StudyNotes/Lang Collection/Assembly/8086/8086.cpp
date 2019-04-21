#include <stdio.h>

int a = 20; // a (012FA034h)
int b = 30; // b (012FA038h)

void test() {
	printf("1\n");
	printf("2\n");
}
/*
00A93CA0  push        ebp
00A93CA1  mov         ebp,esp
00A93CA3  sub         esp,0C0h
00A93CA9  push        ebx
00A93CAA  push        esi
00A93CAB  push        edi
00A93CAC  lea         edi,[ebp-0C0h]
00A93CB2  mov         ecx,30h
00A93CB7  mov         eax,0CCCCCCCCh
00A93CBC  rep stos    dword ptr es:[edi]
00A93CBE  mov         ecx,offset _102B2C4C_8086@cpp (0A9C003h)
00A93CC3  call        @__CheckForDebuggerJustMyCode@4 (0A91208h)
00A93CC8  push        offset string "1\n" (0A97BDCh)
00A93CCD  call        _printf (0A9137Ah)
00A93CD2  add         esp,4
00A93CD5  push        offset string "2\n" (0A97BCCh)
00A93CDA  call        _printf (0A9137Ah)
00A93CDF  add         esp,4
00A93CE2  pop         edi
00A93CE3  pop         esi
00A93CE4  pop         ebx
00A93CE5  add         esp,0C0h
00A93CEB  cmp         ebp,esp
00A93CED  call        __RTC_CheckEsp (0A91212h)
00A93CF2  mov         esp,ebp
00A93CF4  pop         ebp
00A93CF5  ret
*/

int mathFunc() {
	return 8;
}
/*
00133CA0  push        ebp
00133CA1  mov         ebp,esp
00133CA3  sub         esp,0C0h
00133CA9  push        ebx
00133CAA  push        esi
00133CAB  push        edi
00133CAC  lea         edi,[ebp-0C0h]
00133CB2  mov         ecx,30h
00133CB7  mov         eax,0CCCCCCCCh
00133CBC  rep stos    dword ptr es:[edi]
00133CBE  mov         ecx,offset _102B2C4C_8086@cpp (013C003h)
00133CC3  call        @__CheckForDebuggerJustMyCode@4 (0131208h)
00133CC8  mov         eax,8
00133CCD  pop         edi
00133CCE  pop         esi
00133CCF  pop         ebx
00133CD0  add         esp,0C0h
00133CD6  cmp         ebp,esp
00133CD8  call        __RTC_CheckEsp (0131212h)
00133CDD  mov         esp,ebp
00133CDF  pop         ebp
00133CE0  ret
*/

int sum(int a, int b) {
	return a + b;
}
/*
002E1700  push        ebp
002E1701  mov         ebp,esp
002E1703  sub         esp,0C0h
002E1709  push        ebx
002E170A  push        esi
002E170B  push        edi
002E170C  lea         edi,[ebp-0C0h]
002E1712  mov         ecx,30h
002E1717  mov         eax,0CCCCCCCCh
002E171C  rep stos    dword ptr es:[edi]
002E171E  mov         ecx,offset _102B2C4C_8086@cpp (02EC003h)
002E1723  call        @__CheckForDebuggerJustMyCode@4 (02E1208h)
002E1728  mov         eax,dword ptr [a]
002E172B  add         eax,dword ptr [b]
002E172E  pop         edi
002E172F  pop         esi
002E1730  pop         ebx
002E1731  add         esp,0C0h
002E1737  cmp         ebp,esp
002E1739  call        __RTC_CheckEsp (02E1212h)
002E173E  mov         esp,ebp
002E1740  pop         ebp
002E1741  ret
*/

int __cdecl minus1(int a, int b) {
	return a - b;
}

int __stdcall minus2(int a, int b) {
	return a - b;
}
/*
00EE1DE0  push        ebp
00EE1DE1  mov         ebp,esp
00EE1DE3  sub         esp,0C0h
00EE1DE9  push        ebx
00EE1DEA  push        esi
00EE1DEB  push        edi
00EE1DEC  lea         edi,[ebp-0C0h]
00EE1DF2  mov         ecx,30h
00EE1DF7  mov         eax,0CCCCCCCCh
00EE1DFC  rep stos    dword ptr es:[edi]
00EE1DFE  mov         ecx,offset _102B2C4C_8086@cpp (0EEC003h)
00EE1E03  call        @__CheckForDebuggerJustMyCode@4 (0EE1208h)
00EE1E08  mov         eax,dword ptr [a]
00EE1E0B  sub         eax,dword ptr [b]
00EE1E0E  pop         edi
00EE1E0F  pop         esi
00EE1E10  pop         ebx
00EE1E11  add         esp,0C0h
00EE1E17  cmp         ebp,esp
00EE1E19  call        __RTC_CheckEsp (0EE1212h)
00EE1E1E  mov         esp,ebp
00EE1E20  pop         ebp
00EE1E21  ret         8
*/

int __fastcall minus3(int a, int b) {
	return a - b;
}
/*
013E41D0  push        ebp
013E41D1  mov         ebp,esp
013E41D3  sub         esp,0D8h
013E41D9  push        ebx
013E41DA  push        esi
013E41DB  push        edi
013E41DC  push        ecx
013E41DD  lea         edi,[ebp-0D8h]
013E41E3  mov         ecx,36h
013E41E8  mov         eax,0CCCCCCCCh
013E41ED  rep stos    dword ptr es:[edi]
013E41EF  pop         ecx
013E41F0  mov         dword ptr [b],edx
013E41F3  mov         dword ptr [a],ecx
013E41F6  mov         ecx,offset _102B2C4C_8086@cpp (013EC003h)
013E41FB  call        @__CheckForDebuggerJustMyCode@4 (013E1208h)
013E4200  mov         eax,dword ptr [a]
013E4203  sub         eax,dword ptr [b]
013E4206  pop         edi
013E4207  pop         esi
013E4208  pop         ebx
013E4209  add         esp,0D8h
013E420F  cmp         ebp,esp
013E4211  call        __RTC_CheckEsp (013E1212h)
013E4216  mov         esp,ebp
013E4218  pop         ebp
013E4219  ret
*/

int __fastcall minus4(int a, int b, int c, int d) {
	return a - b;
}
/*
00382530  push        ebp
00382531  mov         ebp,esp
00382533  sub         esp,0D8h
00382539  push        ebx
0038253A  push        esi
0038253B  push        edi
0038253C  push        ecx
0038253D  lea         edi,[ebp-0D8h]
00382543  mov         ecx,36h
00382548  mov         eax,0CCCCCCCCh
0038254D  rep stos    dword ptr es:[edi]
0038254F  pop         ecx
00382550  mov         dword ptr [b],edx
00382553  mov         dword ptr [a],ecx
00382556  mov         ecx,offset _102B2C4C_8086@cpp (038C003h)
0038255B  call        @__CheckForDebuggerJustMyCode@4 (0381208h)
00382560  mov         eax,dword ptr [a]
00382563  sub         eax,dword ptr [b]
00382566  pop         edi
00382567  pop         esi
00382568  pop         ebx
00382569  add         esp,0D8h
0038256F  cmp         ebp,esp
00382571  call        __RTC_CheckEsp (0381212h)
00382576  mov         esp,ebp
00382578  pop         ebp
00382579  ret         8
*/

int sum2(int a, int b) {
	int c = 3;
	int d = 4;
	int e = c + d;
	return a + b + e;
}
/*
00E11950  push        ebp
00E11951  mov         ebp,esp
00E11953  sub         esp,0E4h
00E11959  push        ebx
00E1195A  push        esi
00E1195B  push        edi
00E1195C  lea         edi,[ebp+FFFFFF1Ch]
00E11962  mov         ecx,39h
00E11967  mov         eax,0CCCCCCCCh
00E1196C  rep stos    dword ptr es:[edi]
00E1196E  mov         ecx,0E1C003h
00E11973  call        00E11230
00E11978  mov         dword ptr [ebp-8],3
00E1197F  mov         dword ptr [ebp-14h],4
00E11986  mov         eax,dword ptr [ebp-8]
00E11989  add         eax,dword ptr [ebp-14h]
00E1198C  mov         dword ptr [ebp-20h],eax
00E1198F  mov         eax,dword ptr [ebp+8]
00E11992  add         eax,dword ptr [ebp+0Ch]
00E11995  add         eax,dword ptr [ebp-20h]
00E11998  pop         edi
00E11999  pop         esi
00E1199A  pop         ebx
00E1199B  add         esp,0E4h
00E119A1  cmp         ebp,esp
00E119A3  call        00E1123A
00E119A8  mov         esp,ebp
00E119AA  pop         ebp
00E119AB  ret
*/

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
	*/

	/*
	test();
	00A92548  call        test (0A9138Eh)
	->	00A9138E  jmp         test (0A93CA0h)
	*/

	/*
	printf("%d", mathFunc());
	001341F8  call        mathFunc (0131393h)
	->  00131393  jmp         mathFunc (0133CA0h)
	001341FD  push        eax
	001341FE  push        offset string "%d" (0137BD0h)
	00134203  call        _printf (013137Ah)
	*/
	
	/*
	sum(10, 20);
	002E4258  push        14h  
	002E425A  push        0Ah  
	002E425C  call        sum (02E1398h) 
	->  002E1398  jmp         sum (02E1700h) 
	002E4261  add         esp,8 
	*/
	
	/*
	minus2(20, 10);
	00EE4E58  push        0Ah  
	00EE4E5A  push        14h  
	00EE4E5C  call        minus2 (0EE13A7h)
	->  00EE13A7  jmp         minus2 (0EE1DE0h)
	*/
	
	/*
	minus3(20, 10);
	013E4EA8  mov         edx,0Ah  
	013E4EAD  mov         ecx,14h  
	013E4EB2  call        minus3 (013E13ACh) 
	->  013E13AC  jmp         minus3 (013E41D0h)
	*/
	
	/*
	minus4(20, 10, 2, 1);
	00384EF8  push        1  
	00384EFA  push        2  
	00384EFC  mov         edx,0Ah  
	00384F01  mov         ecx,14h  
	00384F06  call        minus4 (03813B1h) 
	->  003813B1  jmp         minus4 (0382530h)
	*/
	
	sum2(a, b);
	int c = 0;
	__asm {
		mov c, eax
	}
	printf("%d\n", c);

	return 0;
}