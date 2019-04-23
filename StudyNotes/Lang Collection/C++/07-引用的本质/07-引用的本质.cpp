// 07-引用的本质.cpp : This file contains the 'main' function. Program execution begins and ends there.
//

#include <iostream>
using namespace std;

struct Student {
	int& age;
};

int main()
{
	int age = 5;
	int& rAge = age;
	rAge = 6;
	/*
	mov         dword ptr [rbp+4],5  
	lea         rax,[rbp+4]  
	mov         qword ptr [rbp+28h],rax  
	mov         rax,qword ptr [rbp+28h]  
	mov         dword ptr [rax],6 
	*/

	//cout << sizeof(Student) << endl;

	/*int* p;
	cout << sizeof(p) << endl;

	int age = 10;
	int& rAge = age;
	rAge = 20;

	cout << sizeof(age) << endl;
	cout << sizeof(rAge) << endl;*/

	/*int age = 5;
	int* p = &age;
	*p = 6;
	cout << age << endl;*/
	/*
	x64
	mov         dword ptr [rbp+4],5
	lea         rax,[rbp+4]
	mov         qword ptr [rbp+28h],rax
	mov         rax,qword ptr [rbp+28h]
	mov         dword ptr [rax],6

	->	*p 地址 ebp-18h
	mov         dword ptr [ebp-0Ch],5  
	lea         eax,[ebp-0Ch]  
	mov         dword ptr [ebp-18h],eax
	mov         eax,dword ptr [ebp-18h]
	mov         dword ptr [eax],6
	*/

	/*int age = 5;
	age = 10;
	age = 20;
	age = 30;*/
	/*
	mov         dword ptr [ebp-8],5  
	mov         dword ptr [ebp-8],0Ah  
	mov         dword ptr [ebp-8],14h  
	mov         dword ptr [ebp-8],1Eh 
	*/

	/*int a = 1;
	int b = 2;
	int c = a + b;*/
	/*
	mov         dword ptr [ebp-8],1  
	mov         dword ptr [ebp-14h],2  
	mov         eax,dword ptr [ebp-8]  
	add         eax,dword ptr [ebp-14h]
	mov         dword ptr [ebp-20h],eax
	*/

	/*int age = 20;
	int& rAge = age;
	rAge = 30;*/
	/*
	mov         dword ptr [ebp-0Ch],14h  
	lea         eax,[ebp-0Ch]  
	mov         dword ptr [ebp-18h],eax  
	mov         eax,dword ptr [ebp-18h]  
	mov         dword ptr [eax],1Eh  
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
