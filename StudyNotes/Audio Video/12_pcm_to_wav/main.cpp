#include "mainwindow.h"

#include <QApplication>
#include "ffmpegs.h"

extern "C" {
// 设备
#include <libavdevice/avdevice.h>
}

int main(int argc, char *argv[]) {
    WAVHeader header;
    header.riffChunkDataSize = 1568732;
    header.sampleRate = 48000;
    header.bitsPerSample = 32;
    header.numChannels = 2;
    header.blockAlign = header.bitsPerSample * header.numChannels >> 3;
    header.byteRate = header.sampleRate * header.blockAlign;
    header.dataChunkDataSize = 1568768;
    // pcm转wav文件
    FFmpegs::pcm2wav(header,
                     "/Users/zhushuangquan/Desktop/1.pcm",
                     "/Users/zhushuangquan/Desktop/1.wav");

//    WAVHeader header;
//    header.riffChunkDataSize = 1767996;
//    header.sampleRate = 44100;
//    header.bitsPerSample = 16;
//    header.numChannels = 2;
//    header.blockAlign = header.bitsPerSample * header.numChannels >> 3;
//    header.byteRate = header.sampleRate * header.blockAlign;
//    header.dataChunkDataSize = 1767960;
//    // pcm转wav文件
//    FFmpegs::pcm2wav(header,
//                     "/Users/zhushuangquan/Codes/GitHub/coderZsq.practice.native/StudyNotes/Audio Video/12_pcm_to_wav/in.pcm",
//                     "/Users/zhushuangquan/Codes/GitHub/coderZsq.practice.native/StudyNotes/Audio Video/12_pcm_to_wav/in.wav");

    // 注册设备
    avdevice_register_all();

    QApplication a(argc, argv);
    MainWindow w;
    w.show();
    return a.exec();
}
