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

#include "ReadGraph.hpp"

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
    
    void show() {
        for (int i = 0; i < n; i++) {
            cout<<"vertex "<<i<<":\t";
            for (int j = 0; j < g[i].size(); j++) {
                cout<<g[i][j]<<"\t";
            }
            cout<<endl;
        }
    }
    
    class adjIterator {
    private:
        SparseGraph &G;
        int v;
        int index;
    public:
        adjIterator(SparseGraph &graph, int v): G(graph) {
            this->v = v;
            this->index = 0;
        }
        
        int begin() {
            index = 0;
            if (G.g[v].size()) {
                return G.g[v][index];
            }
            return -1;
        }
        
        int next() {
            index++;
            if (index < G.g[v].size()) {
                return G.g[v][index];
            }
            return -1;
        }
        
        bool end() {
            return index >= G.g[v].size();
        }
    };
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
    
    void show() {
        for (int i = 0; i < n; i++) {
            for (int j = 0; j < n; j++) {
                cout<<g[i][j]<<"\t";
            }
            cout<<endl;
        }
    }
    
    class adjIterator {
    private:
        DenseGraph &G;
        int v;
        int index;
    public:
        adjIterator(DenseGraph &graph, int v): G(graph) {
            this->v = v;
            this->index = -1;
        }
        
        int begin() {
            index = -1;
            return next();
        }
        
        int next() {
            for (index += 1; index < G.V(); index++) {
                if (G.g[v][index]) {
                    return index;
                }
            }
            return -1;
        }
        
        bool end() {
            return index >= G.V();
        }
    };
};

int main(int argc, const char * argv[]) {
    
    string path = "/Users/zhushuangquan"
                  "/Native Drive/GitHub"
                  "/coderZsq.target.swift/StudyNotes/algorithm4c++/";
    
    string filename = "testG1.txt";
    SparseGraph g1(13, false);
    ReadGraph<SparseGraph> readGraph1(g1, path + filename);
    g1.show();
    
    cout<<endl;
    
    DenseGraph g2(13, false);
    ReadGraph<DenseGraph> readGraph2(g2, path + filename);
    g2.show();
    
    return 0;
}

void graphTest() {
    int N = 20;
    int M = 100;
    
    srand(time(NULL));
    
    //Sparse Graph
    SparseGraph g1(N, false);
    for (int i = 0; i < M; i++) {
        int a = rand() % N;
        int b = rand() % N;
        g1.addEdge(a, b);
    }
    //O(E)
    for (int v = 0; v < N; v++) {
        cout<<v<<" : ";
        SparseGraph::adjIterator adj(g1, v);
        for (int w = adj.begin(); !adj.end(); w = adj.next()) {
            cout<<w<<" ";
        }
        cout<<endl;
    }
    
    //Dense Graph
    DenseGraph g2(N, false);
    for (int i = 0; i < M; i++) {
        int a = rand() % N;
        int b = rand() % N;
        g2.addEdge(a, b);
    }
    //O(V ^ 2)
    for (int v = 0; v < N; v++) {
        cout<<v<<" : ";
        DenseGraph::adjIterator adj(g2, v);
        for (int w = adj.begin(); !adj.end(); w = adj.next()) {
            cout<<w<<" ";
        }
        cout<<endl;
    }
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
