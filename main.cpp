#include "membermodel.h"
#include "serverhandler.h"

#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include <QQuickStyle>

int main(int argc, char *argv[])
{
    qputenv("QT_IM_MODULE", QByteArray("qtvirtualkeyboard"));

    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);

    qmlRegisterUncreatableType<MemberModel>("MemberModel", 1, 0, "MemberModel", "Object is not createable");

    QGuiApplication app(argc, argv);
    ServerHandler serverHandler;
    QQmlApplicationEngine engine;
    engine.rootContext()->setContextProperty("ServerHandler", &serverHandler);
    QQuickStyle::setStyle("Material");
    const QUrl url(QStringLiteral("qrc:/main.qml"));
    QObject::connect(&engine, &QQmlApplicationEngine::objectCreated,
                     &app, [url](QObject *obj, const QUrl &objUrl) {
        if (!obj && url == objUrl)
            QCoreApplication::exit(-1);
    }, Qt::QueuedConnection);
    engine.load(url);

    return app.exec();
}
