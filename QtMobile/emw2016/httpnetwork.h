#ifndef HTTPNETWORK_H
#define HTTPNETWORK_H

#include <QEventLoop>
#include <QtNetwork/QNetworkReply>

using namespace std;

class httpnetwork
{
public:
    string sessID = "";
    QNetworkReply *reply;
    QNetworkRequest *request;
    QNetworkAccessManager manager;

    httpnetwork();
    void setUrl(QUrl*);
    void httpsettsessionID();

public slots:
    void sendGet();
    QString sendPost(QByteArray*);

};

#endif // HTTPNETWORK_H
