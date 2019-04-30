// 55-异常.cpp : This file contains the 'main' function. Program execution begins and ends there.
//

#include <iostream>
using namespace std;

//int sum(int a, int b) {
//	// 业务逻辑写错了
//	return a - b;
//}

void test() {
	cout << "1" << endl;

	// 如果内存不够, 就会抛出异常(运行过程中抛出一个错误)
	try {
		for (int i = 0; i < 9999999; i++) {
			int* p = new int[9999999];
		}

		cout << "2" << endl;
	}
	catch (...) {
		cout << "发生了异常" << endl;
	}

	cout << "3" << endl;

	// delete[] p;
}

int divide(int a, int b) {
	if (b == 0) throw "不能除以0";
	return a / b;
}

void test2() {
	cout << "1" << endl;

	try {
		int v1 = 10;
		int v2 = 0;
		cout << divide(v1, v2) << endl;
	}
	catch (int exception) {
		cout << "捕获到异常1: " << exception << endl;
	}
	catch (const char* exception) {
		cout << "捕获到异常2: " << exception << endl;
	}

	cout << "2" << endl;
}

void test3() {
	try {
		throw 3;
	}
	catch (const char* exception) {
		cout << "test3 - 捕获到异常: " << exception << endl;
	}
}

void test4() {
	try {
		test3();
	}
	catch (int exception) {
		cout << "test4 - 捕获到异常: " << exception << endl;
	}
}

class Exception {
public:
	virtual const char* what() const = 0;
};

class DivideExpetion :public Exception {
public:
	const char* what() const {
		return "不能除以0";
	}
};

class AddExpetion :public Exception {
public:
	const char* what() const {
		return "加法有问题";
	}
};

int divide2(int a, int b) {
	if (b == 0) throw DivideExpetion();
	return a / b;
}

int main() {

	//try {
	//	divide2(0, 0);
	//}
	//catch (const DivideExpetion& e) {
	//	cout << e.what() << endl;
	//}
	//catch (const AddExpetion& e) {

	//}

	try {
		for (int i = 0; i < 9999999; i++) {
			int* p = new int[9999999];
		}
	}
	catch (std::bad_alloc e) {
		cout << e.what() << endl;
	}

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
