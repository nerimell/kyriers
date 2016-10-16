import QtQuick 2.7
import QtQuick.Layouts 1.0
import QtQuick.Controls 2.0
import "CourierStyle" as CourierStyle

Item {
    id: firstScreen
    anchors.fill: parent

    CourierStyle.NavigateDrawer {
        id: firstScreenDrawer
    }

    Component.onCompleted: {
        if(event_handler.isPined())
            event_handler.networkLogin()
    }

    Image {
        x: parent.width/2 - width/2
        y: (parent.width<parent.height)?parent.height/2-height/2:0
        height: (parent.width<parent.height)?parent.height:sourceSize.height*(width/sourceSize.width)
        width: (parent.width<parent.height)?sourceSize.width*(parent.height/sourceSize.height):parent.width
        source: "ui/background/background4.png"
    }

    Image {
        id: firstScreenNavbarMenu
        x: 0
        anchors.topMargin: 0
        anchors.top: parent.top
        source: "ui/navbarMenu/navbarMenu.png"

        anchors.left: parent.left
        anchors.right: parent.right
        height: (parent.height > 900)? sourceSize.height * parent.height/900: sourceSize.height

        Button {
            id: firstScreenNavbarButton
            x: 20
            width: 80
            height: 48
            y: firstScreenNavbarMenu.height/2 - firstDrawerButton.height / 2

            background: Rectangle {
                opacity: 0
            }

            onClicked: {
                firstScreenDrawer.open()
            }

            Image {
                id: firstDrawerButton
                anchors.fill: parent
                source: "ui/buttons/hamButton.png"
                fillMode: Image.PreserveAspectFit
            }
        }
    }

    CourierStyle.BusyIndicator {
        id: busyIndicatorScreen
    }

    CourierStyle.DialogWindow {
        id: dialogAndroid
    }
}
//-------------------------------------------------------------------------------------------------------------
