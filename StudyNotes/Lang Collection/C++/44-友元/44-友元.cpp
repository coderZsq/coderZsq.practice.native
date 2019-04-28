// 44-友元.cpp : This file contains the 'main' function. Program execution begins and ends there.
//

#include <iostream>
using namespace std;

class Point {
	friend Point add(const Point&, const Point&);
	friend class Math;
private:
	int m_x;
	int m_y;
public:
	int getX() const { return this->m_x; };
	int getY() const { return this->m_y; };
	Point(int x, int y) :m_x(x), m_y(y) {}
	/*Point add(const Point& point1, const Point& point2) {
		return Point(point1.m_x + point2.m_x, point1.m_y + point2.m_y);
	}*/
};

class Math {
public:
	Point add(const Point& point1, const Point& point2) {
		return Point(point1.m_x + point2.m_x, point1.m_y + point2.m_y);
	}
};

//Point add(const Point& point1, const Point& point2) {
//	return Point(point1.getX() + point2.getX(), point1.getY() + point2.getY());
//}

Point add(const Point& point1, const Point& point2) {
	return Point(point1.m_x + point2.m_x, point1.m_y + point2.m_y);
}

//void test() {
//	Point point(10, 20);
//	point.add //worng
//}

int main() {
	Point point1(10, 20);
	Point point2(20, 30);

	Point point = add(point1, point2);

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
