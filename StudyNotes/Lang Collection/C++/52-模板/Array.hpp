template<class Item>
class Array {
	int m_size = 0;
	int m_capacity = 0;
	Item* m_data = NULL;
public:
	Array(int capacity);
	~Array();
	void add(Item value);
	Item get(int index);
	int size();
	Item operator[](int index);
	void display();
};

#include <iostream>
using namespace std;

template <class Item>
Array<Item>::Array(int capacity) {
	if (capacity <= 0) return;
	this->m_data = new Item[capacity]{};
	this->m_capacity = capacity;
}

template <class Item>
Array<Item>::~Array() {
	if (!this->m_data) return;

	delete[] this->m_data;
	this->m_data = NULL;
}

template <class Item>
void Array<Item>::add(Item value) {
	if (this->m_size == this->m_capacity) {
		// 扩容
		cout << "数组已满" << endl;
		return;
	}
	this->m_data[this->m_size++] = value;
}

template <class Item>
Item Array<Item>::get(int index) {
	return (*this)[index];
}

template <class Item>
int Array<Item>::size() {
	return this->m_size;
}

template <class Item>
Item Array<Item>::operator[](int index) {
	if (index < 0 || index >= this->m_size) return 0;
	return this->m_data[index];
}

template <class Item>
void Array<Item>::display() {
	cout << "[";
	for (int i = 0; i < this->m_size; i++) {
		cout << this->m_data[i];
		if (i != this->m_size - 1) {
			cout << ", ";
		}
	}
	cout << "]" << endl;
}