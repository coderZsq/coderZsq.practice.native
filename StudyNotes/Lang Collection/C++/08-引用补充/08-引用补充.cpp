// 08-引用补充.cpp : This file contains the 'main' function. Program execution begins and ends there.
//

#include <iostream>
using namespace std;

int main()
{
	int a = 10;
	int b = 20;
	
	/*
	// (a > b ? a : b) = 40;
	00F12652  mov         dword ptr [ebp-0Ch],0Ah  
	00F12659  mov         dword ptr [ebp-18h],14h  
	00F12660  mov         eax,dword ptr [ebp-0Ch]  
	00F12663  cmp         eax,dword ptr [ebp-18h]  
	00F12666  jle         00F12673  
	00F12668  lea         ecx,[ebp-0Ch]  
	00F1266B  mov         dword ptr [ebp+FFFFFF14h],ecx  
	00F12671  jmp         00F1267C  
	00F12673  lea         edx,[ebp-18h]  
	00F12676  mov         dword ptr [ebp+FFFFFF14h],edx  
	00F1267C  mov         eax,dword ptr [ebp+FFFFFF14h]  
	00F12682  mov         dword ptr [ebp+FFFFFF1Ch],eax  
	00F12688  mov         ecx,dword ptr [ebp+FFFFFF1Ch]  
	00F1268E  mov         dword ptr [ecx],28h
	*/

	/*
	//(a = b) = 30;
	mov         dword ptr [ebp-0Ch],0Ah  
	mov         dword ptr [ebp-18h],14h  
	mov         eax,dword ptr [ebp-18h]  
	mov         dword ptr [ebp-0Ch],eax  
	mov         dword ptr [ebp-0Ch],1Eh 
	*/

	cout << "a is " << a << endl;
	cout << "b is " << b << endl;

	/*int array[] = { 1, 2, 3, 4 };
	int(&rArray)[4] = array;
	int* const & p = array;*/

	/*int age = 10;
	const long& rAge = age;
	age = 30;

	cout << "age is " << age << endl;
	cout << "rAge is " << rAge << endl;*/
	/*
	mov         dword ptr [ebp-0Ch],0Ah  

	mov         eax,dword ptr [ebp-0Ch]  
	mov         dword ptr [ebp-24h],eax  
	lea         ecx,[ebp-24h]  
	mov         dword ptr [ebp-18h],ecx

	mov         dword ptr [ebp-0Ch],1Eh  
	*/

	/*int age = 10;
	const int& rAge = age;
	age = 30;

	cout << "age is " << age << endl;
	cout << "rAge is " << rAge << endl;*/
	/*
	mov         dword ptr [ebp-0Ch],0Ah  
	lea         eax,[ebp-0Ch]  
	mov         dword ptr [ebp-18h],eax  
	mov         dword ptr [ebp-0Ch],1Eh
	*/
	getchar();
	return 0;
}

// Run program: Ctrl + F5 or Debug > Start Without Debugging menu
// Debug program: F5 or Debug > Start Debugging menu

// Tips for Getting Started: 
//   1. Use the Solution Explorer window to add/manage files
//   2. Use the Team Explorer window to connect to source control
//   3. Use the Output window to see build output and other messages
//   4. Use the Error List window to view errors
//   5. Go to Project > Add New Item to create new code files, or Project > Add Existing Item to add existing code files to the project
//   6. In the future, to open this project again, go to File > Open > Project and select the .sln file
