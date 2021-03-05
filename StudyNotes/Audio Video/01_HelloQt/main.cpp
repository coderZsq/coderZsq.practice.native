#include "mainwindow.h"

#include <QApplication>

// 导入头文件【也可以不导入， 因为<QApplication>中已经包含了<QByteArray>】
#include <QByteArray>

int main(int argc, char *argv[])
{
    // 通过qputenv函数设置QT_SCALE_FACTOR为1
    qputenv("QT_SCALE_FACTOR", QByteArray("1"));

    QApplication a(argc, argv);
    MainWindow w;
    w.show();
    return a.exec();
}
