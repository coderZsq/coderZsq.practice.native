#include "String.h"

String::String(const char* cstring) {
	/*if (!cstring) return;

	cout << "String(const char*) - new[] - " << cstring << endl;

	this->m_cstring = new char[strlen(cstring) + 1]{};
	strcpy(this->m_cstring, cstring);*/
	assign(cstring);
}

String::String(const String& string) {
	//*this = string.m_cstring;
	assign(string.m_cstring);
}

String::~String() {
	//if (!this->m_cstring) return;

	//cout << "~String() - delete[] - " << this->m_cstring << endl;

	/*delete[] this->m_cstring;
	this->m_cstring = NULL;*/

	//operator=(NULL);
	//*this = NULL;
	//(*this).operator=(NULL);
	//this->operator=(NULL);
	assign(NULL);
}

String& String::operator=(const char* cstring) {
	return assign(cstring);
}

String& String::operator=(const String& string) {
	//return operator=(string.m_cstring);
	//return *this = string.m_cstring;
	return assign(string.m_cstring);
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
