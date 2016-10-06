import QtQuick 2.7
import QtQuick.Layouts 1.0
import QtQuick.Controls 2.0

Item {
    id: rootBasic
    visible: true

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
            source: "ui/background1.png"
        }

        Image {
            id: imagelogo
            x: parent.width/2-imagelogo.width/2
            y: 0.21*basicScreen.height
            width: (parent.width<620)? 365 * parent.width/500: 365 * 620/500
            height: (parent.width<620)? 164 * parent.width/500: 164 * 620/500
            source: "ui/mainlogo.png"
        }

        Text {
            anchors.left: basicScreen.left
            anchors.right: basicScreen.right
            anchors.leftMargin: basicScreen.width / 2 - 100
            anchors.rightMargin: basicScreen.width/ 2 - 100

            font.pointSize: 18
            font.family: sfuiFont.name
            color: "#FFFFFF"
            y: imagelogo.y+imagelogo.height+(basicScreenButtonLogin.y-(imagelogo.y+imagelogo.height))/2-30
            horizontalAlignment: Text.AlignHCenter

            text: "Какой-то текст, слоган\nкакой-то текст"
        }

        Drawer {
            id: basicScreenDrawer
            dragMargin: 20
            height: rootBasic.height
            width: 0.75 * rootBasic.width

            Image {
                anchors.fill: parent
                source: "ui/navbarBack.png"
            }
            Image {
                x: parent.width/2 - width/2
                y: basicScreenDrawerButtonExit.y/2- height/2 - 10 * parent.height/900
                width: sourceSize.width * 500 / 750
                height: (parent.height<900)? sourceSize.height* (parent.height+100)/1334: sourceSize.height*900/1334
                source: "ui/navbarLogo.png"
            }
            Rectangle {
                y: basicScreenDrawerButtonExit.y + basicScreenDrawerButtonExit.height + 1
                color: "#87FFFFFF"
                width: parent.width
                height:parent.height - y
            }

            Button {
                id: basicScreenDrawerButtonExit
                x: 0
                y: 156 * parent.height/900
                height: (parent.height > 900)? 77 * parent.height/900: 77
                text: qsTr("Выйти из программы")

                font.pointSize: 19
                font.family: sfuiFontLight.name

                anchors.left: parent.left
                anchors.right: parent.right

                background: Rectangle {
                    color: "#87FFFFFF"
                    anchors.fill: parent
                    id: basicScreenDrawerRectangle1
                }

                Image {
                    id: basicScreenDrawerImage1
                    x: 30
                    y: parent.height/2 - sourceSize.height/2
                    source: "ui/icons/exit_blue.png"
                }

                contentItem: Text {
                        text: basicScreenDrawerButtonExit.text
                        font: basicScreenDrawerButtonExit.font
                        opacity: enabled ? 1.0 : 0.3
                        color: basicScreenDrawerButtonExit.down ? "#FFFFFF" : "#10387F"
                        leftPadding: 80
                        verticalAlignment: Text.AlignVCenter
                        elide: Text.ElideRight
                }

                onPressed: {
                    basicScreenDrawerRectangle1.opacity = 0
                    basicScreenDrawerImage1.source= "ui/icons/exit_white.png"
                }

                onPressedChanged: {
                    basicScreenDrawerRectangle1.opacity = 1
                    basicScreenDrawerImage1.source= "ui/icons/exit_blue.png"
                }

                onClicked: Qt.quit()
            }
        }

        Button {
            id: basicScreenButtonLogin
            y: 0.64* basicScreen.height
            x: parent.width/2-basicScreenButtonLogin.width/2

            height: (parent.height>900)? 70*parent.height/900: 70
            width: (parent.width<540)? 433 * parent.width/500: 433 * 540/500
            text: qsTr("Войти")
            autoRepeat: false
            autoExclusive: false
            checked: false
            checkable: false
            highlighted: false

            font.pointSize: 14
            font.family: sfuiFont.name

            onClicked: {
                loader.source="qrc:/login.qml"
            }

            background: Rectangle {
                    color: basicScreenButtonLogin.down ? "#96337CFD": "#337CFD"
            }

            contentItem: Text {
                    text: basicScreenButtonLogin.text
                    font: basicScreenButtonLogin.font
                    opacity: enabled ? 1.0 : 0.3
                    color: basicScreenButtonLogin.down ? "#FFFFFF" : "#FFFFFF"
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    elide: Text.ElideRight
            }
        }

        Button {
            id: basicScreenButtonReg
            x: parent.width/2-basicScreenButtonReg.width/2
            y: basicScreenButtonLogin.y + basicScreenButtonLogin.height + 18 * parent.height/900

            height: (parent.height>900)? 70*parent.height/900: 70
            width: (parent.width<540)? 433 * parent.width/500: 433 * 540/500
            checked: false
            checkable: false
            autoRepeat: false
            highlighted: false
            autoExclusive: false
            text: qsTr("Регистрация")

            font.pointSize: 14
            font.family: sfuiFont.name

            onClicked: {
                loader.source="qrc:/regist.qml"
            }

            background: Rectangle {
                    color: basicScreenButtonReg.down ? "#9610387E" : "#10387E"
            }

            contentItem: Text {
                    text: basicScreenButtonReg.text
                    font: basicScreenButtonReg.font
                    opacity: enabled ? 1.0 : 0.3
                    color: basicScreenButtonReg.down ? "#FFFFFF" : "#FFFFFF"
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    elide: Text.ElideRight
            }
        }
    }
    //-------------------------------------------------------------------------------------------------------------
}
