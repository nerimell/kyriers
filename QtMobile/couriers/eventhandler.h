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
    QString domain = "http://couriers.applabsstory.ru/";

    /*
    int pinInput = 0;
    string mypin = "";
    */
    bool isPin= false;

signals:

public slots:
    bool getUsersInfo();
    //bool registrationPin(QString, QString, QString);
    bool updateUsersInfo(QString, QString, QString, QString, QString, QString);
    bool registration(QString, QString, QString, QString, QString, QString, QString);
    bool networkLogin(QString, QString);
    void savingToFile(QString, QString);
    //QString getMePins(QString, QString);

    bool sendStatus(int);
    int getUserStatus();
    void exitMenu();
    bool isPined();

    void setFamily(QString);
    void setPhone(QString);
    void setLogin(QString);
    void setPass(QString);
    void setMail(QString);
    bool networkLogin();
    /*
    void setMyPin(QString);
    void setPin(QString);
    void pinIncrement();
    QString getMePins();
    bool pinConnected();
    QString getMyPin();
    int getPinInput();
    void cleanMePin();
    int pinLength();
    void clearPin();
    */

    QString getFamily();
    QString getPhone();
    QString getLogin();
    QString getPass();
};

#endif // EVENTHANDLER_H
