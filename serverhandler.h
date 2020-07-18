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
    enum Type {
        God,
        Player
    };
    Q_ENUM(Type)
    explicit ServerHandler(QObject *parent = nullptr);
    Q_INVOKABLE void startServer(const QString &roomName);
    Q_INVOKABLE MemberModel *model() const;
    Q_INVOKABLE void start(Type type);
    Q_INVOKABLE void search(); //search for server

private:
    void onNewConnection();
//    void onDatagramReceived();
signals:
    void serverInitialized(const QString &ipAddress);
};

#endif // SERVERHANDLER_H
