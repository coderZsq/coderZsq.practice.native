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
#include "InsertionSort.hpp"
#include "MergeSort.hpp"
#include "QuickSort.hpp"
#include "HeapSort.hpp"

using namespace std;

void sortTest();

int main(int argc, const char * argv[]) {
    
    sortTest();
    return 0;
}

void sortTest() {
    int n = 100000;
    int * arr = SortTestHelper::generateRandomArray(n, 0, 10);
    int * arr2 = SortTestHelper::copyIntArray(arr, n);
    int * arr3 = SortTestHelper::copyIntArray(arr, n);
    int * arr4 = SortTestHelper::copyIntArray(arr, n);
    int * arr5 = SortTestHelper::copyIntArray(arr, n);
    SortTestHelper::testSort("Insertion Sort", insertionSort, arr, n);
    SortTestHelper::testSort("Selection Sort", selectionSort, arr2, n);
    SortTestHelper::testSort("Merge Sort", mergeSort, arr3, n);
    SortTestHelper::testSort("Quick Sort", quickSort, arr4, n);
    SortTestHelper::testSort("Heap Sort", heapSort, arr5, n);
    delete []arr;
    delete []arr2;
    delete []arr3;
    delete []arr4;
}
