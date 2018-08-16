//
//  Component.hpp
//  algorithm4c++
//
//  Created by 朱双泉 on 2018/6/14.
//  Copyright © 2018 Castie!. All rights reserved.
//

#ifndef Component_hpp
#define Component_hpp

#include <iostream>

template <typename Graph>
class Component {
private:
    Graph &G;
    bool * visited;
    int ccount;
    int * id;
    
    void dfs(int v) {
        visited[v] = true;
        id[v] = ccount;
        typename Graph::adjIterator adj(G, v);
        for (int i = adj.begin(); !adj.end(); i = adj.next()) {
            if (!visited[i]) {
                dfs(i);
            }
        }
    }
    
public:
    Component(Graph &graph): G(graph) {
        visited = new bool[G.V()];
        id = new int[G.V()];
        ccount = 0;
        for (int i = 0; i < G.V(); i++) {
            visited[i] = false;
            id[i] = -1;
        }
        for (int i = 0; i < G.V(); i++) {
            if (!visited[i]) {
                dfs(i);
                ccount++;
            }
        }
    }
    
    ~Component() {
        delete[] visited;
        delete[] id;
    }
    
    int count() {
        return ccount;
    }
    
    bool isConnected(int v, int w) {
        assert(v >= 0 && v < G.V());
        assert(w >= 0 && w < G.V());
        return id[v] == id[w];
    }
};

#endif /* Component_hpp */
