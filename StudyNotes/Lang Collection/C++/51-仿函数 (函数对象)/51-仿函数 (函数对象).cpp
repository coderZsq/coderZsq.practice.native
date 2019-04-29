// 51-仿函数 (函数对象).cpp : This file contains the 'main' function. Program execution begins and ends there.
//

#include <iostream>
using namespace std;

//int sum(int a, int b) {
//	return a + b;
//}

class Sum {
	int m_age;
public:
	Sum(int age) :m_age(age) {}
	int operator()(int a, int b) {
		if (this->m_age > 10) {
		}
		else {
		}
		return a + b;
	}
};

class Point {
	friend ostream& operator<<(ostream&, const Point&);
public:
	int m_x;
	int m_y;
	Point(int x, int y) :m_x(x), m_y(y) {}
};

// output stream
ostream& operator<<(ostream& cout, const Point& point) {
	return cout << "(" << point.m_x << ", " << point.m_y << ")";
}

// inout stream
istream& operator>>(istream& cin, Point& point) {
	return cin >> point.m_x >> point.m_y;
}

int main() {
	Point p1(10, 20);
	cin >> p1;
	/*cin >> p1.m_x;
	cin >> p1.m_y;*/

	cout << p1 << endl;

	/*Sum sum(20);
	cout << sum(10, 20) << endl;
	cout << sum.operator()(10, 20) << endl;*/

	getchar();
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
