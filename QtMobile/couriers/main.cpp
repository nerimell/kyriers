#include <QFile>
#include <QQmlContext>
#include <QApplication>
#include "eventhandler.h"
#include <QQmlApplicationEngine>

using namespace std;
int main(int argc, char *argv[]) {

    QGuiApplication app(argc, argv);
    //QQuickStyle::setStyle("Material");
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);

    EventHandler eventhandler;
    QQmlApplicationEngine engine;
    QQmlContext *context = engine.rootContext();
    context->setContextProperty("event_handler", &eventhandler);

    //qmlRegisterType<EventHandler>("couriers.EventHandler", 1, 0, "EventHandler");

    QFile file("couriers.txt");

    if(file.open(QIODevice::ReadOnly)) {
        eventhandler.isPin = true;

        QString memberString = file.readAll();
        if (memberString.size()!= 0)
        {
            QStringList keyValPairs=memberString.split(";");
            foreach (QString encodedPair, keyValPairs) {
                QStringList keyVal = encodedPair.split("=");
                if (keyVal[0] == "phone"){
                    eventhandler.user.setUserName(keyVal.at(1).toStdString());
                }
                else if (keyVal[0] == "password")
                    eventhandler.user.setPassword(keyVal.at(1).toStdString());
                else if (keyVal[0] == "pin")
                    eventhandler.user.setPin(keyVal.at(1).toStdString());
            }
        }
        file.close();

        //qDebug()<<eventhandler.user.getUserName().c_str();
        //qDebug()<<eventhandler.user.getPassword().c_str();
    }

    engine.load(QUrl("qrc:/loads.qml"));

    return app.exec();
}
