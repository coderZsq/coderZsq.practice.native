//
//  LazyPrimMST.hpp
//  algorithm4c++
//
//  Created by 朱双泉 on 2018/6/19.
//  Copyright © 2018 Castie!. All rights reserved.
//

#ifndef LazyPrimMST_hpp
#define LazyPrimMST_hpp

#include <stdio.h>
#include "MinHeap.hpp"

template <typename Graph, typename Weight>
class LazyPrimMST {
private:
    Graph & G;
    MinHeap<Edge<Weight>> pq;
    bool * marked;
    vector<Edge<Weight>> mst;
    Weight mstWeight;
    
    void visit(int v) {
        assert(!marked[v]);
        marked[v] = true;
        typename Graph::adjIterator adj(G, v);
        for (Edge<Weight> * e = adj.begin(); !adj.end(); e = adj.next()) {
            if (!marked[e->other(v)]) {
                pq.insert(*e);
            }
        }
    }
    
public:
    LazyPrimMST(Graph & graph): G(graph), pq(MinHeap<Edge<Weight>>(graph.E())) {
        marked = new bool[G.V()];
        for (int i = 0; i < G.V(); i++) {
            marked[i] = false;
        }
        mst.clear();
        
        //Lazy Prim
        visit(0);
        while (!pq.isEmpty()) {
            Edge<Weight> e = pq.extractMin();
            if (marked[e.v()] == marked[e.w()]) {
                continue;
            }
            mst.push_back(e);
            if (!marked[e.v()]) {
                visit(e.v());
            } else {
                visit(e.w());
            }
        }
        
        mstWeight = mst[0].wt();
        for (int i = 1; i < mst.size(); i++) {
            mstWeight += mst[i].wt();
        }
    }
    
    ~LazyPrimMST() {
        delete [] marked;
    }
    
    vector<Edge<Weight>> mstEdges() {
        return mst;
    };
    
    Weight result() {
        return mstWeight;
    };
};

#endif /* LazyPrimMST_hpp */
