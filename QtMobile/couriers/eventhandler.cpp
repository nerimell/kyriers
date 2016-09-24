#include "eventhandler.h"

#include <QFile>
#include <QJsonObject>
#include <QJsonDocument>

bool EventHandler::isPined() {
    return isPin;
}

int EventHandler::getMyPinLength() {
    if(mypin!=user.getPin())
        return mypin.length();
    return -1;
}

void EventHandler::setMyPin(QString pin) {
    mypin+= pin.toStdString();
}

void EventHandler::clearPin(){mypin = "";}

EventHandler::EventHandler(QObject *parent) : QObject(parent) {
}

void EventHandler::savingToFile(QString phone,QString mypass) {
    QFile file("couriers.txt");
    if (file.open(QIODevice::WriteOnly)) {
       file.write(QString("phone=" + phone + ";password=" + mypass + ";pin=1234").toStdString().c_str());
    }
    file.close();
}

bool EventHandler::registration(QString login, QString pass1, QString pass2, QString email, QString phone, QString city) {
    string name = login.toStdString();
    string icity = city.toStdString();
    string iphone=phone.toStdString();
    string iemail=email.toStdString();
    QUrl qUrl = domain+"auth/appRegistration";
    string password_one = pass1.toStdString();
    string password_two = pass2.toStdString();

    QByteArray
    requestString = ("phone=" + iphone + "&email=" + iemail + "&name=" + name + "&password_one=" + password_one + "&password_two=" + password_two + "&city=" + icity).c_str();

    httpPost.setUrl(&qUrl);
    QString str = httpPost.sendPost(&requestString);

    QJsonDocument itemDoc = QJsonDocument::fromJson(str.toStdString().c_str());
    QJsonObject itemObject = itemDoc.object();
    if (itemObject["result"].toBool()) {
        user.setSsid(httpPost.sessID);
        return true;
    }
    return false;
}

bool EventHandler::network_login(QString login, QString pass) {
    QUrl qUrl = domain+ "auth/AppAuth";
    string password = pass.toStdString();
    string username = login.toStdString();

    QByteArray requestString = ("phone=" + username + "&password=" + password).c_str();

    httpPost.setUrl(&qUrl);
    user.setResponse(httpPost.sendPost(&requestString).toStdString());

    // qDebug() << user.getResponse().c_str();

    QJsonDocument itemDoc= QJsonDocument::fromJson(user.getResponse().c_str());
    QJsonObject itemObject = itemDoc.object();
    if (itemObject["result"].toBool()) {
        user.setSsid(httpPost.sessID);
        return true;
    }
    return false;
}

bool EventHandler::network_login() {
    QUrl qUrl = domain+ "auth/AppAuth";
    string password = user.getPassword();
    string username = user.getUserName();

    QByteArray requestString = ("phone=" + username + "&password=" + password).c_str();

    httpPost.setUrl(&qUrl);
    user.setResponse(httpPost.sendPost(&requestString).toStdString());

    // qDebug() << user.getResponse().c_str();

    QJsonDocument itemDoc= QJsonDocument::fromJson(user.getResponse().c_str());
    QJsonObject itemObject = itemDoc.object();
    if (itemObject["result"].toBool()) {
        user.setSsid(httpPost.sessID);
        return true;
    }
    return false;
}

void EventHandler::exitMenu() {
    QUrl qUrl = domain+ "auth/appLogout";
    httpGet.setUrl(&qUrl);
    httpPost.sendGet();
    user.setSsid("");
}
