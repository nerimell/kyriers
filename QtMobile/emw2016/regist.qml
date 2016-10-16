import QtQuick 2.7
import QtQuick.Layouts 1.0
import QtQuick.Controls 2.0
import "EmwStyle" as EmwStyle

Item {
    id:rootRegist
    anchors.fill: parent


    //--------------------------------------------------registScreen.qml-------------------------------------------
    Item {
        visible: true
        id: registScreen
        anchors.fill: parent

        MouseArea {
            id: mouseArea1
            anchors.fill: parent
            drag.axis: Drag.YAxis
            drag.maximumY: facade.toPx(100)
            drag.target: registScreentextFieldLogin
            drag.minimumY: (parent.height<900)? parent.height - 900: 100
        }

        Image {
            x: parent.width/2 - width/2
            y: (parent.width < parent.height)?parent.height/2-height/2:0
            height: (parent.width<parent.height)?parent.height:sourceSize.height*(width/sourceSize.width)
            width: (parent.width<parent.height)?sourceSize.width*(parent.height/sourceSize.height):parent.width
            source: "ui/background/background4.png"
        }

        Text {
            color: "#FFFFFF"
            font.family: museoSansMedium.name
            font.pointSize: facade.toPx(17)
            horizontalAlignment: Text.AlignHCenter

            y: mainScreenBackButton.y + mainScreenBackButton.height/2 - font.pointSize/2 -facade.toPx(7)
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.leftMargin: parent.width /2 - facade.toPx(60)
            anchors.rightMargin: parent.width/2 - facade.toPx(60)

            text: "Регистрация"
        }

        TextField {
            id: registScreentextFieldLogin
            y: facade.toPx(100)
            anchors.left: parent.left
            anchors.right: parent.right
            placeholderText: qsTr("Имя")
            height: (parent.height > 900)? facade.toPx(44): 44
            anchors.rightMargin: 0.09 * parent.width
            anchors.leftMargin: 0.09 * parent.width + facade.toPx(60)

            color: "#FFFFFF"
            font.pointSize: facade.toPx(18)

            background: Rectangle {
                opacity: 0
            }
        }
        Rectangle {// ебаное нижнее подчеркивание. Ага, оно делается вот блять так!
            border.color: "#FFFFFF"
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.leftMargin: 0.09 * parent.width
            anchors.rightMargin: 0.09 * parent.width
            y: registScreentextFieldLogin.y + registScreentextFieldLogin.height + facade.toPx(20)
            height: 1
            border.width: 1
        }
        Image {
            x: registScreentextFieldLogin.x - facade.toPx(57)
            y: (parent.height>900)?registScreentextFieldLogin.y + registScreentextFieldLogin.height - sourceSize.height + facade.toPx(7): registScreentextFieldLogin.y + registScreentextFieldLogin.height - sourceSize.height + 7
            source: "ui/screensIcons/humanIcon.png"
        }

        TextField {
            id: registScreentextFieldFamily
            y: (parent.height>900)? registScreentextFieldLogin.y + facade.toPx(100): registScreentextFieldLogin.y + 100
            anchors.left: parent.left
            anchors.right: parent.right
            height: (parent.height > 900)? facade.toPx(44): 44
            anchors.rightMargin: 0.09 * parent.width
            anchors.leftMargin: 0.09 * parent.width + facade.toPx(60)
            placeholderText: qsTr("Фамилия")

            color: "#FFFFFF"
            font.pointSize: facade.toPx(18)

            background: Rectangle {
                opacity: 0
            }
        }
        Rectangle {// ебаное нижнее подчеркивание. Ага, оно делается вот блять так!
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.leftMargin: 0.09 * parent.width
            anchors.rightMargin: 0.09 * parent.width
            y: registScreentextFieldFamily.y + registScreentextFieldFamily.height + facade.toPx(20)
            height: 1
            border.width: 1
            border.color: "#FFFFFF"
        }
        Image {
            x: registScreentextFieldFamily.x - facade.toPx(57)
            y: (parent.height>900)?registScreentextFieldFamily.y + registScreentextFieldFamily.height - sourceSize.height + facade.toPx(7): registScreentextFieldFamily.y+registScreentextFieldFamily.height-sourceSize.height + 7
            source: "ui/screensIcons/humanIcon.png"
        }

        TextField {
            id: registScreentextFieldEmail
            y: (parent.height>900)? registScreentextFieldFamily.y + facade.toPx(100): registScreentextFieldFamily.y + 100
            anchors.left: parent.left
            anchors.right: parent.right
            height: (parent.height > 900)? facade.toPx(44): 44
            anchors.rightMargin: 0.09 * parent.width
            anchors.leftMargin: 0.09 * parent.width + facade.toPx(60)
            placeholderText: qsTr("E-mail")

            color: "#FFFFFF"
            font.pointSize: facade.toPx(18)

            background: Rectangle {
                opacity: 0
            }
        }
        Rectangle {// ебаное нижнее подчеркивание. Ага, оно делается вот блять так!
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.leftMargin: 0.09 * parent.width
            anchors.rightMargin: 0.09 * parent.width
            y: registScreentextFieldEmail.y + registScreentextFieldEmail.height + facade.toPx(20)
            height: 1
            border.width: 1
            border.color: "#FFFFFF"
        }
        Image {
            x: registScreentextFieldEmail.x - facade.toPx(57)
            y: (parent.height>900)?registScreentextFieldEmail.y + registScreentextFieldEmail.height - sourceSize.height + facade.toPx(7): registScreentextFieldEmail.y + registScreentextFieldEmail.height - sourceSize.height + 7
            source: "ui/screensIcons/phoneIcon.png"
        }

        TextField {
            id: registScreentextFieldPass
            y: (parent.height>900)? registScreentextFieldEmail.y + facade.toPx(100): registScreentextFieldEmail.y + 100
            anchors.left: parent.left
            anchors.right: parent.right
            height: (parent.height > 900)? facade.toPx(44): 44
            anchors.rightMargin: 0.09 * parent.width
            anchors.leftMargin: 0.09 * parent.width + facade.toPx(60)
            placeholderText: qsTr("Пароль")

            color: "#FFFFFF"
            font.pointSize: facade.toPx(18)
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
            y: registScreentextFieldPass.y + registScreentextFieldPass.height + facade.toPx(20)
            height: 1
            border.width: 1
            border.color: "#FFFFFF"
        }
        Image {
            x: registScreentextFieldPass.x - facade.toPx(57)
            y: (parent.height> 900)? registScreentextFieldPass.y + registScreentextFieldPass.height - sourceSize.height + facade.toPx(7): registScreentextFieldPass.y + registScreentextFieldPass.height - sourceSize.height + 7
            source: "ui/screensIcons/passIcon.png"
        }

        TextField {
            id: registScreentextFieldPassRepeat
            y: (parent.height>900)? registScreentextFieldPass.y + facade.toPx(100): registScreentextFieldPass.y + 100
            anchors.left: parent.left
            anchors.right: parent.right
            height: (parent.height > 900)? facade.toPx(44): 44
            anchors.rightMargin: 0.09 * parent.width
            anchors.leftMargin: 0.09 * parent.width + facade.toPx(60)
            placeholderText: qsTr("Повтор пароля")

            color: "#FFFFFF"
            font.pointSize: facade.toPx(18)
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
            y: registScreentextFieldPassRepeat.y + registScreentextFieldPassRepeat.height + facade.toPx(20)
            height: 1
            border.width: 1
            border.color: "#FFFFFF"
        }
        Image {
            x: registScreentextFieldPassRepeat.x - facade.toPx(57)
            y: (parent.height>900)?registScreentextFieldPassRepeat.y+registScreentextFieldPassRepeat.height-sourceSize.height+facade.toPx(7):registScreentextFieldPassRepeat.y+registScreentextFieldPassRepeat.height-sourceSize.height+7
            source: "ui/screensIcons/passIcon.png"
        }

        TextField {
            id: registScreentextFieldPhone
            y: (parent.height>900)? registScreentextFieldPassRepeat.y + facade.toPx(100): registScreentextFieldPassRepeat.y + 100
            anchors.left: parent.left
            anchors.right: parent.right
            height: (parent.height > 900)? facade.toPx(44): 44
            anchors.rightMargin: 0.09 * parent.width
            anchors.leftMargin: 0.09 * parent.width + facade.toPx(60)
            placeholderText: qsTr("Номер мобильного")
            inputMethodHints: Qt.ImhFormattedNumbersOnly

            color: "#FFFFFF"
            font.pointSize: facade.toPx(18)
            validator: DoubleValidator {}

            onFocusChanged: {
                if(text.length== 0)
                text = "+7"
            }
            background: Rectangle {
                opacity: 0
            }
        }
        Rectangle {// ебаное нижнее подчеркивание. Ага, оно делается вот блять так!
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.leftMargin: 0.09 * parent.width
            anchors.rightMargin: 0.09 * parent.width
            y: registScreentextFieldPhone.y + registScreentextFieldPhone.height + facade.toPx(20)
            height: 1
            border.width: 1
            border.color: "#FFFFFF"
        }
        Image {
            x: registScreentextFieldPhone.x - facade.toPx(57)
            y: (parent.height > 900)? registScreentextFieldPhone.y + registScreentextFieldPhone.height - sourceSize.height + facade.toPx(7): registScreentextFieldPhone.y + registScreentextFieldPhone.height - sourceSize.height + 7
            source: "ui/screensIcons/phoneIcon.png"
        }

        ComboBox {
            id: registScreencomboBoxCitys
            y: (parent.height>900)? registScreentextFieldPhone.y + facade.toPx(102): registScreentextFieldPhone.y + 102
            anchors.left: parent.left
            anchors.right: parent.right
            height: (parent.height>900)? facade.toPx(44): 44
            anchors.leftMargin: 0.09 * parent.width + facade.toPx(60)
            anchors.rightMargin: 0.09 * parent.width

            background: Rectangle {
                opacity: 0
            }

            font.pointSize: facade.toPx(24)

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
            y: (parent.height>900)? registScreentextFieldPhone.y + facade.toPx(100): registScreentextFieldPhone.y + 100
            anchors.left: parent.left
            anchors.right: parent.right
            height: (parent.height>900)? facade.toPx(44): 44
            anchors.leftMargin: 0.09 * parent.width + facade.toPx(60)
            anchors.rightMargin: 0.09 * parent.width + facade.toPx(45)
            placeholderText: qsTr("Город")

            color: "#FFFFFF"
            font.pointSize: facade.toPx(18)

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
            y: registScreenComboBoxCitysField.y + registScreenComboBoxCitysField.height + facade.toPx(20)
            height: 1
            border.width: 1
            border.color: "#FFFFFF"
        }
        Image {
            x: registScreenComboBoxCitysField.x - facade.toPx(57)
            y: (parent.height>900)?registScreenComboBoxCitysField.y + registScreenComboBoxCitysField.height - sourceSize.height+facade.toPx(7):registScreenComboBoxCitysField.y+registScreenComboBoxCitysField.height-sourceSize.height+7
            source: "ui/screensIcons/homeIcon.png"
        }

        Button {
            id: registScreenButtonRegister
            y: (parent.height>900)? registScreencomboBoxCitys.y + facade.toPx(100): registScreencomboBoxCitys.y + 100

            anchors.left: parent.left
            anchors.right: parent.right
            anchors.leftMargin: 0.09 * parent.width
            anchors.rightMargin: 0.09* parent.width
            height: (parent.height>900)? facade.toPx(70): 70
            checked: false
            checkable: false
            autoRepeat: false
            highlighted: false
            autoExclusive: false
            text: qsTr("Зарегистрироваться")

            font.pointSize: facade.toPx(18)

            onClicked: {
                if(registScreentextFieldLogin.text.length< 2) {
                    dialogAndroid.text = "Имя короче 2 символов"
                    dialogAndroid.visible=true;
                }
                else
                if(registScreentextFieldFamily.text.length<2) {
                    dialogAndroid.text = "Фамилия менее 2 символов"
                    dialogAndroid.visible=true;
                }
                else
                if(registScreentextFieldPass.text.length < 5) {
                    dialogAndroid.text = "Пароль короче 5 символов"
                    dialogAndroid.visible=true;
                }
                else
                if(registScreentextFieldPhone.text.length<11) {
                    dialogAndroid.text = "Укажите корректный номер"
                    dialogAndroid.visible=true;
                }
                else
                if(registScreentextFieldPassRepeat.text!=registScreentextFieldPass.text) {
                    dialogAndroid.text = "Ваши пароли не совпадают"
                    dialogAndroid.visible=true;
                }
                else {
                    busyIndicatorScreen.visible = true
                    if(event_handler.registration(registScreentextFieldLogin.text,registScreentextFieldFamily.text,registScreentextFieldPass.text,registScreentextFieldPassRepeat.text,registScreentextFieldEmail.text,registScreentextFieldPhone.text,registScreencomboBoxCitys.currentText)) {
                        dialogAndroid.text = "Придумайте свой пин-код"
                        event_handler.setFamily(registScreentextFieldFamily.text)
                        event_handler.setPhone(registScreentextFieldPhone.text)
                        event_handler.setLogin(registScreentextFieldLogin.text)
                        event_handler.setMail(registScreentextFieldEmail.text)
                        event_handler.setPass(registScreentextFieldPass.text)
                        dialogAndroid.visible=true;
                        busyIndicatorScreen.visible = false
                    }
                    else {
                        dialogAndroid.text="Вы уже зарегистрированы"
                        busyIndicatorScreen.visible = false
                        dialogAndroid.visible=true;
                    }
                }
            }

            background: Rectangle {
                    radius: facade.toPx(15)
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
            width: (parent.width>500)?facade.toPx(100):100
            height: facade.toPx(42)
            anchors.topMargin: facade.toPx(25)
            anchors.leftMargin: facade.toPx(20)
            anchors.top: parent.top
            anchors.left: parent.left
            Image {
                fillMode: Image.PreserveAspectFit
                source: "ui/buttons/backButton.png"
                width: facade.toPx(23)
                height:facade.toPx(42)
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

    EmwStyle.BusyIndicator {
        id: busyIndicatorScreen
    }

    EmwStyle.DialogWindow {
        id: dialogAndroid
    }
}
