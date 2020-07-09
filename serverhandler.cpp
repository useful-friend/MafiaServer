#include "membermodel.h"
#include "serverhandler.h"

#include <QDebug>
#include <QTcpServer>
#include <QTcpSocket>
#include <QUdpSocket>

MemberModel *ServerHandler::model() const
{
    return m_model;
}

ServerHandler::ServerHandler(QObject *parent) : QObject(parent)
{
    m_model = new MemberModel(this);
    m_server = new QTcpServer(this);
    m_udpSocket = new QUdpSocket(this);
    m_udpSocket->bind(3000, QUdpSocket::ShareAddress);
    //QHostAddress(QHostAddress::Any), 3000
    connect(m_udpSocket, &QUdpSocket::readyRead, this, &ServerHandler::onDatagramReceived);
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
    if (socket == 0)
        return;
    if (!socket->waitForReadyRead())
        return;
    auto read = socket->readAll();
    if (read.isEmpty())
        return;
    QString name = QString(read);
    m_model->add(socket, name);
}

void ServerHandler::onDatagramReceived()
{
    char data[64];
    m_udpSocket->readDatagram(data, 64);
    qDebug() << data;
    if (QByteArray(data) == "hello") {
        if (m_udpSocket->open(QIODevice::WriteOnly))
            qDebug() << "sent" << m_udpSocket->writeDatagram(QString::number(m_udpSocket->peerAddress().toIPv4Address()).toLatin1(), m_udpSocket->peerAddress(), m_udpSocket->peerPort());
        else
            qDebug("not open");
    }
}
//m_udpSocket->write(m_udpSocket->peerAddress().toString() + "\n" + QString::number(m_udpSocket->peerPort()) + "\n");
