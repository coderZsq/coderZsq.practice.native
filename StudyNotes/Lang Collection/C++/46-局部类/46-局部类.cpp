// 46-局部类.cpp : This file contains the 'main' function. Program execution begins and ends there.
//

#include <iostream>
using namespace std;

int g_age = 20;

void test() {
	int age = 10;
	static int s_age = 30;

	//局部类
	class Person {
	public:
		static void run() {
			//age = 20; //wrong
			g_age = 30;
			s_age = 40;

			cout << "run()" << endl;
		}
	};

	Person person;
	Person::run();
}

int main() {
	test();

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
