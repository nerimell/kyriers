#include "eventhandler.h"

#include <QFile>
#include <QJsonObject>
#include <QJsonDocument>

bool EventHandler::isPined() {
    return isPin;
}

int EventHandler::pinLength() {
    if(mypin != user.getPin())
        return mypin.length();
    return -1;
}

/* for textArea in chat
bool EventHandler::isBackArea() {
    return backArea;
}

bool EventHandler::isRekursia() {
    return rekursia;
}

int EventHandler::charsTextArea(int num) {
    if(num > 0)
        symbolsArea += num;
    else if(num == 0)
        symbolsArea=-1;
    else
        symbolsArea += num;
    return symbolsArea;
}

int EventHandler::lineCount(int counter) {
    if(counter > 0)
        linecount= counter;
    return linecount;
}

void EventHandler::setBackArea(bool state) {
    backArea = state;
}

void EventHandler::setRekursia(bool state) {
    rekursia = state;
}

int EventHandler::charTextAreaLength(int len) {
    if(len > 0)
        lengthTArea = len;
    return lengthTArea;
}
*/

int EventHandler::getPinInput() {
    return pinInput;
}

QString EventHandler::getMyPin() {
    return QString(mypin.c_str());
}

void EventHandler::cleanMePin () {
    isPin= false;
    user.setPin("");
}

int EventHandler::getUserStatus(){
    return user.getStatus();
}

void EventHandler::pinIncrement(){
    pinInput++;
}

void EventHandler::setPin(QString mypin) {
    user.setPin(mypin.toStdString());
}

void EventHandler::setMyPin(QString pin) {
    mypin += pin.toStdString();
}

void EventHandler::setMail(QString mail) {
    user.setMail(mail.toStdString());
}

void EventHandler::clearPin(){mypin = "";}

QString EventHandler::getMePins() {
    return QString(user.getPin().c_str());
}

void EventHandler::setPhone(QString phone) {
    user.setNumber(phone.toStdString());
}

void EventHandler::setLogin(QString login) {
    user.setUserName(login.toStdString());
}

void EventHandler::setPass(QString mypass) {
    user.setPassword(mypass.toStdString());
}

QString EventHandler::getPhone() {
    return QString(user.getNumber().c_str());
}

void EventHandler::setFamily(QString family){
    user.setLastName(family.toStdString());
}

QString EventHandler::getFamily(){
    return QString(user.getLastName().c_str());
}

QString EventHandler::getLogin() {
    return QString(user.getUserName().c_str());
}

QString EventHandler::getPass () {
    return QString(user.getPassword().c_str());
}

EventHandler::EventHandler(QObject *parent) : QObject(parent) {
}

void EventHandler::savingToFile(QString phone,QString mypass) {
    QFile file("couriers.bin");
    if (file.open(QIODevice::WriteOnly)) {
    file.write(QString("phone="+ phone+ ";password=" + mypass).toStdString().c_str());
    }
    file.close();
}

bool EventHandler::sendStatus(int val) {
    QUrl qUrl = domain+"users/update/status";
    QByteArray requestString=("status=" + QString::number(val).toStdString()).c_str();

    httpPost.setUrl(&qUrl);
    user.setResponse(httpPost.sendPost(&requestString).toStdString());

    string response = user.getResponse();

    qDebug()<<"sendStatus "<< response.c_str();

    QJsonDocument itemDoc = QJsonDocument::fromJson(response.c_str());
    QJsonObject itemObject= itemDoc.object();
    if(itemObject["result"].toInt() == 200) {
        return true;
    }
    return false;
}

bool EventHandler::pinConnected()
{
    QFile file("couriers.bin");
    QString phone = "", pas = "";
    file.open(QIODevice::ReadOnly);
    QString memberString = file.readAll();

    if (memberString.size() !=  0)
    {
        QStringList keyValPairs=memberString.split(";");
        foreach (QString encodedPair, keyValPairs)
        {
            QStringList keyVal = encodedPair.split("=");
            if (keyVal[0]=="phone")
            user.setNumber((phone=keyVal.at(1)).toStdString());
            else if (keyVal[0]=="password")
            user.setPassword((pas=keyVal.at(1)).toStdString());
        }
    }
    file.close();

    string response = getMePins(phone,pas).toStdString();

    qDebug() << "pinConnected " << response.c_str();

    if(response.length()> 0) {
        user.setPin(response);
        return true;
    }
    return false;
}

QString EventHandler::getMePins(QString login, QString pass1) {
    string name = login.toStdString();
    string pass = pass1.toStdString();
    QUrl qUrl= domain+"app/auth/pin/get";
    QByteArray requestString=("phone=" + name+ "&password=" + pass).c_str();

    httpPost.setUrl(&qUrl);
    user.setResponse(httpPost.sendPost(&requestString).toStdString());

    string response = user.getResponse();

    qDebug() << "getMePin " << response.c_str();

    QJsonDocument itemDoc = QJsonDocument::fromJson(response.c_str());
    QJsonObject itemObject= itemDoc.object();
    return itemObject["pin_code"].toString();
}

