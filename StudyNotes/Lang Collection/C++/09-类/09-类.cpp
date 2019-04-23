// 09-类.cpp : This file contains the 'main' function. Program execution begins and ends there.
//

#include <iostream>
using namespace std;

struct Person
{
	int m_id;
	int m_age;
	int m_height;

	void display() {
		cout << "m_id = " << this->m_id << endl;
		cout << "m_age = " << this->m_age << endl;
		cout << "m_height = " << this->m_height << endl;
	}
};


int main() {
	Person person;
	person.m_id = 10;
	person.m_age = 20;
	person.m_height = 30;

	Person* pPerson = (Person*) &person.m_age;
	// 取出pPerson中存储的地址值
	// mov eax, &person.m_age
	// mov dword ptr [&person.m_age], 40
	// mov dword ptr [&person.m_age + 4], 50
	pPerson->m_id = 40;
	pPerson->m_age = 50;
	pPerson->display();

	person.display();

	getchar();
	return 0;
}

//struct Person
//{
//	int m_id;
//	int m_age;
//	int m_height;
//
//	void display() {
//		// this指向Person对象的指针
//		// this里面存储的就是person对象的地址值
//		this->m_id = 5;
//		this->m_age = 6;
//		this->m_height = 7;
//		/*
//		mov         dword ptr [ebp-8],ecx
//
//		mov         eax,dword ptr [ebp-8]  
//		mov         dword ptr [eax],5  
//		mov         eax,dword ptr [ebp-8]  
//		mov         dword ptr [eax+4],6  
//		mov         eax,dword ptr [ebp-8]  
//		mov         dword ptr [eax+8],7
//		*/
//
//		/*cout << "m_id = " << this->m_id << endl;
//		cout << "m_age = " << this->m_age << endl;
//		cout << "m_height = " << this->m_height << endl;*/
//	}
//};
//
//
//int main() {
//	Person person;
//	person.m_id = 1;
//	person.m_age = 2;
//	person.m_height = 3;
//	person.display();
//	/*
//	lea         ecx,[ebp-14h]  
//	call        00EF1460  
//
//	Person::display:
//	jmp         00EF1ED0
//	*/
//
//	Person* pPerson = &person;
//	pPerson->m_id = 4;
//	pPerson->m_age = 5;
//	pPerson->m_height = 6;
//	pPerson->display();
//
//	/*
//	Person person;
//	person.m_id = 1;
//	person.m_age = 2;
//	person.m_height = 3;
//
//	Person* pPerson = &person;
//	pPerson->m_id = 4;
//	pPerson->m_age = 5;
//	pPerson->m_height = 6;
//
//	mov         dword ptr [ebp-14h],1
//	mov         dword ptr [ebp-10h],2
//	mov         dword ptr [ebp-0Ch],3
//
//	lea         eax,[ebp-14h]  
//	mov         dword ptr [ebp-20h],eax 
//
//	mov         eax,dword ptr [ebp-20h]  
//	mov         dword ptr [eax],4  
//	mov         eax,dword ptr [ebp-20h]  
//	mov         dword ptr [eax+4],5  
//	mov         eax,dword ptr [ebp-20h]  
//	mov         dword ptr [eax+8],6 
//	*/
//
//	//cout << "&person = " << &person << endl; // 00F9FE30
//	//cout << "&person.m_id = " << &person.m_id << endl; // 00F9FE30
//	//cout << "&person.m_age = " << &person.m_age << endl; // 00F9FE34
//	//cout << "&person.m_height = " << &person.m_height << endl; // 00F9FE38
//	//cout << sizeof(person) << endl;
//
//	getchar();
//	return 0;
//}

/*struct Person
{
	int m_age;

	void run() {
		cout << "run() - age is " << m_age << endl;
	}
};


int main() {
	Person person;
	person.m_age = 20;
	person.run();

	Person* pPerson = &person;
	pPerson->m_age = 30;
	pPerson->run();

	cout << sizeof(person) << endl;

	getchar();
	return 0;
}*/

/*struct Person
{
//public:
	// 成员变量
	int age;

	// 成员函数
	void run() {
		cout << "run() - age is " << age << endl;
	}

//public:
//	void test() {
//		run();
//	}
};

class Student
{
//private:
public:
	int no;

	void study() {
		cout << "study() - age is " << no << endl;
	}
};

int main()
{
	// 在栈空间分配了内存给person对象
	// 这个person对象的内存会自动回收, 不用开发人员去管理
	Person person;
	person.age = 20;
	person.run();

	Person person2;
	person2.age = 30;
	person2.run();

	Student student;
	student.no = 100;
	student.study();

	getchar();
	return 0;
}*/

// Run program: Ctrl + F5 or Debug > Start Without Debugging menu
// Debug program: F5 or Debug > Start Debugging menu

// Tips for Getting Started: 
//   1. Use the Solution Explorer window to add/manage files
//   2. Use the Team Explorer window to connect to source control
//   3. Use the Output window to see build output and other messages
//   4. Use the Error List window to view errors
//   5. Go to Project > Add New Item to create new code files, or Project > Add Existing Item to add existing code files to the project
//   6. In the future, to open this project again, go to File > Open > Project and select the .sln file
