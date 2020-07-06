#include "serverhandler.h"

#include <QTimer>

ServerHandler::ServerHandler(QObject *parent) : QObject(parent)
{

}

void ServerHandler::startServer()
{
    qDebug("starting server");
    QTimer::singleShot(5000, this, &ServerHandler::serverInitialized);
}
