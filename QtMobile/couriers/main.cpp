#include <QFile>
#include <QQmlContext>
#include <QApplication>
#include "eventhandler.h"
#include <QQmlApplicationEngine>

using namespace std;

int main(int argc, char *argv[]) {

    QFile file("couriers.bin");

    QGuiApplication app(argc, argv);
    // QQuickStyle::setStyle("Material");
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);

    EventHandler eventhandler;
    QQmlApplicationEngine engine;
    QQmlContext *context = engine.rootContext();
    context->setContextProperty("event_handler", &eventhandler);

    if(file.open(QIODevice::ReadOnly)) {
        eventhandler.isPin = true;
    }
    engine.load(QUrl("qrc:/loads.qml"));

    return app.exec();
}
