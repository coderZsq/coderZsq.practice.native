#include "mainwindow.h"

#include <QApplication>
#include <QDebug>
//#include "ffmpegs.h"

#undef main

int main(int argc, char *argv[]) {
//    RawVideoFile in = {
//        "/Users/zhushuangquan/Desktop/in.yuv",
//        512, 512, AV_PIX_FMT_YUV420P
//    };
//    RawVideoFile out = {
//        "/Users/zhushuangquan/Desktop/in.rgb",
//        512, 512, AV_PIX_FMT_RGB24
//    };
//    FFmpegs::convertRawVideo(in, out);

    QApplication a(argc, argv);
    MainWindow w;
    w.show();
    return a.exec();
}
