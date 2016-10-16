import QtQuick 2.7
import QtQuick.Layouts 1.0
import QtQuick.Controls 2.0

Item {
    id: rootBasic
    anchors.fill: parent

    Timer {
        id: basicScreenTimer
        running: true
        interval:2000;
        onTriggered:loader.source="qrc:/login.qml"
    }

    //--------------------------------------------------basicScreen.qml--------------------------------------------
    Item {
        visible: true
        id: basicScreen
        anchors.fill: parent

        Image {
            x: parent.width/2 - width/2
            y: (parent.width<parent.height)? parent.height/2-height/2: 0
            height: (parent.width<parent.height)? parent.height:sourceSize.height*(width/sourceSize.width)
            width:  (parent.width<parent.height)? sourceSize.width*(parent.height/sourceSize.height): parent.width
            source: "ui/background/background1.png"
        }

        Image {
            id: imagelogo
            x: parent.width/2- imagelogo.width/2
            y: 0.5*basicScreen.height - height/2
            width: sourceSize.width/1.5 * parent.width/500
            height: sourceSize.height/1.5 * parent.width/500
            source: "ui/mainlogo.png"
        }
    }
    //-------------------------------------------------------------------------------------------------------------
}
