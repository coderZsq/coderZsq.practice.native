// 10-封装.cpp : This file contains the 'main' function. Program execution begins and ends there.
//

#include <iostream>
using namespace std;

class Person {
public:
	int m_age;
	void run() {
		cout << "run()" << endl;
	}
};

//struct Person {
//	int m_age;
//	void run() {
//		cout << "run()" << endl;
//	}
//};

int main() {
	
	Person person;
	person.m_age = 10;
	person.run();
	/*
	mov         dword ptr [ebp-0Ch],0Ah  
	lea         ecx,[ebp-0Ch]  
	call        00AB136B
	*/

	getchar();
	return 0;
}

/*
struct Person {
private:
	int m_age;

public:
	void setAge(int age) {
		// 过滤
		if (age < 0) return;

		this->m_age = age;
	}

	int getAge() {
		return this->m_age;
	}
};

int main()
{
	Person person;
	person.setAge(-20);

	cout << person.getAge() << endl;

	getchar();
	return 0;
}
*/

// Run program: Ctrl + F5 or Debug > Start Without Debugging menu
// Debug program: F5 or Debug > Start Debugging menu

// Tips for Getting Started: 
//   1. Use the Solution Explorer window to add/manage files
//   2. Use the Team Explorer window to connect to source control
//   3. Use the Output window to see build output and other messages
//   4. Use the Error List window to view errors
//   5. Go to Project > Add New Item to create new code files, or Project > Add Existing Item to add existing code files to the project
//   6. In the future, to open this project again, go to File > Open > Project and select the .sln file
