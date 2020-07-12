#ifndef SERVERHANDLER_H
#define SERVERHANDLER_H

#include <QObject>

class QTcpServer;
class QUdpSocket;
class MemberModel;

class ServerHandler : public QObject
{
    Q_OBJECT
    QString m_roomName;
    QTcpServer *m_server;
//    QUdpSocket *m_udpSocket;
    MemberModel *m_model;
public:
    explicit ServerHandler(QObject *parent = nullptr);
    Q_INVOKABLE void startServer(const QString &roomName);
    Q_INVOKABLE MemberModel *model() const;

private:
    void onNewConnection();
//    void onDatagramReceived();
signals:
    void serverInitialized(const QString &ipAddress);
};

#endif // SERVERHANDLER_H
