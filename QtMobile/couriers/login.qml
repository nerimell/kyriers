import QtQuick 2.7
import QtQuick.Layouts 1.0
import QtQuick.Dialogs 1.2
import QtQuick.Controls 2.0

Item {
    id: rootlogin
    visible: true

    //--------------------------------------------------dialogAndroid----------------------------------------------
    Dialog {
        id: dialogAndroid

        // Создаём содержимое диалогового окна
        contentItem: Rectangle {
            color: "#f7f7f7"
            width: rootlogin.width-80
            height: rootlogin.height/3

            // Область для сообщения диалогового окна
            Rectangle {
                color: "#f7f7f7"
                anchors.top: parent.top
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.bottom: dialogAndroidDividerHorizontal.top

                Label {
                    id: dialogAndroidTextLabel

                    color: "#000000"
                    font.bold: true
                    font.pointSize: 20
                    font.family: sfuiFont.name
                    anchors.centerIn: parent// put сообщение в центр области отобраэжения
                }
            }

            // Создаём горизонтальный разделитель с Rectangle
            Rectangle {
                id: dialogAndroidDividerHorizontal
                color: "#808080"
                height: 2 // Устанавливаем ширину в 2 пикселя
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.bottom: dialogAndroidrow.top
            }

            /* Создаём подложку для кнопок в виде объекта Строки
             * В данном объекте для child не работают нек-е параметры
             * anchors, кроме параметров anchors.top и anchors.bottom
             */
            Row {
                id: dialogAndroidrow
                height: 100
                // А также прибиваем строку к низу у диалогового окна
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.bottom: parent.bottom

                Button {
                    id: dialogAndroiddialogButtonCancel

                    // Растянем кнопку по высоте строки
                    anchors.top: parent.top
                    anchors.bottom: parent.bottom

                    width: parent.width / 2 - 1// ширину на половину строки минус 1 pixel

                    contentItem: Text {
                        font.pointSize: 24

                        color: "#34aadc"
                        text: qsTr("Отмена")
                        verticalAlignment: Text.AlignVCenter
                        horizontalAlignment: Text.AlignHCenter
                    }

                    background: Rectangle {
                    border.width: 0
                    color:dialogAndroiddialogButtonCancel.pressed?"#d7d7d7":"#f7f7f7"
                    }

                    //onClicked: dialogAndroid.close()// По нажатию кнопки закрыть диалог
                }

                //Создаю разделитель между кнопками шириной в 2 пикселя
                Rectangle {
                    id: dialogAndroidDividerVertical
                    width: 2
                    color: "#808080"
                    // Растягиваем разделитель по высоте объекта строки
                    anchors.top: parent.top
                    anchors.bottom: parent.bottom
                }

                Button {
                    id: dialogAndroidDialogButtonOk

                    anchors.top: parent.top
                    anchors.bottom: parent.bottom
                    width: parent.width / 2 - 1// ширину на половину строки минус 1 pixel
                    //width: parent.width// если необходима только одна кнопочка на экран

                    contentItem: Text {
                        font.bold: true
                        font.pointSize: 24

                        color: "#34aadc"
                        text: qsTr("Хорошо")
                        verticalAlignment: Text.AlignVCenter
                        horizontalAlignment: Text.AlignHCenter
                    }

                    background: Rectangle {
                        border.width: 0
                        color:dialogAndroidDialogButtonOk.pressed?"#d7d7d7":"#f7f7f7"
                    }

                    onClicked: {
                        dialogAndroid.close()
                    }
                }
            }
        }
    }
    //-------------------------------------------------------------------------------------------------------------


    //--------------------------------------------------busyIndicator----------------------------------------------
    Item {
        visible: false
        anchors.fill: parent
        id: busyIndicatorLoginScreen

        Image {
            x: parent.width/2 - width/2
            y: (parent.width<parent.height)?parent.height/2-height/2:0
            height: (parent.width<parent.height)?parent.height:sourceSize.height*(width/sourceSize.width)
            width: (parent.width<parent.height)?sourceSize.width*(parent.height/sourceSize.height):parent.width
            source: "ui/background4.png"
        }

        BusyIndicator {
            width: parent.width  /2
            height: parent.height/2
            x: parent.width/2 -width /2
            y: parent.height/2-height/2
        }
    }
    //-------------------------------------------------------------------------------------------------------------


    //--------------------------------------------------loginScreen.qml---------------------------------------------
    Item {
        visible: true
        id: loginScreen
        anchors.fill: parent

        Image {
            x: parent.width/2 - width/2
            y: (parent.width<parent.height)?parent.height/2-height/2:0
            height: (parent.width<parent.height)?parent.height:sourceSize.height*(width/sourceSize.width)
            width: (parent.width<parent.height)?sourceSize.width*(parent.height/sourceSize.height):parent.width
            source: "ui/background2.png"
        }

        Text {
            color: "#FFFFFF"
            font.pointSize: (parent.width < 600 && parent.height> 0)? 17 * parent.height/900: 17
            font.family: sfuiFont.name
            horizontalAlignment: Text.AlignHCenter

            y: mainScreenBackButton.y + mainScreenBackButton.height/2 - font.pointSize/2 -7 * parent.height/900
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.leftMargin: parent.width /2 - 50
            anchors.rightMargin: parent.width/2 - 50

            text: "Войти"
        }

        Button {
            id: mainScreenButtonLogin
            y: 0.67 * parent.height
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.leftMargin: 0.09 * parent.width
            anchors.rightMargin: 0.09* parent.width
            height: (parent.height>900)? 70*parent.height/900: 70
            checked: false
            checkable: false
            autoRepeat: false
            highlighted: false
            text: qsTr("Вход")
            autoExclusive: false

            font.pointSize: 14

            onClicked: {
                if(mainScreenTextFieldLogin.text.length<11) {
                    dialogAndroidTextLabel.text = "Укажите корректный номер"
                    dialogAndroid.open();
                }
                else
                if(mainScreenTextFieldPass.text.length < 5) {
                    dialogAndroidTextLabel.text = "Пароль короче 5 символов"
                    dialogAndroid.open();
                }
                else {
                    loginScreen.visible = false
                    busyIndicatorLoginScreen.visible = true
                    if(event_handler.network_login(mainScreenTextFieldLogin.text, mainScreenTextFieldPass.text)) {
                        if(mainScreencheckBoxRememberMe.checked)
                        event_handler.savingToFile(mainScreenTextFieldLogin.text, mainScreenTextFieldPass.text);
                        loader.source = "qrc:/main.qml"
                    }
                    else {
                        dialogAndroidTextLabel.text = "Вы не зарегистрированы"
                        loginScreen.visible = true
                        dialogAndroid.open();
                    }
                    busyIndicatorLoginScreen.visible = false
                }
            }

            background: Rectangle {
                    color: mainScreenButtonLogin.down ? "#9610387E": "#10387E"
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

        TextField {
            id: mainScreenTextFieldLogin
            y: 0.22 * loginScreen.height

            anchors.left: parent.left
            anchors.right: parent.right
            anchors.leftMargin: 0.09 * parent.width + 50
            anchors.rightMargin: 0.09 * parent.width
            height: (parent.height > 900)? 44 * (parent.height/900): 44
            placeholderText: qsTr("Номер мобильного")

            color: "#FFFFFF"
            font.pointSize: 18
            validator: DoubleValidator {}
            verticalAlignment: Text.AlignVCenter

            background: Rectangle {
                opacity: 0
            }
        }
        Rectangle { // ебаное нижнее подчеркивание. Ага, оно делается вот блять так!
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.leftMargin: 0.09 * parent.width
            anchors.rightMargin: 0.09 * parent.width
            y: mainScreenTextFieldLogin.y + mainScreenTextFieldLogin.height + 20
            height: 1
            border.width: 1
            border.color: "#FFFFFF"
        }
        Image {
            x: mainScreenTextFieldLogin.x - 47
            y: mainScreenTextFieldLogin.y + mainScreenTextFieldLogin.height - sourceSize.height + 7 / (parent.height/900)
            source: "ui/phoneIcon.png"
        }

        TextField {
            id: mainScreenTextFieldPass
            y: (parent.height > 900)? mainScreenTextFieldLogin.y+100*parent.height/900: mainScreenTextFieldLogin.y + 100
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.leftMargin: 0.09 * parent.width + 50
            anchors.rightMargin: 0.09 * parent.width
            height: (parent.height > 900)? 44 * (parent.height/900): 44
            placeholderText: qsTr("Введите пароль")

            color: "#FFFFFF"
            font.pointSize: 18
            echoMode: TextInput.Password
            verticalAlignment: Text.AlignVCenter

            background: Rectangle {
                opacity: 0
            }
        }
        Rectangle { // ебаное нижнее подчеркивание. Ага, оно делается вот блять так!
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.leftMargin: 0.09 * parent.width
            anchors.rightMargin: 0.09 * parent.width
            y: mainScreenTextFieldPass.y + mainScreenTextFieldPass.height + 20
            height: 1
            border.width: 1
            border.color: "#FFFFFF"
        }
        Image {
            x: mainScreenTextFieldPass.x - 47
            y: mainScreenTextFieldPass.y + mainScreenTextFieldPass.height - sourceSize.height + 7 / (parent.height/900)
            source: "ui/passIcon.png"
        }

        CheckBox {
            id: mainScreencheckBoxRememberMe
            y: mainScreenTextFieldPass.y+ 120 * parent.height/900
            height: (parent.height > 900)? 48 * (parent.height/900): 48
            anchors.left: parent.left
            anchors.leftMargin: 0.09 * parent.width

            font.pointSize: 18
            text: qsTr("Запомнить меня")

            spacing: 15
            leftPadding: 0

            indicator: Rectangle {
                    implicitWidth: 26
                    implicitHeight: 26
                    x: mainScreencheckBoxRememberMe.leftPadding
                    y: parent.height / 2 - height / 2
                    radius: 3
                    border.color:mainScreencheckBoxRememberMe.down?"#10387E" : "#337CFD"

                    Rectangle {
                        width: 18
                        height: 18
                        x: 4
                        y: 4
                        radius: 2
                        color: mainScreencheckBoxRememberMe.down ? "#10387E" : "#337CFD"
                        visible: mainScreencheckBoxRememberMe.checked
                    }
                }

            contentItem: Text {
                    text: mainScreencheckBoxRememberMe.text
                    font: mainScreencheckBoxRememberMe.font
                    opacity: enabled ? 1.0 : 0.3
                    color: mainScreencheckBoxRememberMe.down ? "#10387E" : "#FFFFFF"
                    verticalAlignment: Text.AlignVCenter
                    leftPadding: mainScreencheckBoxRememberMe.indicator.width + mainScreencheckBoxRememberMe.spacing
                }
        }

        Button {
            id: mainScreenLabelForgotPass
            y: (parent.height>900)? mainScreenButtonLogin.y + 90 * parent.height/900: mainScreenButtonLogin.y + 90
            text: qsTr("Забыли пароль?")

            font.pointSize: 16

            //font.underline: true
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.leftMargin: 0.09 * parent.width
            anchors.rightMargin: 0.09 * parent.width

            background: Rectangle {
                opacity: 0
            }
            contentItem: Text {
                text: mainScreenLabelForgotPass.text
                font: mainScreenLabelForgotPass.font
                opacity: enabled ? 1.0 : 0.3
                color: mainScreenLabelForgotPass.down ? "#10387E" : "#FFFFFF"
                padding: -8
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                elide: Text.ElideRight
            }
        }

        Button {
            id: mainScreenBackButton
            width: 100
            height: 42 * loginScreen.height/900
            anchors.leftMargin: 20
            anchors.top: parent.top
            anchors.left: parent.left
            anchors.topMargin: 25 * loginScreen.height/900

            Image {
                fillMode: Image.PreserveAspectFit
                source: "ui/backButton.png"
                width: 23
                height:42*loginScreen.height/900
            }

            background: Rectangle {
                opacity: 0
            }

            onClicked: {
                loader.source = "qrc:/basic.qml"
            }
        }
    }
    //-------------------------------------------------------------------------------------------------------------
}
