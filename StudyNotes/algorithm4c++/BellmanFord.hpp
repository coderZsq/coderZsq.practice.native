//
//  BellmanFord.hpp
//  algorithm4c++
//
//  Created by 朱双泉 on 2018/6/26.
//  Copyright © 2018 Castie!. All rights reserved.
//

#ifndef BellmanFord_hpp
#define BellmanFord_hpp

#include <stdio.h>

template <typename Graph, typename Weight>
class BellmanFord {
private:
    Graph &G;
    int s;
    Weight * distTo;
    vector<Edge<Weight>*> from;
    bool hasNegativeCycle;
    
    bool detectNegativeCycle() {
        for (int i = 0; i < G.V(); i++) {
            typename Graph::adjIterator adj(G, i);
            for (Edge<Weight> * e = adj.begin(); !adj.end(); e = adj.next()) {
                if (!from[e->w()] || distTo[e->v()] + e->wt() < distTo[e->w()]) {
                    return true;
                }
            }
        }
        return false;
    }
public:
    BellmanFord(Graph &graph, int s): G(graph) {
        this->s = s;
        distTo = new Weight[G.V()];
        for (int i = 0; i < G.V(); i++) {
            from.push_back(NULL);
        }
        
        //Bellman-Ford
        distTo[s] = Weight();
        for (int pass = 1; pass < G.V(); pass++) {
            for (int i = 0; i < G.V(); i++) {
                typename Graph::adjIterator adj(G, i);
                //Relaxation
                for (Edge<Weight> * e = adj.begin(); !adj.end(); e = adj.next()) {
                    if (!from[e->w()] || distTo[e->v()] + e->wt() < distTo[e->w()]) {
                        distTo[e->w()] = distTo[e->v()] + e->wt();
                        from[e->w()] = e;
                    }
                }
            }
        }
        
        hasNegativeCycle = detectNegativeCycle();
    }
    
    ~BellmanFord() {
        delete [] distTo;
    }
    
    bool negativeCycle() {
        return hasNegativeCycle;
    }
    
    Weight shortestPathTo(int w) {
        assert(w >= 0 && w < G.V());
        assert(!hasNegativeCycle);
        return distTo[w];
    }
    
    bool hasPathTo(int w) {
        assert(w >= 0 && w < G.V());
        return from[w] != NULL;
    }
    
    void shortestPath(int w, vector<Edge<Weight>> &vec) {
        assert(w >= 0 && w < G.V());
        assert(!hasNegativeCycle);
        
        stack<Edge<Weight>*> s;
        Edge<Weight> *e = from[w];
        while (e->v() != this->s) {
            s.push(e);
            e = from[e->v()];
        }
        s.push(e);
        
        while (!s.empty()) {
            e = s.top();
            vec.push_back(*e);
            s.pop();
        }
    }
    
    void showPath(int w) {
        
        assert(w >= 0 && w < G.V());
        assert(!hasNegativeCycle);
        
        vector<Edge<Weight>> vec;
        shortestPath(w, vec);
        for (int i = 0; i < vec.size(); i++) {
            cout<<vec[i].v()<<" -> ";
            if (i == vec.size() - 1) {
                cout<<vec[i].w()<<endl;
            }
        }
    }
};

#endif /* BellmanFord_hpp */
