#include "httpnetwork.h"

httpnetwork::httpnetwork() {

}

void httpnetwork::setUrl(QUrl *qUrl) {
 request = new QNetworkRequest(*qUrl);
}

void httpnetwork::httpsettsessionID() {
    QEventLoop loop;
    QObject::connect(reply, SIGNAL(finished()), &loop, SLOT(quit()));
    loop.exec();

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
}

void httpnetwork::sendGet() {
    request->setRawHeader("Content-Type", "application/x-www-form-urlencoded");
    if (sessID.length() != 0)
        request->setRawHeader("Cookie", ("laravel_session=" + sessID).c_str());
    reply = manager.get(*request);
}

QString httpnetwork::sendPost(QByteArray *requestString) {
    request->setRawHeader("Content-Type", "application/x-www-form-urlencoded");
    if (sessID.length() != 0)
        request->setRawHeader("Cookie", ("laravel_session=" + sessID).c_str());
    reply= manager.post(*request, *requestString);

    this->httpsettsessionID();

    return reply -> readAll();
}
