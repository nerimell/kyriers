#ifndef EVENTHANDLER_H
#define EVENTHANDLER_H

#include "user.h"
#include "httpnetwork.h"

using namespace std;

class EventHandler:public QObject {
    Q_OBJECT

public:
    explicit EventHandler (QObject * parent = NULL);

    User user;
    httpnetwork httpPost, httpGet;
    QString domain = "http://couriers.app-labs.ru/";

    bool isPin= false;
    string mypin = "";

signals:

public slots:
    bool registration(QString, QString, QString, QString, QString, QString);
    bool network_login(QString,QString);
    void savingToFile(QString, QString);
    void setMyPin(QString);
    bool isPined();
    void exitMenu();
    void clearPin();
    bool network_login();
    int getMyPinLength();
};

#endif // EVENTHANDLER_H
