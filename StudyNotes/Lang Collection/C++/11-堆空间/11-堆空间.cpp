// 11-堆空间.cpp : This file contains the 'main' function. Program execution begins and ends there.
//

#include <iostream>
using namespace std;

void test6() {
	int* p1 = new int; // 没有初始化
	/*
	push        4
	call        operator new (0BE137Ah)
	add         esp, 4
	mov         dword ptr[ebp - 11Ch], eax
	mov         eax, dword ptr[ebp - 11Ch]
	mov         dword ptr[p1], eax*/
	int* p2 = new int(); // 初始化为0
	/*
	mov         dword ptr[ebp - 128h], 4
	mov         eax, dword ptr[ebp - 128h]
	push        eax
	call        operator new (0BE137Ah)
	add         esp, 4
	mov         dword ptr[ebp - 134h], eax
	cmp         dword ptr[ebp - 134h], 0
	je          test6 + 8Fh(0BE5AAFh)
	mov         ecx, dword ptr[ebp - 128h]
	push        ecx
	push        0
	mov         edx, dword ptr[ebp - 134h]
	push        edx
	call        _memset(0BE1131h)
	add         esp, 0Ch
	mov         eax, dword ptr[ebp - 134h]
	mov         dword ptr[ebp - 190h], eax
	jmp         test6 + 99h(0BE5AB9h)
	mov         dword ptr[ebp - 190h], 0
	mov         ecx, dword ptr[ebp - 190h]
	mov         dword ptr[p2], ecx*/
	int* p3 = new int(5); // 初始化为5
	/*
	push        4
	call        operator new (0BE137Ah)
	add         esp, 4
	mov         dword ptr[ebp - 140h], eax
	cmp         dword ptr[ebp - 140h], 0
	je          test6 + 0D5h(0BE5AF5h)
	mov         eax, dword ptr[ebp - 140h]
	mov         dword ptr[eax], 5
	mov         ecx, dword ptr[ebp - 140h]
	mov         dword ptr[ebp - 190h], ecx
	jmp         test6 + 0DFh(0BE5AFFh)
	mov         dword ptr[ebp - 190h], 0
	mov         edx, dword ptr[ebp - 190h]
	mov         dword ptr[p3], edx*/
	int* p4 = new int[3]; // 没有初始化
	/*
	push        0Ch
	call        operator new[](0BE10E6h)
	add         esp, 4
	mov         dword ptr[ebp - 14Ch], eax
	mov         eax, dword ptr[ebp - 14Ch]
	mov         dword ptr[p4], eax*/
	int* p5 = new int[3](); // 全部元素初始化为0
	/*
	mov         dword ptr[ebp - 158h], 0Ch
	mov         eax, dword ptr[ebp - 158h]
	push        eax
	call        operator new[](0BE10E6h)
	add         esp, 4
	mov         dword ptr[ebp - 164h], eax
	cmp         dword ptr[ebp - 164h], 0
	je          test6 + 14Fh(0BE5B6Fh)
	mov         ecx, dword ptr[ebp - 158h]
	push        ecx
	push        0
	mov         edx, dword ptr[ebp - 164h]
	push        edx
	call        _memset(0BE1131h)
	add         esp, 0Ch
	mov         eax, dword ptr[ebp - 164h]
	mov         dword ptr[ebp - 190h], eax
	jmp         test6 + 159h(0BE5B79h)
	mov         dword ptr[ebp - 190h], 0
	mov         ecx, dword ptr[ebp - 190h]
	mov         dword ptr[p5], ecx*/
	int* p6 = new int[3]{}; // 全部元素初始化为0
	/*
	mov         dword ptr[ebp - 170h], 0Ch
	mov         eax, dword ptr[ebp - 170h]
	push        eax
	call        operator new[](0BE10E6h)
	add         esp, 4
	mov         dword ptr[ebp - 17Ch], eax
	cmp         dword ptr[ebp - 17Ch], 0
	je          test6 + 1B0h(0BE5BD0h)
	mov         ecx, dword ptr[ebp - 170h]
	push        ecx
	push        0
	mov         edx, dword ptr[ebp - 17Ch]
	push        edx
	call        _memset(0BE1131h)
	add         esp, 0Ch
	mov         eax, dword ptr[ebp - 17Ch]
	mov         dword ptr[ebp - 190h], eax
	jmp         test6 + 1BAh(0BE5BDAh)
	mov         dword ptr[ebp - 190h], 0
	mov         ecx, dword ptr[ebp - 190h]
	mov         dword ptr[p6], ecx*/
	int* p7 = new int[3]{ 5 }; // 首元素初始化为5, 其他元素初始化为0
	/*
	push        0Ch
	call        operator new[](0BE10E6h)
	add         esp, 4
	mov         dword ptr[ebp - 188h], eax
	cmp         dword ptr[ebp - 188h], 0
	je          test6 + 210h(0BE5C30h)
	mov         eax, dword ptr[ebp - 188h]
	mov         dword ptr[eax], 5
	mov         ecx, dword ptr[ebp - 188h]
	mov         dword ptr[ecx + 4], 0
	mov         edx, dword ptr[ebp - 188h]
	mov         dword ptr[edx + 8], 0
	mov         eax, dword ptr[ebp - 188h]
	mov         dword ptr[ebp - 190h], eax
	jmp         test6 + 21Ah(0BE5C3Ah)
	mov         dword ptr[ebp - 190h], 0
	mov         ecx, dword ptr[ebp - 190h]
	mov         dword ptr[p7], ecx*/

	cout << *p1 << endl; // -842150451
	cout << *p2 << endl; // 0
	cout << *p3 << endl; // 5
	cout << *p4 << endl; // -842150451
	cout << *p5 << endl; // 0
	cout << *p6 << endl; // 0
	cout << *p7 << endl; // 5
}

