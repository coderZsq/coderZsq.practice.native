#pragma once
#include <iostream>
using namespace std;

class Point {
	friend ostream& operator<<(ostream&, const Point&);
	int m_x;
	int m_y;
public:
	Point(int x, int y);
	// 运算符(操作符)重载
	Point operator+(const Point& point) const;
	Point operator-(const Point& point) const;
	const Point operator-() const;
	Point& operator+=(const Point& point);
	Point& operator-=(const Point& point);
	bool operator==(const Point& point);
	bool operator!=(const Point& point);
	//前++
	Point& operator++();
	//后++
	const Point operator++(int);
};
