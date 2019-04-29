// 50-单例模式补充.cpp : This file contains the 'main' function. Program execution begins and ends there.
//

#include <iostream>
using namespace std;

class Rocket {
public:
	static Rocket* shareRocket() {
		if (ms_rocket) return ms_rocket;
		return ms_rocket = new Rocket();
	}
	static void deleteRocket() {
		if (!ms_rocket) return;
		delete ms_rocket;
		ms_rocket = NULL;
	}
private:
	static Rocket* ms_rocket;
	Rocket() {}
	Rocket(const Rocket& rocket) {}
	void operator=(const Rocket& rocket) {}
};

Rocket* Rocket::ms_rocket = NULL;

/*
单例需要禁止掉: 拷贝行为, 赋值行为
*/

int main() {

	Rocket* p1 = Rocket::shareRocket();
	Rocket* p2 = Rocket::shareRocket();
	//Rocket p3(p1); //wrong
	//*p1 = *p2; //wrong

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
