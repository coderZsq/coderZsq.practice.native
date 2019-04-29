// 49-运算符重载 (String).cpp : This file contains the 'main' function. Program execution begins and ends there.
//

#include <iostream>
#include "String.h"
using namespace std;

int main() {
	{
		String str1 = "abc";
		cout << str1[1] << endl;
		cout << (str1 > "aac") << endl;

		/*String str1 = "333";
		String str2 = "444";
		String str3 = str1 + str2 + "555";
		cout << str3 << endl;
		(str1 += str2) += "555";
		cout << str1 << endl;*/
	}

	/*char str1[20] = { '1', '2', '\0' };
	strcat(str1, "234");*/

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
