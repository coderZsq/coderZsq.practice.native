// 04-内联函数.cpp : This file contains the 'main' function. Program execution begins and ends there.
//

#include <iostream>
using namespace std;

/*
函数代码量不是很多
函数的调用频率比较高
*/
//inline int sum(int a, int b);

//#define sum(a, b) ((a) + (b))

inline int sum(int a) { //22
	return a + a;
}

inline int sum(int a, int b) {
	return a + b;
}

//#define sum(a) a + a; //24

int main()
{
	cout << sum(10, 20) << endl;

	int d = 10;
	cout << sum(++d); 

	//int c = sum(10, 20);
	/*int c = sum(10, 20);
	cout << c << endl;*/

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
