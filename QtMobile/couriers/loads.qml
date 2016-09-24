import QtQuick 2.7
import QtQuick.Controls 2.0

ApplicationWindow {
    id: root
    width: 500
    height: 900
    visible: true
    title: qsTr("couriers app-labs")

    Loader {
        anchors.fill: parent
        id: loader
        source: event_handler.isPined()? "qrc:/piner.qml":"qrc:/login.qml"
    }
}
