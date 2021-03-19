#include "mainwindow.h"

#include <QApplication>
#include <iostream>

extern "C" {
// 设备
#include <libavdevice/avdevice.h>
}


int main(int argc, char *argv[])
{
    // 注册设备
    avdevice_register_all();

    // C语言
    printf("printf----");

    // C++
    std::cout << "std::cout-----";

    // FFmpeg


    QApplication a(argc, argv);
    MainWindow w;
    w.show();
    return a.exec();
}
