#ifndef MEMBERMODEL_H
#define MEMBERMODEL_H

#include <QAbstractListModel>

class QTcpSocket;

class CustomSocket : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QString name READ name WRITE setName NOTIFY nameChanged)
    Q_PROPERTY(QTcpSocket* socket READ socket WRITE setSocket NOTIFY socketChanged)

    QString m_name;
    QTcpSocket* m_socket;

public:
    CustomSocket(const QString &name, QTcpSocket *socket);
    QString name() const;
    QTcpSocket* socket() const;
    void setName(QString name);
    void setSocket(QTcpSocket* socket);

signals:
    void nameChanged(QString name);
    void socketChanged(QTcpSocket* socket);
};

class MemberModel : public QAbstractListModel
{
    Q_OBJECT
    QList<CustomSocket *> m_list;
public:
    explicit MemberModel(QObject *parent = nullptr);
    int rowCount(const QModelIndex &parent) const override;
    QVariant data(const QModelIndex &index, int role) const override;
    void add(QTcpSocket *socket, const QString &name);
};

#endif // MEMBERMODEL_H
