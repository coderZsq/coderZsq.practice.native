#include "receiver.h"
#include <QDebug>

Receiver::Receiver(QObject *parent) : QObject(parent)
{

}

void Receiver::handleExit()
{
    qDebug() << "Receiver::handleExit";
}
