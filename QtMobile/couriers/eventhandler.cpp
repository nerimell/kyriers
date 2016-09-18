#include "eventhandler.h"

#include <QJsonObject>
#include <QJsonDocument>

using namespace std;

QString domain = "http://tz.app-labs.ru/";

EventHandler::EventHandler(QObject *parent) : QObject(parent) {
connect(&manager, SIGNAL(finished(QNetworkReply*)), this,SLOT(successfull_auth()));
}

void EventHandler::network_login(const QVariant &login, const QVariant &pass) {
    apiUrl = domain+ "auth/AppAuth";
    string username=login.toString().toStdString();
    string password= pass.toString().toStdString();
    qDebug() << QString(username.c_str());
    qDebug() << QString(password.c_str());
    requestString= ("username=" + username + "&password=" + password).c_str();
    QNetworkRequest request(apiUrl);
    if (sessID.size()!=0)
    request.setRawHeader("Cookie", ("laravel_session=" + sessID).c_str());
    else
    request.setRawHeader("Content-Type", "application/x-www-form-urlencoded");
    reply = manager.post(request, requestString);
}

void EventHandler::successfull_auth() {
    QString str = reply->readAll();

    QList<QByteArray> headerList = reply->rawHeaderList();
    foreach(QByteArray head, headerList) {
        if (head == "Set-Cookie") {
            QString cookieString = reply->rawHeader(head);
            if (cookieString.size()!= 0)
            {
                QStringList keyValPairs=cookieString.split(";");
                foreach (QString encodedPair, keyValPairs) {
                    QStringList keyVal = encodedPair.split("=");
                    if (keyVal.at(0)=="laravel_session")
                        sessID = keyVal.at(1).toStdString();
                }
            }
        }
    }

    QJsonDocument itemDoc = QJsonDocument::fromJson(str.toStdString().c_str());
    QJsonObject itemObject = itemDoc.object();
    if (itemObject["result"].toBool())
        qDebug() << sessID.c_str();
}
