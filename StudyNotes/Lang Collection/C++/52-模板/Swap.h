#pragma once

//template <class T> void swapValues(T& v1, T& v2);

template <class T> void swapValues(T& v1, T& v2) {
	T tmp = v1;
	v1 = v2;
	v2 = tmp;
}

//void swapValues(int& v1, int& v2);
//void swapValues(double& v1, double& v2);
