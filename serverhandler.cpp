#include "membermodel.h"
#include "serverhandler.h"

#include <QDebug>
#include <QNetworkInterface>
#include <QTcpServer>
#include <QTcpSocket>
#include <QUdpSocket>

MemberModel *ServerHandler::model() const
{
    return m_model;
}

void ServerHandler::start(ServerHandler::Type type)
{
    qDebug() << "selected type is:" << type;
}

void ServerHandler::search()
{
    qDebug() << "searching for server...";
}

ServerHandler::ServerHandler(QObject *parent) : QObject(parent)
{
    m_model = new MemberModel(this);
    m_server = new QTcpServer(this);
//    m_udpSocket = new QUdpSocket(this);
//    m_udpSocket->bind(3000, QUdpSocket::ShareAddress);
    //QHostAddress(QHostAddress::Any), 3000
//    connect(m_udpSocket, &QUdpSocket::readyRead, this, &ServerHandler::onDatagramReceived);
    connect(m_server, &QTcpServer::newConnection, this, &ServerHandler::onNewConnection);
}

void ServerHandler::startServer(const QString &roomName)
{
    m_roomName = roomName;
    m_server->listen(QHostAddress::Any, 3000);

    QString ipAddress;
    QList<QHostAddress> ipAddressesList = QNetworkInterface::allAddresses();
    // use the first non-localhost IPv4 address
    for (int i = 0; i < ipAddressesList.size(); ++i) {
        if (ipAddressesList.at(i) != QHostAddress::LocalHost &&
                ipAddressesList.at(i).toIPv4Address()) {
            ipAddress = ipAddressesList.at(i).toString();
            qDebug() << "gathered IP address" << ipAddress;
        }
    }
    // if we did not find one, use IPv4 localhost
    if (ipAddress.isEmpty())
        ipAddress = QHostAddress(QHostAddress::LocalHost).toString();

    qDebug() << "server is listening on" << ipAddress << 3000;
    emit serverInitialized(ipAddress);
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

//void ServerHandler::onDatagramReceived()
//{
//    char data[64];
//    m_udpSocket->readDatagram(data, 64);
//    qDebug() << data << m_udpSocket->localAddress().toString() << m_udpSocket->localPort();
//    QByteArray ba(data);
//    if (ba.left(5) == "hello") {
//        QByteArray address = ba.remove(0, 6);
//        qDebug() << address;
//        QHostAddress(QString(address));
//    }
//}
//m_udpSocket->write(m_udpSocket->peerAddress().toString() + "\n" + QString::number(m_udpSocket->peerPort()) + "\n");