bool EventHandler::registrationPin(QString pin, QString login, QString pass1) {
    string ipin = pin.toStdString();
    string name = login.toStdString();
    string pass = pass1.toStdString();
    QUrl qUrl= domain+"app/auth/pin/reg";
    QByteArray requestString = ("pin_code_one="+ipin+"&pin_code_two=" + ipin + "&phone=" + name+ "&password=" + pass).c_str();

    httpPost.setUrl(&qUrl);
    user.setResponse(httpPost.sendPost(&requestString).toStdString());

    string response = user.getResponse();

    qDebug() << "registrationPin " << response.c_str();

    QJsonDocument itemDoc = QJsonDocument::fromJson(response.c_str());
    QJsonObject itemObject = itemDoc.object();
    if (itemObject["result"].toInt() == 200)
        return true;
    return false;
}

bool EventHandler::getUsersInfo() {
    QByteArray requestString = "";

    QUrl qUrl = domain+"app/user/info";

    httpPost.setUrl(&qUrl);
    user.setResponse(httpPost.sendPost(&requestString).toStdString());

    string response=user.getResponse();

    qDebug() << "getUsersInfo " << response.c_str();

    QJsonDocument itemDoc = QJsonDocument::fromJson(response.c_str());
    QJsonObject itemObject = itemDoc.object();

    user.setUserName(itemObject["name"].toString().toStdString());

    user.setLastName(itemObject["lastname"].toString().toStdString());

    if (itemObject["result"].toInt() == 200) {
        return true;
    }
    return false;
}

bool EventHandler::updateUsersInfo(QString login, QString family, QString pass1, QString pass2, QString phone, QString city) {
    string name = login.toStdString();
    string icity = city.toStdString();
    string iphone = phone.toStdString();
    string famname=family.toStdString();
    QUrl qUrl = domain+"app/user/update/info";
    string password_one = pass1.toStdString();
    string password_two = pass2.toStdString();

    QByteArray requestString = ("phone=" + iphone + "&last_name=" + famname + "&name=" + name + "&password_one=" + password_one + "&password_two=" + password_two + "&city=" + icity).c_str();

    httpPost.setUrl(&qUrl);
    user.setResponse(httpPost.sendPost(&requestString).toStdString());

    string response=user.getResponse();

    qDebug() << "updateInfo " << response.c_str();

    QJsonDocument itemDoc = QJsonDocument::fromJson(response.c_str());
    QJsonObject itemObject = itemDoc.object();
    if (itemObject["result"].toInt() == 200) {
        return true;
    }
    return false;
}

bool EventHandler::registration(QString login, QString family, QString pass1, QString pass2, QString email, QString phone, QString city) {
    string name = login.toStdString();
    string icity = city.toStdString();
    string iphone = phone.toStdString();
    string iemail = email.toStdString();
    string famname=family.toStdString();
    QUrl qUrl = domain+"auth/appRegistration";
    string password_one = pass1.toStdString();
    string password_two = pass2.toStdString();

    QByteArray requestString = ("phone=" + iphone + "&last_name=" + famname + "&email=" + iemail + "&name=" + name + "&password_one=" + password_one + "&password_two=" + password_two + "&city=" + icity).c_str();

    httpPost.setUrl(&qUrl);
    user.setResponse(httpPost.sendPost(&requestString).toStdString());

    string response=user.getResponse();

    qDebug() << "Registration " << response.c_str();

    QJsonDocument itemDoc = QJsonDocument::fromJson(response.c_str());
    QJsonObject itemObject = itemDoc.object();
    if (itemObject["result"].toInt() == 200) {
        user.setSsid(httpPost.sessID);
        return true;
    }
    return false;
}

bool EventHandler::networkLogin(QString login, QString pass) {
    QUrl qUrl = domain+ "auth/AppAuth";
    string password = pass.toStdString();
    string username = login.toStdString();

    QByteArray requestString = ("phone=" + username + "&password=" + password).c_str();

    httpPost.setUrl(&qUrl);
    user.setResponse(httpPost.sendPost(&requestString).toStdString());

    string response=user.getResponse();

    qDebug() << "Login With Parameter " << response.c_str();

    if(response.length()>0) {
    QJsonDocument itemDoc = QJsonDocument::fromJson(response.c_str());
    QJsonObject itemObject = itemDoc.object();
    user.setStatus(itemObject["status"].toInt());

    if (itemObject["result"].toInt() == 200) {
        user.setSsid(httpPost.sessID);
        return true;
    }
    }
    return false;
}

bool EventHandler::networkLogin() {
    QUrl qUrl = domain + "auth/AppAuth";
    string userphone = user.getNumber();
    string password = user.getPassword();

    QByteArray requestString = ("phone=" + userphone + "&password=" + password).c_str();

    httpPost.setUrl(&qUrl);
    user.setResponse(httpPost.sendPost(&requestString).toStdString());

    string response=user.getResponse();

    qDebug() << "Login Without Params " << response.c_str();

    QJsonDocument itemDoc = QJsonDocument::fromJson(response.c_str());
    QJsonObject itemObject = itemDoc.object();
    user.setStatus(itemObject["status"].toInt());

    if (itemObject["result"].toInt() == 200) {
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
