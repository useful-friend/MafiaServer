#ifndef SERVERHANDLER_H
#define SERVERHANDLER_H

#include <QObject>

class QTcpServer;
class MemberModel;

class ServerHandler : public QObject
{
    Q_OBJECT
    QString m_roomName;
    QTcpServer *m_server;
    MemberModel *m_model;
public:
    explicit ServerHandler(QObject *parent = nullptr);
    Q_INVOKABLE void startServer(const QString &roomName);
    Q_INVOKABLE MemberModel *model() const;

signals:
    void serverInitialized();
private:
    void onNewConnection();
};

#endif // SERVERHANDLER_H
