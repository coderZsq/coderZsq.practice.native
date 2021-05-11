#ifndef PLAYTHREAD_H
#define PLAYTHREAD_H

#include <QThread>

class PlayThread : public QThread {
    Q_OBJECT
private:

public:
    explicit PlayThread(QObject *parent = nullptr);
    ~PlayThread();
    void run();

signals:

};

#endif // PLAYTHREAD_H
