#include <QQuickView>
#include "eventhandler.h"
#include <QGuiApplication>
#include <QQmlApplicationEngine>

using namespace std;
int main(int argc, char *argv[]) {

    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
    QGuiApplication app(argc, argv);
    qmlRegisterType<EventHandler>("couriers.EventHandler", 1, 0, "EventHandler");
    QQmlApplicationEngine engine;
    engine.load(QUrl("qrc:/main.qml"));

    return app.exec();
}
