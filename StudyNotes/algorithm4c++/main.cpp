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
#include <vector>

#include "SortTestHelper.hpp"
#include "SelectionSort.hpp"
#include "InsertionSort.hpp"
#include "MergeSort.hpp"
#include "QuickSort.hpp"
#include "HeapSort.hpp"

using namespace std;

void sortTest();

//稀疏图 - 邻接表
class SparseGraph {
private:
    int n, m;
    bool directed;
    vector<vector<int>> g;
    
public:
    SparseGraph(int n, bool directed) {
        this->n = n;
        this->m = 0;
        this->directed = directed;
        for (int i = 0; i < n; i++) {
            g.push_back(vector<int>());
        }
    }
    
    ~SparseGraph() {
        
    }
    
    int V() {return n;}
    int E() {return m;}
    
    void addEdge(int v, int w) {
        assert(v >= 0 && v < n);
        assert(w >= 0 && w < n);
        
        g[v].push_back(w);
        if (v != w && !directed) {
            g[w].push_back(v);
        }
        m++;
    }
    
    bool hasEdge(int v, int w) {
        assert(v >= 0 && v < n);
        assert(w >= 0 && w < n);
        
        for (int i = 0; i < g[n].size(); i++) {
            if (g[v][i] == w) {
                return true;
            }
        }
        return false;
    }
};

//稠密图 - 邻接矩阵
class DenseGraph {
private:
    int n, m;
    bool directed;
    vector<vector<bool>> g;

public:
    DenseGraph(int n, bool directed) {
        this->n = n;
        this->m = 0;
        this->directed = directed;
        for (int i = 0; i < n; i++) {
            g.push_back(vector<bool>(n, false));
        }
    }
    
    ~DenseGraph() {
        
    }
    
    int V() {return n;}
    int E() {return m;}
    
    void addEdge(int v, int w) {
        assert(v >= 0 && v < n);
        assert(w >= 0 && w < n);
        
        if (hasEdge(v, w)) {
            return;
        }
        
        g[v][w] = true;
        if (!directed) {
            g[w][v] = true;
        }
        m++;
    }
    
    bool hasEdge(int v, int w) {
        assert(v >= 0 && v < n);
        assert(w >= 0 && w < n);
        return g[v][w];
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
