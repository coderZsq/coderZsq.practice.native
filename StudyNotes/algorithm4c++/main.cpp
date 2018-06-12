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

class UnionFind5 {
private:
    int * parent;
    int * rank;//rank[i]表示以i为根的集合所表示的树的层数
    int count;
    
public:
    UnionFind5(int count) {
        parent = new int[count];
        rank = new int[count];
        this->count = count;
        for (int i = 0; i < count; i++) {
            parent[i] = i;
            rank[i] = 1;
        }
    }
    
    ~UnionFind5() {
        delete []parent;
        delete []rank;
    }
    
    int find(int p) {
        assert(p >= 0 && p < count);
        while (p != parent[p]) {
            parent[p] = parent[parent[p]];
            p = parent[p];
        }
        return p;
//        if (p != parent[p]) {
//            parent[p] = find(parent[p]);
//        }
//        return parent[p];
    }
    
    bool isConnected(int p, int q) {
        return find(p) == find(q);
    }
    void unionElements(int p, int q) {
        int pRoot = find(p);
        int qRoot = find(q);
        if (pRoot == qRoot) {
            return;
        }
        if (rank[pRoot] < rank[qRoot]) {
            parent[pRoot] = qRoot;
        } else if (rank[qRoot] < rank[pRoot]) {
            parent[qRoot] = pRoot;
        } else {//rank[pRoot] == rank[qRoot]
            parent[pRoot] = qRoot;
            rank[qRoot] += 1;
        }
    }
};

class UnionFind4 {
private:
    int * parent;
    int * rank;//rank[i]表示以i为根的集合所表示的树的层数
    int count;
    
public:
    UnionFind4(int count) {
        parent = new int[count];
        rank = new int[count];
        this->count = count;
        for (int i = 0; i < count; i++) {
            parent[i] = i;
            rank[i] = 1;
        }
    }
    
    ~UnionFind4() {
        delete []parent;
        delete []rank;
    }
    
    int find(int p) {
        assert(p >= 0 && p < count);
        while (p != parent[p]) {
            p = parent[p];
        }
        return p;
    }
    
    bool isConnected(int p, int q) {
        return find(p) == find(q);
    }
    void unionElements(int p, int q) {
        int pRoot = find(p);
        int qRoot = find(q);
        if (pRoot == qRoot) {
            return;
        }
        if (rank[pRoot] < rank[qRoot]) {
            parent[pRoot] = qRoot;
        } else if (rank[qRoot] < rank[pRoot]) {
            parent[qRoot] = pRoot;
        } else {//rank[pRoot] == rank[qRoot]
            parent[pRoot] = qRoot;
            rank[qRoot] += 1;
        }
    }
};

class UnionFind3 {
private:
    int * parent;
    int * sz;//sz[i]表示以i为根的集合中元素个数
    int count;
    
public:
    UnionFind3(int count) {
        parent = new int[count];
        sz = new int[count];
        this->count = count;
        for (int i = 0; i < count; i++) {
            parent[i] = i;
            sz[i] = 1;
        }
    }
    
    ~UnionFind3() {
        delete []parent;
        delete []sz;
    }
    
    int find(int p) {
        assert(p >= 0 && p < count);
        while (p != parent[p]) {
            p = parent[p];
        }
        return p;
    }
    
    bool isConnected(int p, int q) {
        return find(p) == find(q);
    }
    void unionElements(int p, int q) {
        int pRoot = find(p);
        int qRoot = find(q);
        if (pRoot == qRoot) {
            return;
        }
        if (sz[pRoot] < sz[qRoot]) {
            parent[pRoot] = qRoot;
            sz[qRoot] += sz[pRoot];
        } else {
            parent[qRoot] = pRoot;
            sz[pRoot] += sz[qRoot];
        }
    }
};

class UnionFind2 {
private:
    int * parent;
    int count;
    
public:
    UnionFind2(int count) {
        parent = new int[count];
        this->count = count;
        for (int i = 0; i < count; i++) {
            parent[i] = i;
        }
    }
    
    ~UnionFind2() {
        delete []parent;
    }
    
    int find(int p) {
        assert(p >= 0 && p < count);
        while (p != parent[p]) {
            p = parent[p];
        }
        return p;
    }
    
    bool isConnected(int p, int q) {
        return find(p) == find(q);
    }
    void unionElements(int p, int q) {
        int pRoot = find(p);
        int qRoot = find(q);
        if (pRoot == qRoot) {
            return;
        }
        parent[pRoot] = qRoot;
    }
};

class UnionFind {
private:
    int * id;
    int count;
    
public:
    UnionFind(int n) {
        count = n;
        id = new int[n];
        for (int i = 0; i < n; i++) {
            id[i] = i;
        }
    }
    
    ~UnionFind() {
        delete []id;
    }
    
    int find(int p) {
        assert(p >= 0 && p < count);
        return id[p];
    }
    
    bool isConnected(int p, int q) {
        return find(p) == find(q);
    }
    
    void unionElements(int p, int q) {
        int pID = find(p);
        int qID = find(q);
        if (pID == qID) {
            return;
        }
        for (int i = 0; i < count; i++) {
            if (id[i] == pID) {
                id[q] = qID;
            }
        }
    }
};

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
