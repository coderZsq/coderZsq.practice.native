#include "mainwindow.h"
#include "sender.h"
#include "receiver.h"

MainWindow::MainWindow(QWidget *parent)
    : QMainWindow(parent)
{
    Sender *sender = new Sender;
    Receiver *receiver = new Receiver;

    connect(sender, &Sender::exit,
            receiver, &Receiver::handleExit);

    emit sender->exit();

    delete sender;
    delete receiver;
}

MainWindow::~MainWindow()
{
}

