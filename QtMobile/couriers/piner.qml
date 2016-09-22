import QtQuick 2.0
import QtQuick.Controls 2.0

Item {
    id: pinMenu
    visible: true

    Button {
        id: button1
        x: 176
        y: 111
        text: qsTr("Button")

        onClicked: {
            loader.source="qrc:/login.qml"
        }
    }
}
