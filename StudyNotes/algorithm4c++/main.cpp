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
#include <iomanip>

#include "SortTestHelper.hpp"
#include "SelectionSort.hpp"
#include "InsertionSort.hpp"
#include "MergeSort.hpp"
#include "QuickSort.hpp"
#include "HeapSort.hpp"

#include "DenseGraph.hpp"
#include "SparseGraph.hpp"
#include "ReadGraph.hpp"
#include "Component.hpp"
#include "Path.hpp"
#include "ShortestPath.hpp"
#include "LazyPrimMST.hpp"
#include "PrimMST.hpp"
#include "UnionFind.hpp"

using namespace std;

string path = "/Users/zhushuangquan"
              "/Native Drive/GitHub"
              "/coderZsq.target.swift/StudyNotes/algorithm4c++/";

// Kruskal算法
template <typename Graph, typename Weight>
class KruskalMST{
    
private:
    vector<Edge<Weight>> mst;   // 最小生成树所包含的所有边
    Weight mstWeight;           // 最小生成树的权值
    
public:
    // 构造函数, 使用Kruskal算法计算graph的最小生成树
    KruskalMST(Graph &graph){
        
        // 将图中的所有边存放到一个最小堆中
        MinHeap<Edge<Weight>> pq( graph.E() );
        for( int i = 0 ; i < graph.V() ; i ++ ){
            typename Graph::adjIterator adj(graph,i);
            for( Edge<Weight> *e = adj.begin() ; !adj.end() ; e = adj.next() )
                if( e->v() < e->w() )
                    pq.insert(*e);
        }
        
        // 创建一个并查集, 来查看已经访问的节点的联通情况
        UnionFind5 uf = UnionFind5(graph.V());
        while( !pq.isEmpty() && mst.size() < graph.V() - 1 ){
            
            // 从最小堆中依次从小到大取出所有的边
            Edge<Weight> e = pq.extractMin();
            // 如果该边的两个端点是联通的, 说明加入这条边将产生环, 扔掉这条边
            if( uf.isConnected( e.v() , e.w() ) )
                continue;
            
            // 否则, 将这条边添加进最小生成树, 同时标记边的两个端点联通
            mst.push_back( e );
            uf.unionElements( e.v() , e.w() );
        }
        
        mstWeight = mst[0].wt();
        for( int i = 1 ; i < mst.size() ; i ++ )
            mstWeight += mst[i].wt();
    }
    
    ~KruskalMST(){ }
    
    // 返回最小生成树的所有边
    vector<Edge<Weight>> mstEdges(){
        return mst;
    };
    
    // 返回最小生成树的权值
    Weight result(){
        return mstWeight;
    };
};

int main(int argc, const char * argv[]) {
    
    string filename = "testG3.txt";
    int V = 8;
    
    SparseGraph<double> g = SparseGraph<double>(V, false);
    ReadGraph<SparseGraph<double>, double> readGraph(g, path + filename);
    
    //Test Lazy Prim MST
    cout<<"Test Lazy Prim MST: "<<endl;
    LazyPrimMST<SparseGraph<double>, double> lazyPrimMST(g);
    vector<Edge<double>> mst = lazyPrimMST.mstEdges();
    for (int i = 0; i < mst.size(); i++) {
        cout<<mst[i]<<endl;
    }
    cout<<"The MST weight is: "<<lazyPrimMST.result()<<endl;
    cout<<endl;
    
    //Test Prim MST
    cout<<"Test Prim MST: "<<endl;
    PrimMST<SparseGraph<double>, double> primMST(g);
    mst = primMST.mstEdges();
    for (int i = 0; i < mst.size(); i++) {
        cout<<mst[i]<<endl;
    }
    cout<<"The MST weight is: "<<primMST.result()<<endl;
    cout<<endl;
    
    //Test Kruskal MST
    cout<<"Test Kruskal MST: "<<endl;
    KruskalMST<SparseGraph<double>, double> kruskalMST(g);
    mst = kruskalMST.mstEdges();
    for (int i = 0; i < mst.size(); i++) {
        cout<<mst[i]<<endl;
    }
    cout<<"The MST weight is: "<<kruskalMST.result()<<endl;
    
    return 0;
}

