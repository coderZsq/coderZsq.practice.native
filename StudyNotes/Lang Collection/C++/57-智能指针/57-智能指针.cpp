// 57-智能指针.cpp : This file contains the 'main' function. Program execution begins and ends there.
//

#include <iostream>
using namespace std;

class Person;

class Car {
public:
	//Person* m_person;
	//shared_ptr<Person> m_person = nullptr;
	weak_ptr<Person> m_person;
	Car() {
		cout << "Car()" << endl;
	}
	~Car() {
		cout << "~Car()" << endl;
	}
};

class Person {
public:
	//Car* m_car;
	shared_ptr<Car> m_car = nullptr;
	Person() {
		cout << "Person()" << endl;
	}
	~Person() {
		cout << "~Person()" << endl;
	}

	void run() {
		cout << "Person::run()" << endl;
	}
};

void test1() {
	cout << "1" << endl;
	{
		shared_ptr<Person> p2;
		{
			shared_ptr<Person> p1(new Person());
			p2 = p1;
			cout << "2" << endl;
		}
		cout << "3" << endl;
	}
	cout << "4" << endl;
}

void test2() {
	/*auto expr = [](Person * p) {
		delete[] p;
	};
	shared_ptr<Person> p1(new Person[5]{}, expr);*/

	shared_ptr<Person[]> p2(new Person[5]{});
}

void test3() {
	{
		shared_ptr<Person> p1(new Person());
		cout << p1.use_count() << endl;

		{
			shared_ptr<Person> p2 = p1;
			cout << p1.use_count() << endl;
		}

		cout << p1.use_count() << endl;

		{
			shared_ptr<Person> p3 = p1;
			cout << p1.use_count() << endl;
		}

		cout << p1.use_count() << endl;

		shared_ptr<Person> p4 = p1;
		cout << p1.use_count() << endl;
	}
}

void test4() {
	Person* p = new Person();

	{
		shared_ptr<Person> p1(p);
	}

	{
		shared_ptr<Person> p2(p);
	}
}

void test5() {
	/*Person* p = new Person();
		p->m_car = new Car();
		p->m_car->m_person = p;*/

	cout << "1" << endl;
	{
		shared_ptr<Person> person(new Person());
		shared_ptr<Car> car(new Car());
		person->m_car = car;
		car->m_person = person;
	}
	cout << "2" << endl;
}

int main() {
	{
		unique_ptr<Person> p1(new Person());
		{
			unique_ptr<Person> p2 = std::move(p1);
			cout << "1" << endl;
		}
		cout << "2" << endl;
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
