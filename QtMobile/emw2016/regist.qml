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
            height: rootRegist.height/2.5

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
                    font.family: sfuiFontLight.name
                    horizontalAlignment: Text.AlignHCenter
                    anchors.centerIn: parent// put сообщение в центр области отобраэжения
                }
            }

            // Создаём горизонтальный разделитель с Rectangle
            Rectangle {
                id: dialogAndroidDividerHorizontal
                color: "#808080"
                height: 1 // Устанавливаем ширину в 1 пиксель
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
                height: (rootRegist.height<900)?100 * rootRegist.height/900: 100
                // А также прибиваем строку к низу у диалогового окна
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.bottom: parent.bottom

                /*
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
                        color:dialogAndroiddialogButtonCancel.pressed? "#d7d7d7":"#f7f7f7"
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
                */

                Button {
                    id: dialogAndroidDialogButtonOk

                    anchors.top: parent.top
                    anchors.bottom: parent.bottom
                    //width: parent.width/ 2-1// ширину на половину строки минус 1 pixel
                    width: parent.width // если необходима только одна кнопочка на экран

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
            source: "ui/background/background4.png"
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
            drag.minimumY: (parent.height<900)? parent.height - 900: 100
            drag.maximumY: 100
            anchors.fill: parent
            drag.axis: Drag.YAxis
            drag.target: registScreentextFieldLogin
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
            font.pointSize: 17
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
            placeholderText: qsTr("Имя")
            anchors.rightMargin: 0.09 * parent.width
            anchors.leftMargin: 0.09 * parent.width + 50
            height: (parent.height > 900)? 44 * (parent.height/900): 44

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
            y: (parent.height>900)?registScreentextFieldLogin.y + registScreentextFieldLogin.height - sourceSize.height + 7 / (parent.height/900): registScreentextFieldLogin.y + registScreentextFieldLogin.height - sourceSize.height + 7
            source: "ui/screensIcons/humanIcon.png"
        }

        TextField {
            id: registScreentextFieldFamily
            y: (parent.height>900)? registScreentextFieldLogin.y + 100 *parent.height/900: registScreentextFieldLogin.y + 100
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
            y: (parent.height>900)?registScreentextFieldFamily.y + registScreentextFieldFamily.height - sourceSize.height + 7 / (parent.height/900): registScreentextFieldFamily.y+registScreentextFieldFamily.height-sourceSize.height + 7
            source: "ui/screensIcons/humanIcon.png"
        }

        TextField {
            id: registScreentextFieldEmail
            y: (parent.height>900)? registScreentextFieldFamily.y + 100 *parent.height/900: registScreentextFieldFamily.y + 100
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
            y: (parent.height>900)?registScreentextFieldEmail.y + registScreentextFieldEmail.height - sourceSize.height + 7 / (parent.height/900): registScreentextFieldEmail.y + registScreentextFieldEmail.height - sourceSize.height + 7
            source: "ui/screensIcons/phoneIcon.png"
        }

        TextField {
            id: registScreentextFieldPass
            y: (parent.height>900)? registScreentextFieldEmail.y + 100 *parent.height/900: registScreentextFieldEmail.y + 100
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
            y: (parent.height> 900)? registScreentextFieldPass.y + registScreentextFieldPass.height - sourceSize.height + 7 / (parent.height / 900): registScreentextFieldPass.y + registScreentextFieldPass.height - sourceSize.height + 7
            source: "ui/screensIcons/passIcon.png"
        }

        TextField {
            id: registScreentextFieldPassRepeat
            y: (parent.height>900)? registScreentextFieldPass.y + 100 *parent.height/900: registScreentextFieldPass.y + 100
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
            y: (parent.height>900)?registScreentextFieldPassRepeat.y+registScreentextFieldPassRepeat.height-sourceSize.height+7/(parent.height/900):registScreentextFieldPassRepeat.y+registScreentextFieldPassRepeat.height-sourceSize.height+7
            source: "ui/screensIcons/passIcon.png"
        }

        TextField {
            id: registScreentextFieldPhone
            y: (parent.height>900)? registScreentextFieldPassRepeat.y + 100 *parent.height/900: registScreentextFieldPassRepeat.y + 100
            anchors.left: parent.left
            anchors.right: parent.right
            height: (parent.height > 900)? 44 * (parent.height/900): 44
            anchors.rightMargin: 0.09 * parent.width
            anchors.leftMargin: 0.09 * parent.width + 50
            placeholderText: qsTr("Номер мобильного")
            inputMethodHints: Qt.ImhFormattedNumbersOnly

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
            y: (parent.height > 900)? registScreentextFieldPhone.y + registScreentextFieldPhone.height - sourceSize.height + 7 / (parent.height / 900): registScreentextFieldPhone.y + registScreentextFieldPhone.height - sourceSize.height + 7
            source: "ui/screensIcons/phoneIcon.png"
        }

        ComboBox {
            id: registScreencomboBoxCitys
            y: (parent.height>900)? registScreentextFieldPhone.y + 102 *parent.height/900: registScreentextFieldPhone.y + 102
            anchors.left: parent.left
            anchors.right: parent.right
            height: (parent.height>900)? 44 * parent.height/900: 44
            anchors.leftMargin: 0.09 * parent.width + 50
            anchors.rightMargin: 0.09 * parent.width
            font.pointSize: 24

            background: Rectangle {
                opacity: 0
            }

            contentItem: Text {
                font: registScreencomboBoxCitys.font
                opacity: 0
                verticalAlignment: Text.AlignVCenter
                leftPadding: registScreencomboBoxCitys.indicator.width + registScreencomboBoxCitys.spacing
            }

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
                    context.lineTo(width/ 2, height);
                    context.closePath();
                    context.fillStyle = "#FFFFFF";
                    context.fill();
                }
            }

            /* onAccepted: {model.edit=text} */
        }
        TextField {
            id: registScreenComboBoxCitysField
            y: (parent.height>900)? registScreentextFieldPhone.y + 100 *parent.height/900: registScreentextFieldPhone.y + 100
            anchors.left: parent.left
            anchors.right: parent.right
            height: (parent.height>900)? 44 * parent.height/900: 44
            anchors.leftMargin: 0.09 * parent.width + 50
            anchors.rightMargin: 0.09 * parent.width + 45
            placeholderText: qsTr("Город")

            color: "#FFFFFF"
            font.pointSize: 18

            background: Rectangle {
                opacity: 0
            }

            onEditingFinished: {
                registScreencomboBoxCitys.popup.close()
            }

            onTextChanged: {
                registScreencomboBoxCitys.popup.open()
                registScreencomboBoxCitys.currentIndex = registScreencomboBoxCitys.find(text,Qt.MatchContains)
            }
        }
        Rectangle {// ебаное нижнее подчеркивание. Ага, оно делается вот блять так!
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.leftMargin: 0.09 * parent.width
            anchors.rightMargin: 0.09 * parent.width
            y: registScreenComboBoxCitysField.y + registScreenComboBoxCitysField.height + 20
            height: 1
            border.width: 1
            border.color: "#FFFFFF"
        }
        Image {
            x: registScreenComboBoxCitysField.x - 47
            y: (parent.height>900)?registScreenComboBoxCitysField.y + registScreenComboBoxCitysField.height - sourceSize.height+7/(parent.height/900):registScreenComboBoxCitysField.y+registScreenComboBoxCitysField.height-sourceSize.height+7
            source: "ui/screensIcons/homeIcon.png"
        }

        Button {
            id: registScreenButtonRegister
            y: (parent.height>900)? registScreencomboBoxCitys.y + 100*parent.height/900: registScreencomboBoxCitys.y + 100

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
                    color: registScreenButtonRegister.down?"#960f133d":"#760f133d"
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

        Button {
            id: mainScreenBackButton
            width: (parent.width>500)?100*parent.width/500:100
            height: 42
            anchors.topMargin: 25
            anchors.leftMargin: 20
            anchors.top: parent.top
            anchors.left: parent.left
            Image {
                fillMode: Image.PreserveAspectFit
                source: "ui/buttons/backButton.png"
                width: 23
                height:42
            }

            background: Rectangle {
                opacity: 0
            }

            onClicked: {
                loader.source = "qrc:/login.qml"
            }
        }
    }
    //-------------------------------------------------------------------------------------------------------------
}
