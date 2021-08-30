/*
scope.c
测试作用域
 */
#include <stdio.h>

int a = 1;

void fun()
{
    a = 2;     //这是指全局变量a
    int a = 3; //声明一个本地变量
    int b = a; //这个a指的是本地变量
    printf("in func: a=%d b=%d \n", a, b);
}