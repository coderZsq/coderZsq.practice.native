// 52-模板.cpp : This file contains the 'main' function. Program execution begins and ends there.
//

#include <iostream>
#include "Swap.hpp"
#include "Array.hpp"
using namespace std;

//template<class Item>
//class Array {
//	//friend ostream& operator<<(ostream&, const Array&);
//	int m_size = 0;
//	int m_capacity = 0;
//	Item* m_data = NULL;
//public:
//	Array(int capacity) {
//		if (capacity <= 0) return;
//		this->m_data = new Item[capacity] {};
//		this->m_capacity = capacity;
//	}
//
//	~Array() {
//		if (!this->m_data) return;
//
//		delete[] this->m_data;
//		this->m_data = NULL;
//	}
//
//	void add(Item value) {
//		if (this->m_size == this->m_capacity) {
//			// 扩容
//			cout << "数组已满" << endl;
//			return;
//		}
//		this->m_data[this->m_size++] = value;
//	}
//
//	Item get(int index) {
//		return (*this)[index];
//	}
//
//	int size() {
//		return this->m_size;
//	}
//
//	Item operator[](int index) {
//		if (index < 0 || index >= this->m_size) return 0;
//		return this->m_data[index];
//	}
//
//	void display() {
//		cout << "[";
//		for (int i = 0; i < this->m_size; i++) {
//			cout << this->m_data[i];
//			if (i != this->m_size - 1) {
//				cout << ", ";
//			}
//		}
//		cout << "]" << endl;
//	}
//};

//ostream& operator<<(ostream& cout, const Array& array) {
//	cout << "[";
//	for (int i = 0; i < array.m_size; i++) {
//		cout << array.m_data[i];
//		if (i != array.m_size - 1) {
//			cout << ", ";
//		}
//	}
//	return cout << "]";
//}

class Person {
	friend ostream& operator<<(ostream&, const Person&);
	int m_age;
public:
	Person(int age = 0) :m_age(age) {};
};

ostream& operator<<(ostream& cout, const Person& person) {
	return cout << "age=" << person.m_age;
}

int main() {
	/*Array<Person*> array(3);
	array.add(new Person(11));
	array.add(new Person(12));
	array.add(new Person(13));
	array.display();*/

	Array<Person> array(3);
	array.add(Person(11));
	array.add(Person(12));
	array.add(Person(13));
	array.display();

	//Array<int> array(5);
	//array.add(11);
	//array.add(22);
	//array.add(33);
	//array.add(44);
	//array.add(55);
	//array.add(66);
	//array.add(66);
	//array.add(66);
	//array.display();

	//cout << array[3] << endl;
	//cout << array.get(4) << endl;
	////cout << array << endl;

	//Array<double> array2(3);
	//array2.add(10.8);
	//array2.add(10.9);
	//array2.add(10.4);
	//array2.display();

	/*int array[] = { 10, 20, 30 };
	array[3] = 40;*/

	getchar();
	return 0;
}

//void swapValues(int& v1, int& v2) {
//	int tmp = v1;
//	v1 = v2;
//	v2 = tmp;
//}
//
//void swapValues(double& v1, double& v2) {
//	double tmp = v1;
//	v1 = v2;
//	v2 = tmp;
//}

//template <class T> void swapValues(T& v1, T& v2) {
//	T tmp = v1;
//	v1 = v2;
//	v2 = tmp;
//}

//void test();
//
//int main() {
//	test();
//
//	double a = 10.8;
//	double b = 20.4;
//	// swapValues<double>(a, b);
//	swapValues(a, b);
//	// call        swapValues<double> (03011F4h) 
//	cout << "a = " << a << ", b = " << b << endl;
//
//	int c = 10;
//	int d = 20;
//	// swapValues<int>(c, d);
//	swapValues(c, d);
//	// call        swapValues<int> (0301424h)
//	cout << "c = " << c << ", d = " << d << endl;
//
//	getchar();
//	return 0;
//}

// Run program: Ctrl + F5 or Debug > Start Without Debugging menu
// Debug program: F5 or Debug > Start Debugging menu

// Tips for Getting Started: 
//   1. Use the Solution Explorer window to add/manage files
//   2. Use the Team Explorer window to connect to source control
//   3. Use the Output window to see build output and other messages
//   4. Use the Error List window to view errors
//   5. Go to Project > Add New Item to create new code files, or Project > Add Existing Item to add existing code files to the project
//   6. In the future, to open this project again, go to File > Open > Project and select the .sln file
