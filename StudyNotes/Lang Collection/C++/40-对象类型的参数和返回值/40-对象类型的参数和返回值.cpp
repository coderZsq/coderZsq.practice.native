// 40-对象类型的参数和返回值.cpp : This file contains the 'main' function. Program execution begins and ends there.
//

#include <iostream>
using namespace std;

class Car {
	int m_price;
public:
	Car(int price = 0) :m_price(price) {
		cout << "Car(int) - " << this << " - " << this->m_price << endl;
	}

	Car(const Car& car) :m_price(car.m_price) {
		cout << "Car(const Car&) - " << this << " - " << this->m_price << endl;
	}
};

//void test1(Car& car) {
//
//}
void test1(Car car) {

}

Car test2() {
	Car car(10);
	return car;
}

int main() {
	Car car2 = test2();

	Car car3;
	car3 = test2();

	Car car1(10);
	test1(car1);

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
