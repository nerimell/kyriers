#ifndef EVENTHANDLER_H
#define EVENTHANDLER_H

#include <QtNetwork/QNetworkReply>

using namespace std;
class EventHandler : public QObject {
    Q_OBJECT

public:
    explicit EventHandler(QObject *parent = NULL);

    Q_INVOKABLE void network_login(const QVariant &, const QVariant &);

    QUrl apiUrl;
    QNetworkReply *reply;
    QByteArray requestString;
    QNetworkAccessManager manager;

    string sessID="";

signals:

public slots:
    void  successfull_auth();
};

#endif // EVENTHANDLER_H
