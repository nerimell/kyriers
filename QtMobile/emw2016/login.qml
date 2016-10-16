import QtQuick 2.7
import QtQuick.Layouts 1.0
import QtQuick.Controls 2.0
import "EmwStyle" as EmwStyle

Item {
    id: rootlogin
    anchors.fill: parent


    //--------------------------------------------------loginScreen.qml---------------------------------------------
    Item {
        visible: true
        id: loginScreen
        anchors.fill: parent

        MouseArea {
            id: mouseArea1
            anchors.fill: parent
            drag.axis: Drag.YAxis
            drag.maximumY: 0.22 * parent.height
            drag.target: mainScreenTextFieldLogin
            drag.minimumY: (parent.height<900)? 900/parent.height: 0.22*parent.height
        }

        Image {
            x: parent.width/2 - width/2
            y: (parent.width<parent.height)?parent.height/2-height/2:0
            height: (parent.width<parent.height)?parent.height:sourceSize.height*(width/sourceSize.width)
            width: (parent.width<parent.height)?sourceSize.width*(parent.height/sourceSize.height):parent.width
            source: "ui/background/background4.png"
        }

        Text {
            color: "#FFFFFF"
            font.family: museoSansMedium.name
            font.pointSize: facade.toPx(17)
            horizontalAlignment: Text.AlignHCenter

            anchors.left: parent.left
            anchors.right: parent.right
            anchors.leftMargin: parent.width /2 - 50
            anchors.rightMargin: parent.width/2 - 50
            y: facade.toPx(25) + font.pointSize/2 - facade.toPx(7)

            text: "Вход"
        }

        Button {
            id: mainScreenButtonLogin
            y:(parent.height>900)? mainScreenTextFieldPass.y + facade.toPx(100):mainScreenTextFieldPass.y + 100
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.leftMargin: 0.09 * parent.width
            anchors.rightMargin: 0.09* parent.width
            height: (parent.height> 900)? facade.toPx(70): 70
            checked: false
            checkable: false
            autoRepeat: false
            highlighted: false
            text: qsTr("Войти")
            autoExclusive: false

            font.pointSize: facade.toPx(16)

            onClicked: {
                loader.source = "qrc:/chat.qml"
                /*
                if(mainScreenTextFieldLogin.text.length<11) {
                    dialogAndroid.text = "Укажите корректный номер"
                    dialogAndroid.visible=true;
                }
                else
                if(mainScreenTextFieldPass.text.length < 5) {
                    dialogAndroid.text = "Пароль короче 5 символов"
                    dialogAndroid.visible=true;
                }
                else {
                    loginScreen.visible = false
                    busyIndicatorScreen.visible = true
                    if(event_handler.networkLogin(mainScreenTextFieldLogin.text, mainScreenTextFieldPass.text)) {
                        if(mainScreencheckBoxRememberMe.checked)
                        event_handler.savingToFile(mainScreenTextFieldLogin.text, mainScreenTextFieldPass.text);
                        loader.source = "qrc:/main.qml"
                    }
                    else {
                        dialogAndroid.text = "Вы не зарегистрированы"
                        loginScreen.visible = true
                        dialogAndroid.visible=true;
                    }
                    busyIndicatorScreen.visible = false
                }
                */
            }

            background: Rectangle {
                    radius: facade.toPx(15)
                    color: mainScreenButtonLogin.down ?"#960f133d":"#760f133d"
            }

            contentItem: Text {
                    text: mainScreenButtonLogin.text
                    font: mainScreenButtonLogin.font
                    opacity: enabled ? 1.0 : 0.3
                    color: mainScreenButtonLogin.down ? "#FFFFFF" : "#FFFFFF"
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    elide: Text.ElideRight
            }
        }

        Button {
            id: mainScreenLabelForgotPass
            y: (parent.height > 900)? mainScreenButtonLogin.y + facade.toPx(90): mainScreenButtonLogin.y + 90
            text: qsTr("Еще нет аккаунта?")

            font.pointSize: facade.toPx(16)

            //font.underline: true
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.leftMargin: 0.09 * parent.width
            anchors.rightMargin: 0.09 * parent.width

            onClicked: {
                loader.source = "qrc:/regist.qml"
            }
            background: Rectangle {
                opacity: 0
            }
            contentItem: Text {
                text: mainScreenLabelForgotPass.text
                font: mainScreenLabelForgotPass.font
                opacity: enabled ? 1.0 : 0.3
                color: mainScreenLabelForgotPass.down ? "#960f133d" : "#FFFFFF"
                padding: -8
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                elide: Text.ElideRight
            }
        }


        TextField {
            y: 0.22 * parent.height
            height: (parent.height > 900)? facade.toPx(44): 44
            anchors.left: parent.left
            anchors.right: parent.right
            id: mainScreenTextFieldLogin
            placeholderText: qsTr("Номер телефона")
            anchors.rightMargin:0.09 * parent.width
            anchors.leftMargin: 0.09 * parent.width + facade.toPx(50)

            onFocusChanged: {
                if(text.length== 0)
                text = "+7"
            }
            background: Rectangle {
                opacity: 0
            }

            color: "#FFFFFF"
            validator: DoubleValidator {}
            verticalAlignment: Text.AlignVCenter
            inputMethodHints: {
                Qt.ImhFormattedNumbersOnly
            }
            font.pointSize:facade.toPx(18)
        }
        Rectangle { // ебаное нижнее подчеркивание. Ага, оно делается вот блять так!
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.leftMargin: 0.09 * parent.width
            anchors.rightMargin: 0.09 * parent.width
            y: mainScreenTextFieldLogin.y + mainScreenTextFieldLogin.height + facade.toPx(20)
            height: 1
            border.width: 1
            border.color: "#FFFFFF"
        }
        Image {
            width: facade.toPx(sourceSize.width)
            height: facade.toPx(sourceSize.height)
            x: mainScreenTextFieldLogin.x - facade.toPx(47)
            source: "ui/screensIcons/phoneIcon.png"
            y: (parent.height>900)?mainScreenTextFieldLogin.y + mainScreenTextFieldLogin.height - sourceSize.height + facade.toPx(7): mainScreenTextFieldLogin.y+mainScreenTextFieldLogin.height-sourceSize.height + 7
        }

        TextField {
            id: mainScreenTextFieldPass
            height: (parent.height > 900)? facade.toPx(44): 44
            anchors.left: parent.left
            anchors.right: parent.right
            placeholderText: qsTr("Введите пароль")
            anchors.rightMargin:0.09 * parent.width
            anchors.leftMargin: 0.09 * parent.width + facade.toPx(50)
            y: (parent.height > 900)? mainScreenTextFieldLogin.y+ facade.toPx(100): mainScreenTextFieldLogin.y + 100

            color: "#FFFFFF"
            echoMode: TextInput.Password
            font.pointSize: facade.toPx(18)
            verticalAlignment: Text.AlignVCenter

            background: Rectangle { opacity: 0 }
        }
        Rectangle { // ебаное нижнее подчеркивание. Ага, оно делается вот блять так!
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.leftMargin: 0.09 * parent.width
            anchors.rightMargin: 0.09 * parent.width
            y: mainScreenTextFieldPass.y + mainScreenTextFieldPass.height + facade.toPx(20)
            height: 1
            border.width: 1
            border.color: "#FFFFFF"
        }
        Image {
            width: facade.toPx(sourceSize.width)
            height: facade.toPx(sourceSize.height)
            x: mainScreenTextFieldPass.x - facade.toPx(47)
            source: "ui/screensIcons/passIcon.png"
            y: (parent.height>900)?mainScreenTextFieldPass.y + mainScreenTextFieldPass.height - sourceSize.height + facade.toPx(7): mainScreenTextFieldPass.y + mainScreenTextFieldPass.height - sourceSize.height + 7
        }
    }
    //-------------------------------------------------------------------------------------------------------------

    EmwStyle.BusyIndicator {
        id: busyIndicatorScreen
    }

    EmwStyle.DialogWindow {
        id: dialogAndroid
    }
}
