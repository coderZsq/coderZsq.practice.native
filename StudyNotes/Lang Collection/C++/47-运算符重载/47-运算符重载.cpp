// 47-运算符重载.cpp : This file contains the 'main' function. Program execution begins and ends there.
//

#include <iostream>
#include "Point.h"
using namespace std;
// operator overload

//class Point {
//	friend Point operator+(const Point& p1, const Point& p2);
//	int m_x;
//	int m_y;
//public:
//	Point(int x, int y) :m_x(x), m_y(y) {}
//	void display() {
//		cout << "(" << this->m_x << ", " << this->m_y << ")" << endl;
//	}
//};
//
//// 运算符(操作符)重载
//Point operator+(const Point& p1, const Point& p2) {
//	return Point(p1.m_x + p2.m_x, p1.m_y + p2.m_y);
//}

//class Point {
//	friend ostream& operator<<(ostream&, const Point&);
//	int m_x;
//	int m_y;
//public:
//	Point(int x, int y) :m_x(x), m_y(y) {}
//	void display() const {
//		cout << "(" << this->m_x << ", " << this->m_y << ")" << endl;
//	}
//	// 运算符(操作符)重载
//	Point operator+(const Point& point) const {
//		cout << "operator+" << endl;
//		return Point(this->m_x + point.m_x, this->m_y + point.m_y);
//	}
//
//	Point operator-(const Point& point) const {
//		return Point(this->m_x - point.m_x, this->m_y - point.m_y);
//	}
//
//	const Point operator-() const {
//		return Point(-this->m_x, -this->m_y);
//	}
//	
//	Point& operator+=(const Point& point) {
//		this->m_x += point.m_x;
//		this->m_y += point.m_y;
//		return *this;
//	}
//
//	Point& operator-=(const Point& point) {
//		this->m_x -= point.m_x;
//		this->m_y -= point.m_y;
//		return *this;
//	}
//
//	bool operator==(const Point& point) {
//		// 1 YES true
//		// 0 NO false
//		return (this->m_x == point.m_x) && (this->m_y == point.m_y);
//	}
//
//	bool operator!=(const Point& point) {
//		return (this->m_x != point.m_x) || (this->m_y != point.m_y);
//	}
//
//	//前++
//	Point& operator++() {
//		this->m_x++;
//		this->m_y++;
//		return *this;
//	}
//
//	//后++
//	const Point operator++(int) {
//		Point point(this->m_x, this->m_y);
//		this->m_x++;
//		this->m_y++;
//		return point;
//	}
//
//	/*Point& operator<<(int age) {
//		return *this;
//	}*/
//};
//
//ostream& operator<<(ostream& cout, const Point& point) {
//	return cout << "(" << point.m_x << ", " << point.m_y << ")";
//}


class Person {
	int m_age;
public:
	void run() {
	
	}

	void run() const {
	
	}

	static void test() {
	
	}
};

int main() {
	const Person person;
	person.test();

	Point p0(5, 10);
	Point p1(10, 20);
	Point p2(20, 30);
	Point p3 = p1++ + p2;
	// Java.toString  OC.decription
	cout << p0 << p1 << p2 << p3 << endl;

	cout << p0 << endl;
	//operator<<(cout, p0);

	cout << p1 << endl;
	cout << p2 << endl;
	cout << p3 << endl;

	/*cout << 1 << 2 << 3;
	p0 << 1 << 2 << 3;*/

	//(++p1) = Point(10, 20);
	//(p1++) = Point(10, 20); //wrong

	// 运算符重载: 最好保留运算符以前的语义

	/*p1.display();
	p3.display();*/

	//int a = 10;
	//int b = a++ + 8;
	/*
	mov         eax,dword ptr [a]  
	add         eax,8  
	mov         dword ptr [b],eax  
	mov         ecx,dword ptr [a]  
	add         ecx,1  
	mov         dword ptr [a],ecx 
	*/
	//int c = ++a + 8;
	/*
	mov         eax,dword ptr [a]  
	add         eax,1  
	mov         dword ptr [a],eax  
	mov         ecx,dword ptr [a]  
	add         ecx,8  
	mov         dword ptr [c],ecx 
	*/
	//cout << a << endl;

	/*p1 -= p2;
	p1.display();*/

	/*(-p1).display();
	(-(-p1)).display();
	p1.operator-().operator-()*/;
	//(-p1) = Point(30, 40); //wrong

	/*cout << (p1 == p2) << endl;
	cout << (p1 != p2) << endl;*/

	//Point* p = new Point(10, 20);
	/*
	call        operator new (0D113C0h) 
	*/

	//Point p3 = p0 + p1 + p2;
	/*
	call        operator+ (0FB10C8h)
	*/
	//Point p3 = p1.operator+(p2);
	//Point p3 = operator+(p1, p2);
	/*p3.display();

	Point p4 = p1 - p2;
	p4.display();

	(p1 += p2) = Point(100, 200);
	p1.display();*/

	/*int a = 10;
	int b = 20;
	(a += b) = 50;
	cout << a << endl;*/

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
