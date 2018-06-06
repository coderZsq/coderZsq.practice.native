//
//  main.cpp
//  alogrithm4c++
//
//  Created by 朱双泉 on 2018/6/6.
//  Copyright © 2018 Castie!. All rights reserved.
//

#include <iostream>
#include <algorithm>
#include <string>

#include "SortTestHelper.hpp"
#include "SelectionSort.hpp"

using namespace std;

template <typename T>
void insertionSort(T arr[], int n) {
    for (int i = 1; i < n; i++) {
        //寻找元素arr[i]合适的插入位置
        T e = arr[i];
        int j; //j保存元素e应该插入的位置
        for (j = i; j > 0 && arr[j - 1] > e; j--) {
            arr[j] = arr[j - 1];
        }
        arr[j] = e;
    }
}

int main(int argc, const char * argv[]) {
    
    int n = 10000;
    int * arr = SortTestHelper::generateNearlyOrderdArray(n, 10);
    int * arr2 = SortTestHelper::copyIntArray(arr, n);
    SortTestHelper::testSort("Insertion Sort", insertionSort, arr, n);
    SortTestHelper::testSort("Selection Sort", selectionSort, arr, n);
    delete []arr;
    delete []arr2;
    
    return 0;
}