void test5() {
	int size = sizeof(int);
	int* p = (int*)malloc(size);
	// memory set
	// 从p开始的4个字节, 每个字节都存放0
	memset(p, 0, size);

	cout << *p << endl;

	free(p);
}

void test4() {
	int* p = new int; // 内存泄漏
	p = new int;

	delete p;
}

void test3() {
	/*int* p = (int*)malloc(sizeof(int) * 10);
	p[0] = 10;
	p[1] = 10;
	p[2] = 10;
	p[3] = 10;

	free(p);*/

	int* p = new int[10];

	delete[] p;
}

void test2() {
	int* p = new int;
	int* p2 = new int;
	/*
	call        operator new (0E8135Ch)

	operator new:
	push        ebp  
	mov         ebp,esp  
	push        ecx  
	mov         eax,dword ptr [size]  
	push        eax  
	call        _malloc (0E812A3h)  
	add         esp,4  
	mov         dword ptr [ebp-4],eax  
	cmp         dword ptr [ebp-4],0  
	je          operator new+1Eh (0E81C3Eh)  
	mov         eax,dword ptr [ebp-4]  
	jmp         operator new+42h (0E81C62h)  
	mov         ecx,dword ptr [size]  
	push        ecx  
	call        __callnewh (0E8109Bh)  
	add         esp,4  
	test        eax,eax  
	jne         operator new+40h (0E81C60h)  
	cmp         dword ptr [size],0FFFFFFFFh  
	jne         operator new+3Bh (0E81C5Bh)  
	call        __scrt_throw_std_bad_array_new_length (0E8120Dh)  
	jmp         operator new+40h (0E81C60h)  
	call        __scrt_throw_std_bad_alloc (0E813ACh)  
	jmp         operator new+4h (0E81C24h)  
	mov         esp,ebp  
	pop         ebp  
	ret  
	*/
	delete p;
	delete p2;
	/*
	call        operator delete (0B81276h)

	push        ebp  
	mov         ebp,esp  
	mov         eax,dword ptr [block]  
	push        eax  
	call        operator delete (0E114Fh) 
	->  push        ebp  
	    mov         ebp,esp  
		push        0FFFFFFFFh  
		mov         eax,dword ptr [block]  
		push        eax  
		call        __free_dbg (0E13B1h)  
		add         esp,8  
		pop         ebp  
		ret 
	add         esp,4  
	pop         ebp  
	ret 
	*/
}

void test() {
	int* p = (int*)malloc(4);

	free(p);
}

//int* test() {
//	// 申请4个字节的堆空间内存
//	int* p = (int*)malloc(4);
//	/*char* p = (char *)malloc(4);
//	*p = 1;
//	*(p + 1) = 2;
//		
//	p[0] = 1;
//	p[1] = 2;*/
//
//	return p;
//}

struct Person
{
	int m_age;
};

// 全局区 代码段 ds:[0]
Person g_person;

int main()
{
	// 栈空间
	Person person;

	// 堆空间
	Person* p = new Person();
	p->m_age = 20;

	delete p;

	/*Person* p2 = (Person*)malloc(sizeof(Person));
	free(p2);*/

	test6();

	/*int* p = test();
	*p = 20;*/

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
