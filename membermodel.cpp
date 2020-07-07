#include "membermodel.h"

#include <QTcpSocket>
#include <QHostAddress>
#include <QQmlEngine>

MemberModel::MemberModel(QObject *parent) : QAbstractListModel(parent)
{

}

int MemberModel::rowCount(const QModelIndex &parent) const
{
    Q_UNUSED(parent)
    return m_list.size();
}

QVariant MemberModel::data(const QModelIndex &index, int role) const
{
    if (!index.isValid())
        return QVariant();
    if (index.row() >= m_list.size())
        return QVariant();
    switch (role) {
    case Qt::DisplayRole:
        return "Name: " + m_list.at(index.row())->name() + ", IP: " + m_list.at(index.row())->socket()->localAddress().toString() + ", port: " + QString::number(m_list.at(index.row())->socket()->localPort());
    }
    return QVariant();
}

void MemberModel::add(QTcpSocket *socket, const QString &name)
{
    beginInsertRows(QModelIndex(), m_list.size(), m_list.size());
    QQmlEngine::setObjectOwnership(socket, QQmlEngine::CppOwnership);
    auto s = new CustomSocket(name, socket);
    m_list << s;
    endInsertRows();
}

CustomSocket::CustomSocket(const QString &name, QTcpSocket *socket) : m_name(name), m_socket(socket)
{

}

QString CustomSocket::name() const
{
    return m_name;
}

QTcpSocket *CustomSocket::socket() const
{
    return m_socket;
}

void CustomSocket::setName(QString name)
{
    if (m_name == name)
        return;

    m_name = name;
    emit nameChanged(m_name);
}

void CustomSocket::setSocket(QTcpSocket *socket)
{
    if (m_socket == socket)
        return;

    m_socket = socket;
    emit socketChanged(m_socket);
}
