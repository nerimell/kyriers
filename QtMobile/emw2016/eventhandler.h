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
    int linecount = 0;// for textArea in chat
    int lengthTArea=0;// for textArea in chat
    int symbolsArea=1;// for textArea in chat
    bool isPin= false;
    string mypin = "";
    bool backArea= false;// for textArea chat
    bool rekursia= false;// for textArea chat

signals:

public slots:
    bool getUsersInfo();
    bool registrationPin(QString, QString, QString);
    bool updateUsersInfo(QString, QString, QString, QString, QString, QString);
    bool registration(QString, QString, QString, QString, QString, QString, QString);
    bool networkLogin(QString, QString);
    void savingToFile(QString, QString);
    QString getMePins(QString, QString);

    void setBackArea(bool);// for textArea in chat
    void setRekursia(bool);// for textArea in chat
    bool sendStatus(int);
    bool pinConnected();
    int getUserStatus();
    int pinLength();
    void exitMenu();
    void clearPin();
    bool isPined();

    int lineCount(int); // for textArea in chat
    int charTextAreaLength(int);// for textArea
    void setFamily(QString);
    void setMyPin(QString);
    void setPhone(QString);
    void setLogin(QString);
    int charsTextArea(int);
    void setPass(QString);
    void setMail(QString);
    void setPin(QString);
    bool networkLogin();
    void pinIncrement();
    int getPinInput();
    void cleanMePin();
    bool isBackArea();// for textArea in chat
    bool isRekursia();// for textArea in chat

    QString getFamily();
    QString getMePins();
    QString getMyPin();
    QString getPhone();
    QString getLogin();
    QString getPass();
};

#endif // EVENTHANDLER_H