void graphTest6() {
    
    string filename = "testG3.txt";
    int V = 8;
    cout<<fixed<<setprecision(2);
    
    //Test Weighted Dense Graph
    DenseGraph<double> g1 = DenseGraph<double>(V, false);
    ReadGraph<DenseGraph<double>, double> readGraph1(g1, path + filename);
    g1.show();
    cout<<endl;
    
    //Test Weighted Sparse Graph
    SparseGraph<double> g2 = SparseGraph<double>(V, false);
    ReadGraph<SparseGraph<double>, double> readGraph2(g2, path + filename);
    g2.show();
    cout<<endl;
}

void graphTest5() {
    
//    string filename = "testG2.txt";
//    SparseGraph g = SparseGraph(7, false);
//    ReadGraph<SparseGraph> readGraph(g, path + filename);
//    g.show();
//    cout<<endl;
//
//    Path<SparseGraph> dfs(g, 0);
//    cout<<"DFS : ";
//    dfs.showPath(6);
//
//    ShortestPath<SparseGraph> bfs(g, 0);
//    cout<<"BFS : ";
//    bfs.showPath(6);
}

void graphTest4() {
    
//    string filename = "testG2.txt";
//    SparseGraph g = SparseGraph(7, false);
//    ReadGraph<SparseGraph> readGraph(g, path + filename);
//    g.show();
//    cout<<endl;
//
//    Path<SparseGraph> dfs(g, 0);
//    cout<<"DFS : ";
//    dfs.showPath(6);
}

void graphTest3() {
    
//    //TestG1.txt
//    string filename1 = "testG1.txt";
//    SparseGraph g1 = SparseGraph(13, false);
//    ReadGraph<SparseGraph> readGraph1(g1, path + filename1);
//    Component<SparseGraph> component1(g1);
//    cout<<"TestG1.txt, Component Count: "<<component1.count()<<endl;
//
//    //TestG2.txt
//    string filename2 = "testG2.txt";
//    SparseGraph g2 = SparseGraph(7, false);
//    ReadGraph<SparseGraph> readGraph2(g2, path + filename2);
//    Component<SparseGraph> component2(g2);
//    cout<<"TestG2.txt, Component Count: "<<component2.count()<<endl;
    
}

void graphTest2() {
//
//    string filename = "testG1.txt";
//    SparseGraph g1(13, false);
//    ReadGraph<SparseGraph> readGraph1(g1, path + filename);
//    g1.show();
//
//    cout<<endl;
//
//    DenseGraph g2(13, false);
//    ReadGraph<DenseGraph> readGraph2(g2, path + filename);
//    g2.show();
}

void graphTest() {
    
//    int N = 20;
//    int M = 100;
//
//    srand(time(NULL));
//
//    //Sparse Graph
//    SparseGraph g1(N, false);
//    for (int i = 0; i < M; i++) {
//        int a = rand() % N;
//        int b = rand() % N;
//        g1.addEdge(a, b);
//    }
//    //O(E)
//    for (int v = 0; v < N; v++) {
//        cout<<v<<" : ";
//        SparseGraph::adjIterator adj(g1, v);
//        for (int w = adj.begin(); !adj.end(); w = adj.next()) {
//            cout<<w<<" ";
//        }
//        cout<<endl;
//    }
//
//    //Dense Graph
//    DenseGraph g2(N, false);
//    for (int i = 0; i < M; i++) {
//        int a = rand() % N;
//        int b = rand() % N;
//        g2.addEdge(a, b);
//    }
//    //O(V ^ 2)
//    for (int v = 0; v < N; v++) {
//        cout<<v<<" : ";
//        DenseGraph::adjIterator adj(g2, v);
//        for (int w = adj.begin(); !adj.end(); w = adj.next()) {
//            cout<<w<<" ";
//        }
//        cout<<endl;
//    }
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
