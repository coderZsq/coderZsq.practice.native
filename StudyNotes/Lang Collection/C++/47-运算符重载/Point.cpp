#include "Point.h"

Point::Point(int x, int y) :m_x(x), m_y(y) {}
// 运算符(操作符)重载
Point Point::operator+(const Point& point) const {
	return Point(this->m_x + point.m_x, this->m_y + point.m_y);
}

Point Point::operator-(const Point& point) const {
	return Point(this->m_x - point.m_x, this->m_y - point.m_y);
}

const Point Point::operator-() const {
	return Point(-this->m_x, -this->m_y);
}
	
Point& Point::operator+=(const Point& point) {
	this->m_x += point.m_x;
	this->m_y += point.m_y;
	return *this;
}

Point& Point::operator-=(const Point& point) {
	this->m_x -= point.m_x;
	this->m_y -= point.m_y;
	return *this;
}

bool Point::operator==(const Point& point) {
	// 1 YES true
	// 0 NO false
	return (this->m_x == point.m_x) && (this->m_y == point.m_y);
}

bool Point::operator!=(const Point& point) {
	return (this->m_x != point.m_x) || (this->m_y != point.m_y);
}

//前++
Point& Point::operator++() {
	this->m_x++;
	this->m_y++;
	return *this;
}

//后++
const Point Point::operator++(int) {
	Point point(this->m_x, this->m_y);
	this->m_x++;
	this->m_y++;
	return point;
}

ostream& operator<<(ostream& cout, const Point& point) {
	return cout << "(" << point.m_x << ", " << point.m_y << ")";
}

