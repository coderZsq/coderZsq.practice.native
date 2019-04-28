// 41-匿名对象.cpp : This file contains the 'main' function. Program execution begins and ends there.
//

#include <iostream>
using namespace std;

class Person {
public:
	Person() {
		cout << "Person() - " << this << endl;
	}
	Person(const Person& person) {
		cout << "Person(const Person& person) - " << this << endl;
	}
	~Person() {
		cout << "~Person() - " << this <<  endl;
	}
	void display() {
		cout << "display()" << endl;
	}
};

void test1(Person person) {

}

Person test2() {
	//Person person;
	return Person();
}

int main() {

	Person person1;
	person1 = test2();

	//Person person = Person();

	//test1(Person());

	/*Person person;
	test1(person);*/

	/*cout << 1 << endl;

	Person().display();

	cout << 2 << endl;*/

	/*Person person;

	Person* p = new Person();*/

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
