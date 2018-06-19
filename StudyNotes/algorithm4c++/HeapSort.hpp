//
//  HeapSort.hpp
//  algorithm4c++
//
//  Created by 朱双泉 on 2018/6/8.
//  Copyright © 2018 Castie!. All rights reserved.
//

#ifndef HeapSort_hpp
#define HeapSort_hpp

#include <stdio.h>
#include "MaxHeap.hpp"

template <typename T>
void __shiftDown(T arr[], int n, int k) {
    while (2 * k + 1 < n) {
        int j = 2 * k + 1; //在此轮循环中, arr[k]和arr[j]交换位置
        if (j + 1 < n && arr[j + 1] > arr[j]) {
            j += 1;
        }
        if (arr[k] >= arr[j]) {
            break;
        }
        swap(arr[k], arr[j]);
        k = j;
    }
}

template <typename T>
void heapSort(T arr[], int n) {
    //heapify
    for (int i = (n - 1) / 2; i >= 0; i--) {
        __shiftDown(arr, n, i);
    }
    for (int i = n - 1; i > 0; i--) {
        swap(arr[0], arr[i]);
        __shiftDown(arr, i, 0);
    }
}

template <typename T>
void heapSort2(T arr[], int n) {
    MaxHeap<T> maxheap = MaxHeap<T>(arr, n);
    for (int i = n - 1; i >= 0; i--) {
        arr[i] = maxheap.extractMax();
    }
}

template <typename T>
void heapSort1(T arr[], int n) {
    MaxHeap<T> maxheap = MaxHeap<T>(n);
    for (int i = 0; i < n; i++) {
        maxheap.insert(arr[i]);
    }
    for (int i = n - 1; i >= 0; i--) {
        arr[i] = maxheap.extractMax();
    }
}

#endif /* HeapSort_hpp */
