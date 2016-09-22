#ifndef EVENTHANDLER_H
#define EVENTHANDLER_H

#include "user.h"
#include "httpnetwork.h"

class EventHandler:public QObject {
    Q_OBJECT

public:
    explicit EventHandler (QObject * parent = NULL);

    Q_INVOKABLE bool registration(QString, QString, QString, QString, QString, QString);
    Q_INVOKABLE bool network_login(QString,QString);
    Q_INVOKABLE void savingToFile(QString, QString);
    Q_INVOKABLE void exitMenu();
    Q_INVOKABLE bool isPined();

    User user;
    httpnetwork httpPost, httpGet;
    QString domain = "http://couriers.app-labs.ru/";

    bool isPin = false;
signals:

public slots:

};

#endif // EVENTHANDLER_H
