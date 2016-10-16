#include <QFile>
#include <QScreen>
#include <QQmlContext>
#include <QQuickStyle>
#include <QApplication>
#include "eventhandler.h"
#include <QQmlApplicationEngine>

using namespace std;

int main(int argc, char *argv[]) {

    /*QFile file("couriers.bin"); */

    QGuiApplication app(argc, argv);
    QQuickStyle::setStyle("EmwStyle");
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);

    EventHandler eventhandler;
    QQmlApplicationEngine engine;
    engine.addImportPath("qrc:///");
    QQmlContext *context = engine.rootContext();
    context->setContextProperty("event_handler", &eventhandler);

    /*
    if(file.open(QIODevice::ReadOnly)) {
        eventhandler.isPin = true;
    }
    */
    engine.load(QUrl("qrc:/loads.qml"));
    QObject *root_obj = engine.rootObjects().first();
    QObject *loader = root_obj->findChild<QObject*>("loader");
    loader->setProperty("dpi", (qreal)QApplication::screens().at(0)->logicalDotsPerInch());

    return app.exec();
}
