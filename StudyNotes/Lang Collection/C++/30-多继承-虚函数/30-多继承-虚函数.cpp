﻿// 30-多继承-虚函数.cpp : This file contains the 'main' function. Program execution begins and ends there.
//

#include <iostream>
using namespace std;

class Student {
public:
	virtual void study() {
		cout << "Student::study()" << endl;
	}
};

class Worker {
public:
	virtual void work() {
		cout << "Worker::work()" << endl;
	}
};

class Undergraduate :public Student, public Worker {
public:
	void study() {
		cout << "Undergraduate::study()" << endl;
	}
	void work() {
		cout << "Undergraduate::work()" << endl;
	}
	void play() {
		cout << "Undergraduate::play()" << endl;
	}
};

int main() {
	/*Undergraduate ug;
	ug.study();
	ug.work();
	ug.play();*/

	Student* stu = new Undergraduate();
	stu->study();

	Worker* worker = new Undergraduate();
	worker->work();

	cout << sizeof(Undergraduate) << endl;

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
