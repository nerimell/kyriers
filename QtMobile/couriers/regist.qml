import QtQuick 2.7
import QtQuick.Layouts 1.0
import QtQuick.Dialogs 1.2
import QtQuick.Controls 2.0

Item {
    id:rootRegist
    visible: true

    //--------------------------------------------------dialogAndroid----------------------------------------------
    Dialog {
        id: dialogAndroid

        // Создаём содержимое диалогового окна
        contentItem: Rectangle {
            color: "#f7f7f7"
            width: rootRegist.width-80
            height: rootRegist.height/3

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
                        if (dialogAndroidTextLabel.text == "Придумайте свой пин-код") {
                            event_handler.cleanMePin()
                            registScreen.visible = false
                            loader.source = "qrc:/piner.qml"
                        }
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
        id: busyIndicatorRegistScreen

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


    //--------------------------------------------------registScreen.qml-------------------------------------------
    Item {
        visible: true
        id: registScreen
        anchors.fill: parent

        MouseArea {
            id: mouseArea1
            drag.minimumY: -20
            drag.maximumY: 100
            anchors.fill: parent
            drag.target: registScreentextFieldLogin
            drag.axis: Drag.YAxis
        }

        Image {
            x: parent.width/2 - width/2
            y: (parent.width<parent.height)?parent.height/2-height/2:0
            height: (parent.width<parent.height)?parent.height:sourceSize.height*(width/sourceSize.width)
            width: (parent.width<parent.height)?sourceSize.width*(parent.height/sourceSize.height):parent.width
            source: "ui/background3.png"
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

            text: "Регистрация"
        }

        TextField {
            id: registScreentextFieldLogin
            y: 100
            anchors.left: parent.left
            anchors.right: parent.right
            height: (parent.height > 900)? 44 * (parent.height/900): 44
            anchors.rightMargin: 0.09 * parent.width
            anchors.leftMargin: 0.09 * parent.width + 50
            placeholderText: qsTr("Имя")

            color: "#FFFFFF"
            font.pointSize: 18

            background: Rectangle {
                opacity: 0
            }
        }
        Rectangle {// ебаное нижнее подчеркивание. Ага, оно делается вот блять так!
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.leftMargin: 0.09 * parent.width
            anchors.rightMargin: 0.09 * parent.width
            y: registScreentextFieldLogin.y + registScreentextFieldLogin.height + 20
            height: 1
            border.width: 1
            border.color: "#FFFFFF"
        }
        Image {
            x: registScreentextFieldLogin.x - 47
            y: registScreentextFieldLogin.y + registScreentextFieldLogin.height - sourceSize.height + 7 / (parent.height/900)
            source: "ui/humanIcon.png"
        }

        TextField {
            id: registScreentextFieldFamily
            y: registScreentextFieldLogin.y + 100*parent.height/900
            anchors.left: parent.left
            anchors.right: parent.right
            height: (parent.height > 900)? 44 * (parent.height/900): 44
            anchors.rightMargin: 0.09 * parent.width
            anchors.leftMargin: 0.09 * parent.width + 50
            placeholderText: qsTr("Фамилия")

            color: "#FFFFFF"
            font.pointSize: 18

            background: Rectangle {
                opacity: 0
            }
        }
        Rectangle {// ебаное нижнее подчеркивание. Ага, оно делается вот блять так!
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.leftMargin: 0.09 * parent.width
            anchors.rightMargin: 0.09 * parent.width
            y: registScreentextFieldFamily.y + registScreentextFieldFamily.height + 20
            height: 1
            border.width: 1
            border.color: "#FFFFFF"
        }
        Image {
            x: registScreentextFieldFamily.x - 47
            y: registScreentextFieldFamily.y + registScreentextFieldFamily.height - sourceSize.height + 7 / (parent.height/900)
            source: "ui/humanIcon.png"
        }

        TextField {
            id: registScreentextFieldEmail
            y: registScreentextFieldLogin.y + 200*parent.height/900
            anchors.left: parent.left
            anchors.right: parent.right
            height: (parent.height > 900)? 44 * (parent.height/900): 44
            anchors.rightMargin: 0.09 * parent.width
            anchors.leftMargin: 0.09 * parent.width + 50
            placeholderText: qsTr("E-mail")

            color: "#FFFFFF"
            font.pointSize: 18

            background: Rectangle {
                opacity: 0
            }
        }
        Rectangle {// ебаное нижнее подчеркивание. Ага, оно делается вот блять так!
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.leftMargin: 0.09 * parent.width
            anchors.rightMargin: 0.09 * parent.width
            y: registScreentextFieldEmail.y + registScreentextFieldEmail.height + 20
            height: 1
            border.width: 1
            border.color: "#FFFFFF"
        }
        Image {
            x: registScreentextFieldEmail.x - 47
            y: registScreentextFieldEmail.y + registScreentextFieldEmail.height - sourceSize.height + 7 / (parent.height/900)
            source: "ui/phoneIcon.png"
        }

        TextField {
            id: registScreentextFieldPass
            y: registScreentextFieldLogin.y + 300*parent.height/900
            anchors.left: parent.left
            anchors.right: parent.right
            height: (parent.height > 900)? 44 * (parent.height/900): 44
            anchors.rightMargin: 0.09 * parent.width
            anchors.leftMargin: 0.09 * parent.width + 50
            placeholderText: qsTr("Пароль")

            color: "#FFFFFF"
            font.pointSize: 18
            echoMode: TextInput.Password

            background: Rectangle {
                opacity: 0
            }
        }
        Rectangle {// ебаное нижнее подчеркивание. Ага, оно делается вот блять так!
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.leftMargin: 0.09 * parent.width
            anchors.rightMargin: 0.09 * parent.width
            y: registScreentextFieldPass.y + registScreentextFieldPass.height + 20
            height: 1
            border.width: 1
            border.color: "#FFFFFF"
        }
        Image {
            x: registScreentextFieldPass.x - 47
            y: registScreentextFieldPass.y + registScreentextFieldPass.height - sourceSize.height + 7 / (parent.height/900)
            source: "ui/passIcon.png"
        }

        TextField {
            id: registScreentextFieldPassRepeat
            y: registScreentextFieldLogin.y + 400*parent.height/900
            anchors.left: parent.left
            anchors.right: parent.right
            height: (parent.height > 900)? 44 * (parent.height/900): 44
            anchors.rightMargin: 0.09 * parent.width
            anchors.leftMargin: 0.09 * parent.width + 50
            placeholderText: qsTr("Повтор пароля")

            color: "#FFFFFF"
            font.pointSize: 18
            echoMode: TextInput.Password

            background: Rectangle {
                opacity: 0
            }
        }
        Rectangle {// ебаное нижнее подчеркивание. Ага, оно делается вот блять так!
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.leftMargin: 0.09 * parent.width
            anchors.rightMargin: 0.09 * parent.width
            y: registScreentextFieldPassRepeat.y + registScreentextFieldPassRepeat.height + 20
            height: 1
            border.width: 1
            border.color: "#FFFFFF"
        }
        Image {
            x: registScreentextFieldPassRepeat.x - 47
            y: registScreentextFieldPassRepeat.y + registScreentextFieldPassRepeat.height - sourceSize.height + 7 / (parent.height/900)
            source: "ui/passIcon.png"
        }

        TextField {
            id: registScreentextFieldPhone
            y: registScreentextFieldLogin.y + 500*parent.height/900
            anchors.left: parent.left
            anchors.right: parent.right
            height: (parent.height > 900)? 44 * (parent.height/900): 44
            anchors.rightMargin: 0.09 * parent.width
            anchors.leftMargin: 0.09 * parent.width + 50
            placeholderText: qsTr("Номер мобильного")

            color: "#FFFFFF"
            font.pointSize: 18
            validator: DoubleValidator {}

            background: Rectangle {
                opacity: 0
            }
        }
        Rectangle {// ебаное нижнее подчеркивание. Ага, оно делается вот блять так!
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.leftMargin: 0.09 * parent.width
            anchors.rightMargin: 0.09 * parent.width
            y: registScreentextFieldPhone.y + registScreentextFieldPhone.height + 20
            height: 1
            border.width: 1
            border.color: "#FFFFFF"
        }
        Image {
            x: registScreentextFieldPhone.x - 47
            y: registScreentextFieldPhone.y + registScreentextFieldPhone.height - sourceSize.height + 7 / (parent.height/900)
            source: "ui/phoneIcon.png"
        }

        ComboBox {
            id: registScreencomboBoxCitys
            y: (parent.height>900)? registScreentextFieldPhone.y + 86 *parent.height/900: registScreentextFieldPhone.y + 86
            anchors.left: parent.left
            anchors.right: parent.right
            height: (parent.height>900)? 44 * parent.height/900: 44
            anchors.leftMargin: 0.09 * parent.width
            anchors.rightMargin: 0.09 * parent.width
            font.pointSize: 24

            model: [
                "Волоколамск",
                "Петербург",
                "Москва"
            ]

            onActivated: {
                registScreenComboBoxCitysField.text=textAt(currentIndex)
                popup.close()
            }

            indicator: Canvas {
                x: registScreencomboBoxCitys.width - width - registScreencomboBoxCitys.rightPadding
                y: registScreencomboBoxCitys.topPadding + (registScreencomboBoxCitys.availableHeight - height) / 2
                width: 20
                height: 12
                contextType: "2d"

                Connections {
                    target: registScreencomboBoxCitys
                }

                onPaint: {
                    context.reset();
                    context.moveTo(0, 0);
                    context.lineTo(width, 0);
                    context.lineTo(width / 2, height);
                    context.closePath();
                    context.fillStyle = registScreencomboBoxCitys.pressed ? "#10387E" : "#10387E";
                    context.fill();
                }
            }

            /* onAccepted: {model.edit=text} */
        }
        TextField {
            id: registScreenComboBoxCitysField
            y: (parent.height>900)? registScreentextFieldPhone.y + 86 *parent.height/900: registScreentextFieldPhone.y + 86
            anchors.left: parent.left
            anchors.right: parent.right
            height: (parent.height>900)? 44 * parent.height/900: 44
            anchors.leftMargin: 0.09 * parent.width
            anchors.rightMargin: 0.09 * parent.width + 45
            placeholderText: qsTr("Город")

            color: "#000000"
            font.pointSize: 18

            background: Rectangle {
                color: "#FFFFFF"
            }

            onEditingFinished: {
                registScreencomboBoxCitys.popup.close()
            }

            onTextChanged: {
                registScreencomboBoxCitys.popup.open()
                registScreencomboBoxCitys.currentIndex = registScreencomboBoxCitys.find(text,Qt.MatchContains)
            }
        }

        Button {
            id: registScreenButtonRegister
            y: (parent.height>900)? registScreencomboBoxCitys.y + 56*parent.height/900: registScreencomboBoxCitys.y + 56

            anchors.left: parent.left
            anchors.right: parent.right
            anchors.leftMargin: 0.09 * parent.width
            anchors.rightMargin: 0.09* parent.width
            height: (parent.height>900)? 70*parent.height/900: 70
            checked: false
            checkable: false
            autoRepeat: false
            highlighted: false
            autoExclusive: false
            text: qsTr("Зарегистрироваться")

            font.pointSize: 18

            onClicked: {
                if(registScreentextFieldLogin.text.length< 2) {
                    dialogAndroidTextLabel.text = "Имя короче 2 символов"
                    dialogAndroid.open();
                }
                else
                if(registScreentextFieldFamily.text.length<2) {
                    dialogAndroidTextLabel.text = "Фамилия менее 2 символов"
                    dialogAndroid.open();
                }
                else
                if(registScreentextFieldPass.text.length < 5) {
                    dialogAndroidTextLabel.text = "Пароль короче 5 символов"
                    dialogAndroid.open();
                }
                else
                if(registScreentextFieldPhone.text.length<11) {
                    dialogAndroidTextLabel.text = "Укажите корректный номер"
                    dialogAndroid.open();
                }
                else
                if(registScreentextFieldPassRepeat.text!=registScreentextFieldPass.text) {
                    dialogAndroidTextLabel.text = "Ваши пароли не совпадают"
                    dialogAndroid.open();
                }
                else {
                    busyIndicatorRegistScreen.visible = true
                    if(event_handler.registration(registScreentextFieldLogin.text,registScreentextFieldFamily.text,registScreentextFieldPass.text,registScreentextFieldPassRepeat.text,registScreentextFieldEmail.text,registScreentextFieldPhone.text,registScreencomboBoxCitys.currentText)) {
                        dialogAndroidTextLabel.text = "Придумайте свой пин-код"
                        event_handler.setFamily(registScreentextFieldFamily.text)
                        event_handler.setPhone(registScreentextFieldPhone.text)
                        event_handler.setLogin(registScreentextFieldLogin.text)
                        event_handler.setMail(registScreentextFieldEmail.text)
                        event_handler.setPass(registScreentextFieldPass.text)
                        dialogAndroid.open();
                        busyIndicatorRegistScreen.visible = false
                    }
                    else {
                        dialogAndroidTextLabel.text="Вы уже зарегистрированы"
                        busyIndicatorRegistScreen.visible = false
                        dialogAndroid.open();
                    }
                }
            }

            background: Rectangle {
                    color: registScreenButtonRegister.down ? "#9610387E":"#10387E"
            }

            contentItem: Text {
                    text: registScreenButtonRegister.text
                    font: registScreenButtonRegister.font
                    opacity: enabled ? 1.0 : 0.3
                    color: registScreenButtonRegister.down ? "#FFFFFF" : "#FFFFFF"
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    elide: Text.ElideRight
            }
        }

        /*
        ListView {
            id: registScreenListView
            width: 445
            height: 200
            y: 100
            x: parent.width/2 - width/2

            model: ListModel {
                ListElement {
                    placeholder: qsTr("Придумай логин")
                    sourceimg: "ui/phoneIcon.png"
                }

                ListElement {
                    placeholder: qsTr("Придумай пароль")
                    sourceimg: "ui/passIcon.png"
                }

                ListElement {
                    placeholder: qsTr("Повторите пароль")
                    sourceimg: "ui/passIcon.png"
                }

                ListElement {
                    placeholder: qsTr("Введите свой EMail")
                    sourceimg: "ui/phoneIcon.png"
                }

                ListElement {
                    placeholder: qsTr("+7-XXX-XXX-XX-XX")
                    sourceimg: "ui/phoneIcon.png"
                }
            }
            delegate: Item {
                width: 445
                height: 50
                Image {
                    x: parentText.x - 47
                    y: parentText.y + 5
                    width: 24
                    height: 34
                    source: sourceimg
                }
                TextField {
                    x: 30
                    id: parentText
                    width: 445
                    height: 44
                    placeholderText: placeholder

                    color: "#FFFFFF"
                    font.pointSize: 18

                    background: Rectangle {
                        opacity: 0
                    }
                }
                Rectangle { // ебанное нижнее подчеркивание
                    y: parentText.y + parentText.height + 20
                    width: 445
                    height: 1
                    border.color: "#FFFFFF"
                    border.width: 1
                }
            }
        }
        */

        Button {
            id: mainScreenBackButton
            width: 100
            height: 42 * registScreen.height/ 900
            anchors.leftMargin: 20
            anchors.top: parent.top
            anchors.left: parent.left
            anchors.topMargin: 25 * registScreen.height/ 900

            Image {
                fillMode: Image.PreserveAspectFit
                source: "ui/backButton.png"
                width: 23
                height:42*registScreen.height/900
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
