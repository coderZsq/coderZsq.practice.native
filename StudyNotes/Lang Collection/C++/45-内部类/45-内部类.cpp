// 45-内部类.cpp : This file contains the 'main' function. Program execution begins and ends there.
//

#include <iostream>
using namespace std;

//Person
class Person {
private:
	static int ms_legs;
	static void other() {
	
	}
	int m_age;
	void walk() {
	
	}
public:
	Person() {
		cout << "Person()" << endl;
	}
//protected:
	//Car
	class Car {
		int m_price;
	public:
		Car() {
			cout << "Car()" << endl;
		}
		void run() {
			Person person;
			person.m_age = 10;
			person.walk();

			ms_legs = 10;
			other();
		}
	};
};

int Person::ms_legs = 2;

/*class Student :public Person {
	void test() {
		Car car;
	}
}*/;

class Point {
	class Math {
		void test();
	};
};

void Point::Math::test() {

}

int main() {
	cout << sizeof(Person) << endl;
	Person person;

	Person::Car car; 

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
