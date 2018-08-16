//
//  SelectionSort.hpp
//  SQAlgorithm
//
//  Created by 朱双泉 on 2018/6/6.
//  Copyright © 2018 Castie!. All rights reserved.
//

#ifndef SelectionSort_hpp
#define SelectionSort_hpp

#include <stdio.h>

template <typename T>
void selectionSort(T arr[], int n) {
    for (int i = 0; i< n; i++) {
        //寻找[i, n]区间内的最小值
        int minIndex = i;
        for (int j = i + 1; j < n; j++) {
            if (arr[j] < arr[minIndex]) {
                minIndex = j;
            }
        }
        swap(arr[i], arr[minIndex]);
    }
}

#endif /* SelectionSort_hpp */
