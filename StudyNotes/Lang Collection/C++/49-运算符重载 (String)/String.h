#pragma once
#include <iostream>
using namespace std;

class String {
	friend ostream& operator<<(ostream&, const String&);
public:
	String(const char* cstring = "");
	String(const String& string);
	~String();
	String& operator=(const char* cstring);
	String& operator=(const String& string);
	String operator+(const char* cstring);
	String operator+(const String& string);
	String& operator+=(const char* cstring);
	String& operator+=(const String& string);
	bool operator>(const char* cstring);
	bool operator>(const String& string);
	char operator[](int index);
private:
	char* m_cstring = NULL;
	String& assign(const char* cstring);
	char* join(const char* cstring1, const char* cstring2);
};

