#include "mainwindow.h"
#include "ui_mainwindow.h"

#include <QDebug>
#include <QFile>

extern "C" {
// 设备
#include <libavdevice/avdevice.h>
// 格式
#include <libavformat/avformat.h>
// 工具 (比如错误处理)
#include <libavutil/avutil.h>
}

#ifdef Q_OS_WIN
    #define FMT_NAME "dshow"
    #define DEVICE_NAME "audio=麦克风阵列 (Realtek(R) Audio)"
#else
    #define FMT_NAME "avfoundation"
    #define DEVICE_NAME ":1"
    #define FILENAME "/Users/zhushuangquan/Desktop/out.pcm"
#endif

MainWindow::MainWindow(QWidget *parent)
    : QMainWindow(parent)
    , ui(new Ui::MainWindow)
{
    ui->setupUi(this);

}

MainWindow::~MainWindow()
{
    delete ui;
}


void MainWindow::on_audioButton_clicked()
{
    const char *fmtName = FMT_NAME;
    // 获取输入格式对象
    AVInputFormat *fmt = av_find_input_format(fmtName);
    if (!fmt) {
        qDebug() << "获取输入格式对象失败" << fmtName;
        return;
    }

    // 格式上下文 (将来可以利用上下文操作设备)
    AVFormatContext *ctx = nullptr;
    // 设备名称
    const char *deviceName = DEVICE_NAME;
    // 打开设备
    int ret = avformat_open_input(&ctx, deviceName, fmt, nullptr);
    if (ret < 0) {
        char errbuf[1024];
        av_strerror(ret, errbuf, sizeof(errbuf));
        qDebug() << "打开设备失败" << errbuf;
        return;
    }

    // 文件名
    const char *filename = FILENAME;
    QFile file(filename);

    // 打开文件
    // WriteOnly: 只写模式. 如果文件不存在, 就创建文件; 如果文件存在, 就会清空文件内容.
    if (file.open(QFile::WriteOnly)) {
        qDebug() << "文件打开失败" << filename;

        // 关闭设备
        avformat_close_input(&ctx);
        return;
    }

    // 采集的次数
    int count = 50;

    // 数据包
    AVPacket pkt;
    // 不断采集数据
    while (count-- > 0 && av_read_frame(ctx, &pkt) == 0) {
        // 将数据写入文件
        file.write((const char *)pkt.data, pkt.size);
    }

    // 释放资源
    // 关闭文件
    file.close();

    // 关闭设备
    avformat_close_input(&ctx);
}
