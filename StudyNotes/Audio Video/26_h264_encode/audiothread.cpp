#include "audiothread.h"

#include <QDebug>
#include "ffmpegs.h"

AudioThread::AudioThread(QObject *parent) : QThread(parent) {
    // 当监听到线程结束时（finished），就调用deleteLater回收内存
    connect(this, &AudioThread::finished,
            this, &AudioThread::deleteLater);
}

AudioThread::~AudioThread() {
    // 断开所有的连接
    disconnect();
    // 内存回收之前，正常结束线程
    requestInterruption();
    // 安全退出
    quit();
    wait();
    qDebug() << this << "析构（内存被回收）";
}

void AudioThread::run() {
    VideoEncodeSpec in;
    in.filename = "/Users/zhushuangquan/Desktop/out.yuv";
    in.width = 640;
    in.height = 480;
    in.fps = 30;
    in.pixFmt = AV_PIX_FMT_YUV420P;
    FFmpegs::h264Encode(in, "/Users/zhushuangquan/Desktop/out1.h264");
}
