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

    Rectangle {
        color: "#51587F"
        anchors.fill: parent
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
                        target: "Информация";
                    }
                    ListElement {
                        image: "qrc:/ui/navbarIcons/orders_blue.png";
                        target: "События";
                    }
                    ListElement {
                        image: "qrc:/ui/navbarIcons/find_blue.png";
                        target: "Расписание";
                    }
                    ListElement {
                        image: "qrc:/ui/navbarIcons/config_blue.png";
                        target: "Спикеры";
                    }
                    ListElement {
                        image: "qrc:/ui/navbarIcons/exit_blue.png";
                        target: "Учатники";
                    }
                    ListElement {
                        image: "qrc:/ui/navbarIcons/exit_blue.png";
                        target: "Сообщения";
                    }
                    ListElement {image: ""; target: "";}
                    ListElement {
                        image: "qrc:/ui/navbarIcons/exit_blue.png";
                        target: "Выход";
                    }
                }
            delegate: Component {
                id: contactDelegate
                Rectangle {
                    width: parent.width;
                    height: facade.toPx(80)
                    color: ListView.isCurrentItem ? "lightgrey" : "white"
                    MouseArea {
                        anchors.fill: parent;
                        onPressed: {
                            if(index < 6 || index == 7)
                            listView.currentIndex = index
                        }
                        onPositionChanged:{
                            listView.currentIndex = -1
                        }

                        onClicked: {
                            listView.currentIndex = index
                            if(index < 6)
                            loader.drawerCurrentIndex = index
                            drawer.close();
                            switch(index) {
                            case 0: loader.source="qrc:/login.qml"; break;
                            case 1: loader.source="qrc:/login.qml"; break;
                            case 2: loader.source="qrc:/login.qml"; break;
                            case 3: loader.source="qrc:/login.qml"; break;
                            case 4: loader.source="qrc:/login.qml"; break;
                            case 5: loader.source="qrc:/login.qml"; break;
                            case 7: loader.source="qrc:/login.qml"; break;
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
                            color: "#51587F"
                            font.family: museoSansMedium
                            font.pointSize: facade.toPx(19)
                            anchors.verticalCenter: parent.verticalCenter;
                        }
                    }
                }
            }
        }
    }

    Image {
        id: navlogoimage
        x: facade.toPx(10)
        width: sourceSize.width * 500 / 750
        source: "qrc:/ui/navbarMenu/navbarLogo.png"
        height: (parent.height<900)?sourceSize.height * (900 + facade.toPx(100))/1334:sourceSize.height * (parent.height + facade.toPx(100))/1334
    }
}
