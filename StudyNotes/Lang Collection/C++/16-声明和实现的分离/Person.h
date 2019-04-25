#pragma once

// 声明 .h 头文件
class Person {
	int m_age;
public:
	Person();
	~Person();
	void setAge(int age);
	int getAge();
};