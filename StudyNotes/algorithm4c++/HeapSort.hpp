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

template <typename Item>
class IndexMaxHeap {
private:
    Item * data;
    int * indexes;
    int * reverse;
    int count;
    int capacity;
    
    void shiftUp(int k) {
        while (k > 1 && data[indexes[k / 2]] < data[indexes[k]]) {
            swap(indexes[k / 2], indexes[k]);
            reverse[indexes[k / 2]] = k / 2;
            reverse[indexes[k]] = k;
            k /= 2;
        }
    }
    
    void shiftDown(int k) {
        while (2 * k <= count) {
            int j = 2 * k; //在此轮循环中, data[k]和data[j]交换位置
            if (j + 1 <= count && data[indexes[j + 1]] > data[indexes[j]]) {
                j += 1;
            }
            if (data[indexes[k]] >= data[indexes[j]]) {
                break;
            }
            swap(indexes[k], indexes[j]);
            reverse[indexes[k]] = k;
            reverse[indexes[j]] = j;
            k = j;
        }
    }
public:
    IndexMaxHeap(int capacity) {
        data = new Item[capacity + 1];
        indexes = new int[capacity + 1];
        reverse = new int[capacity + 1];
        for (int i = 0; i <= capacity; i++) {
            reverse[i] = 0;
        }
        count = 0;
        this->capacity = capacity;
    }
    
    ~IndexMaxHeap() {
        delete []data;
        delete []indexes;
        delete []reverse;
    }
    
    int size() {
        return count;
    }
    
    bool isEmpty() {
        return count == 0;
    }
    //传入的i对用户而言, 是从0索引的
    void insert(int i, Item item) {
        
        assert(count + 1 <= capacity);
        assert(i + 1 >= 1 && i + 1 <= capacity);
        
        i += 1;
        data[i] = item;
        indexes[count + 1] = i;
        reverse[i] = count + 1;
        
        count++;
        shiftUp(count);
    }
    
    Item extractMax() {
        assert(count > 0);
        Item ret = data[indexes[1]];
        swap(indexes[1], indexes[count]);
        reverse[indexes[1]] = 1;
        reverse[indexes[count]] = 0;
        count--;
        shiftDown(1);
        return ret;
    }
    
    Item extractMaxIndex() {
        assert(count > 0);
        int ret = indexes[1] - 1;
        swap(indexes[1], indexes[count]);
        reverse[indexes[1]] = 1;
        reverse[indexes[count]] = 0;
        count--;
        shiftDown(1);
        return ret;
    }
    
    bool contain(int i) {
        assert(i + 1 >= 1 && i + 1 <= capacity);
        return reverse[i + 1] != 0;
    }
    
    Item getItem(int i) {
        assert(contain(i));
        return data[i + 1];
    }
    
    void change(int i, Item newItem) {
        
        assert(contain(i));
        i += 1;
        data[i] = newItem;
        
        //找到indexes[j] = i, j表示data[i]在堆中的位置
        //之后shiftUp(j), 再shiftDown(j)
        //        for (int j = 1; j <= count; j++) {
        //            if (indexes[j] == i) {
        //                shiftUp(j);
        //                shiftDown(j);
        //                return;
        //            }
        //        }
        int j = reverse[i];
        shiftUp(j);
        shiftDown(j);
    }
};

template <typename Item>
class MaxHeap {
private:
    Item * data;
    int count;
    int capacity;
    
    void shiftUp(int k) {
        while (k > 1 && data[k / 2] < data[k]) {
            swap(data[k / 2], data[k]);
            k /= 2;
        }
    }
    
    void shiftDown(int k) {
        while (2 * k <= count) {
            int j = 2 * k; //在此轮循环中, data[k]和data[j]交换位置
            if (j + 1 <= count && data[j + 1] > data[j]) {
                j += 1;
            }
            if (data[k] >= data[j]) {
                break;
            }
            swap(data[k], data[j]);
            k = j;
        }
    }
public:
    MaxHeap(int capacity) {
        data = new Item[capacity + 1];
        count = 0;
        this->capacity = capacity;
    }
    
    MaxHeap(Item arr[], int n) {
        data = new Item[n + 1];
        capacity = n;
        for (int i = 0; i < n; i++) {
            data[i + 1] = arr[i];
        }
        count = n;
        for (int i = count / 2; i >= 1; i--) {
            shiftDown(i);
        }
    }
    
    ~MaxHeap() {
        delete []data;
    }
    
    int size() {
        return count;
    }
    
    bool isEmpty() {
        return count == 0;
    }
    
    void insert(Item item) {
        
        assert(count + 1 <= capacity);
        data[count + 1] = item;
        count++;
        shiftUp(count);
    }
    
    Item extractMax() {
        assert(count > 0);
        Item ret = data[1];
        swap(data[1], data[count]);
        count--;
        shiftDown(1);
        return ret;
    }
};

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
