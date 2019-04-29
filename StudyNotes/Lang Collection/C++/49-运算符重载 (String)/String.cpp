#include "String.h"

String::String(const char* cstring) {
	assign(cstring);
}

String::String(const String& string) {
	assign(string.m_cstring);
}

String::~String() {
	assign(NULL);
}

String& String::operator=(const char* cstring) {
	return assign(cstring);
}

String& String::operator=(const String& string) {
	return assign(string.m_cstring);
}

String String::operator+(const char* cstring) {
	String str;
	char* newCString = join(this->m_cstring, cstring);
	if (newCString) {
		// 释放旧的堆空间
		str.assign(NULL);
		// 直接指向新开辟的堆空间
		str.m_cstring = newCString;
	}
	return str;
}

String String::operator+(const String& string) {
	return operator+(string.m_cstring);
}

String& String::operator+=(const char* cstring) {
	char* newCString = join(this->m_cstring, cstring);
	if (newCString) {
		this->assign(NULL);
		this->m_cstring = newCString;
	}
	return *this;
}

String& String::operator+=(const String& string) {
	return operator+=(string.m_cstring);
}

bool String::operator>(const char* cstring) {
	if (!this->m_cstring || !cstring) return 0;
	return strcmp(this->m_cstring, cstring) > 0;
}

bool String::operator>(const String& string) {
	return operator>(string.m_cstring);
}

char String::operator[](int index) {
	if (!this->m_cstring || index < 0) return '\0';
	if (index >= strlen(this->m_cstring)) return '\0';
	return this->m_cstring[index];
}

char* String::join(const char* cstring1, const char* cstring2) {
	if (!cstring1 || !cstring2) return NULL;

	char* newCString = new char[strlen(cstring1) + strlen(cstring2) + 1]{};
	strcat(newCString, cstring1);
	strcat(newCString, cstring2);

	cout << "new[] - " << newCString << endl;
	return newCString;
}

String& String::assign(const char* cstring) {
	// 指向一样的堆空间
	if (this->m_cstring == cstring) return *this;

	// 释放旧的字符串
	if (this->m_cstring) {
		cout << "delete[] - " << this->m_cstring << endl;

		delete[] this->m_cstring;
		this->m_cstring = NULL;
	}

	// 指向新的字符串
	if (cstring) {
		cout << "new[] - " << cstring << endl;

		this->m_cstring = new char[strlen(cstring) + 1]{};
		strcpy(this->m_cstring, cstring);
	}

	return *this;
}

ostream& operator<<(ostream& cout, const String& string) {
	if (!string.m_cstring) return cout;

	return cout << string.m_cstring;
}
