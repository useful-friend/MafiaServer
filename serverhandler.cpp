#include "membermodel.h"
#include "serverhandler.h"

#include <QDebug>
#include <QTcpServer>
#include <QTcpSocket>

MemberModel *ServerHandler::model() const
{
    return m_model;
}

ServerHandler::ServerHandler(QObject *parent) : QObject(parent)
{
    m_model = new MemberModel(this);
    m_server = new QTcpServer(this);
    connect(m_server, &QTcpServer::newConnection, this, &ServerHandler::onNewConnection);
}

void ServerHandler::startServer(const QString &roomName)
{
    m_roomName = roomName;
    m_server->listen(QHostAddress::Any, 3000);
    qDebug("server is listening");
    emit serverInitialized();
}

void ServerHandler::onNewConnection()
{
    qDebug() << "new connection";
    auto socket = m_server->nextPendingConnection();
    socket->waitForReadyRead();
    auto read = socket->readAll();
    if (read.isEmpty())
        return;
    QString name = QString(read);
    m_model->add(socket, name);
}
