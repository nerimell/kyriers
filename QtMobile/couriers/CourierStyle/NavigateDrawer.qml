import QtQuick 2.7
import QtQuick.Controls 2.0
import "."
import ".."

Drawer {
    id: drawer
    property int q: 1
    height: parent.height
    dragMargin:facade.toPx(20)
    width: 0.75 * parent.width

    Image {
        id: navlogoimage
        anchors.left: parent.left
        anchors.right: parent.right
        source: "qrc:/ui/navbarMenu/navbarBack.png"
        height: (parent.height<900)? sourceSize.height*900/1334: sourceSize.height*(parent.height+facade.toPx(100))/1334
    }

    Rectangle {
        clip: true
        id: cotntactRect
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        anchors.top: navlogoimage.bottom

        ListView {
            id: listView
            anchors.fill: parent
            boundsBehavior: Flickable.StopAtBounds
            Component.onCompleted: currentIndex = loader.drawerCurrentIndex

            model:  ListModel {
                    ListElement {
                        image: "qrc:/ui/navbarIcons/status_blue.png";
                        target: "Мой профиль";
                    }
                    ListElement {
                        image: "qrc:/ui/navbarIcons/orders_blue.png";
                        target: "Мои объявления";
                    }
                    ListElement {
                        image: "qrc:/ui/navbarIcons/find_blue.png";
                        target: "Найти объявление";
                    }
                    ListElement {
                        image: "qrc:/ui/navbarIcons/config_blue.png";
                        target: "Мои настройки";
                    }
                    ListElement {
                        image: "qrc:/ui/navbarIcons/exit_blue.png";
                        target: "Разлогиниться";
                    }
                }
            delegate: Component {
                id: contactDelegate
                Rectangle {
                    width: parent.width;
                    height: facade.toPx(100)
                    color: ListView.isCurrentItem ? "lightgrey" : "white"
                    MouseArea {
                        anchors.fill: parent;
                        onPressed: {
                            listView.currentIndex = index
                        }
                        onPositionChanged:{
                            listView.currentIndex = -1
                        }

                        onClicked: {
                            listView.currentIndex = index
                            loader.drawerCurrentIndex = index
                            drawer.close();
                            switch(index) {
                            case 0: loader.source="qrc:/login.qml"; break;
                            case 1: loader.source="qrc:/login.qml"; break;
                            case 2: loader.source="qrc:/login.qml"; break;
                            case 3: loader.source="qrc:/settings.qml"; break;
                            case 4: loader.source="qrc:/basic.qml"; break;
                            }
                        }
                    }
                    Row {
                        anchors{
                            leftMargin: 20
                            top: parent.top
                            left: parent.left
                            right: parent.right
                            bottom: parent.bottom
                        }
                        spacing: 25
                        Image {
                            source: image;
                            anchors.verticalCenter: parent.verticalCenter;
                        }
                        Text {
                            text: target;
                            color: "#10387F"
                            font.family: sfuiFont
                            font.pointSize: facade.toPx(19)
                            anchors.verticalCenter: parent.verticalCenter;
                        }
                    }
                }
            }
        }
    }

    Image {
        x: parent.width/2 - width/2
        y: settingScreenDrawerButtonMyStatus.y/2-height/2- facade.toPx(10)
        width: sourceSize.width * 500 / 750
        height: (parent.height<900)? sourceSize.height*900/1334: sourceSize.height*(parent.height+facade.toPx(100))/1334

        source: "qrc:/ui/navbarMenu/navbarLogo.png"
    }
}
