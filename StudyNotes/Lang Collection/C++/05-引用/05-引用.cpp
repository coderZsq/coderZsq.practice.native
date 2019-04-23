// 05-引用.cpp : This file contains the 'main' function. Program execution begins and ends there.
//

#include <iostream>
using namespace std;

enum Season {
	Spring,
	Summer,
	Fall,
	Winter
};

struct Student {
	int age;
};

int age = 10;

int& func() {
	// age .....
	/*int& rAge = age;
	return rAge;*/
	return age;
}

//void swap(int a, int b) {
//	int temp = a;
//	a = b;
//	b = temp;
//}

void swap(int* a, int* b) {
	int temp = *a;
	*a = *b;
	*b = temp;
}

void swap(int& a, int& b) {
	int temp = a;
	a = b;
	b = temp;
}

int main()
{
	int v1 = 10;
	int v2 = 20;
	swap(v1, v2);
	cout << "v1 is " << v1 << endl;
	cout << "v2 is " << v2 << endl;

	/*func() = 30;
	cout << age << endl;*/

	/*int age = 20;
	int& rAge = age;
	int* p = &rAge;*/

	/*int age = 20;
	int* p = &age;
	int** pp = &p;*/

	//int age = 20;
	//// 定义了一个引用, 相当于是变量的别名
	//int& rAge = age;
	//int& rAge1 = rAge;
	//int& rAge2 = rAge1;
	//
	//rAge = 11;
	//cout << age << endl;

	//rAge1 = 22;
	//cout << age << endl;

	//rAge2 = 33;
	//cout << age << endl;

	/*int array[] = { 10, 20, 30 };
	int (&rArray)[3] = array;

	int* a[4];
	int(*b)[4];

	cout << rArray[2] << endl;*/

	/*int a = 10;
	int b = 20;

	int* p = &a;
	int*& rP = p;
	rP = &b;
	*p = 30;
	cout << a << endl;
	cout << b << endl;*/

	/*Student stu;
	Student& rStu = stu;
	rStu.age = 20;
	cout << stu.age << endl;*/

	/*Season season;
	Season& rSeason = season;
	rSeason = Winter;
	cout << season << endl;*/

	/*int age = 20;
	int* pAge = &age;
	cout << *pAge << endl;

	*pAge = 30;

	cout << age << endl;*/
    
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
