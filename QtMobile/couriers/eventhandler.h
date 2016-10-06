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

    int pinInput = 0;
    bool isPin= false;
    string mypin = "";

signals:

public slots:
    bool registration(QString, QString, QString, QString, QString, QString, QString);
    bool registrationPin(QString, QString, QString);
    bool network_login(QString,QString);
    void savingToFile(QString, QString);
    QString getMePin (QString, QString);

    bool pinConnected();
    int pinLength();
    void exitMenu();
    void clearPin();
    bool isPined();

    void setFamily(QString);
    void setMyPin(QString);
    void setPhone(QString);
    void setLogin(QString);
    void setPass(QString);
    void setMail(QString);
    void setPin(QString);
    bool network_login();
    int getPinInput();
    void cleanMePin();
    void pinIncr();

    QString getFamily();
    QString getMePin();
    QString getMyPin();
    QString getPhone();
    QString getLogin();
    QString getPass();
};

#endif // EVENTHANDLER_H
