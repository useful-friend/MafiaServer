#ifndef SERVERHANDLER_H
#define SERVERHANDLER_H

#include <QObject>

class ServerHandler : public QObject
{
    Q_OBJECT
public:
    explicit ServerHandler(QObject *parent = nullptr);
    Q_INVOKABLE void startServer();
signals:
    void serverInitialized();
};

#endif // SERVERHANDLER_H
