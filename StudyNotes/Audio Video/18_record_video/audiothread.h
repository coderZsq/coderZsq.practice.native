#ifndef AUDIOTHREAD_H
#define AUDIOTHREAD_H

#include <QThread>

class AudioThread : public QThread {
    Q_OBJECT
private:
    void run();
    bool _stop = false;

public:
    explicit AudioThread(QObject *parent = nullptr);
    ~AudioThread();
};

#endif // AUDIOTHREAD_H
