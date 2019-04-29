// 48-运算符重载 (String).cpp : This file contains the 'main' function. Program execution begins and ends there.
//

#include <iostream>
#include "String.h"
using namespace std;

int main() {
	// "123" -> const char*
	{
		String str1 = "111";
		String str2 = str1;

		// ASCII值
		// strcmp

		/*if (str2 > str1) {
		
		}

		if (str2 == str1) {
		
		}
		// strcat
		String str3 = str1 + str2;
		str1 += str2;*/

		/*char name[] = "111";
		String str = name;
		String str2("222");
		String str3 = "333";

		str3 = "5345345";
		str2 = str3;

		cout << str << endl;
		cout << str2 << endl;
		cout << str3 << endl;*/
	}
	
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
