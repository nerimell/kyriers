import QtQuick 2.7
import QtQuick.Layouts 1.0
import QtQuick.Controls 2.0
import "CourierStyle" as CourierStyle

//--------------------------------------------------settingScreen.qml-------------------------------------------
Item {
    id: settingScreen
    anchors.fill: parent

    MouseArea {
        id: mouseArea1
        anchors.fill: parent
        drag.axis: Drag.YAxis
        drag.maximumY: facade.toPx(100)
        drag.target: settingScreentextFieldLogin
        drag.minimumY: (parent.height<900)? parent.height - 900: 100
    }

    Component.onCompleted: {
        event_handler.getUsersInfo()
        settingScreentextFieldPass.text = event_handler.getPass()
        settingScreentextFieldPhone.text = event_handler.getPhone()
        settingScreentextFieldLogin.text = event_handler.getLogin()
        settingScreentextFieldFamily.text = event_handler.getFamily()
        settingScreentextFieldPassRepeat.text = event_handler.getPass()
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
        font.family: sfuiFont.name
        font.pointSize: facade.toPx(17)
        horizontalAlignment: Text.AlignHCenter

        y: mainScreenBackButton.y + mainScreenBackButton.height / 2 - font.pointSize/2 - facade.toPx(7)
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.leftMargin: parent.width /2 - facade.toPx(60)
        anchors.rightMargin: parent.width/2 - facade.toPx(60)

        text: "Регистрация"
    }

    TextField {
        id: settingScreentextFieldLogin
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
        y: settingScreentextFieldLogin.y + settingScreentextFieldLogin.height + facade.toPx(20)
        height: 1
        border.width: 1
    }
    Image {
        x: settingScreentextFieldLogin.x - facade.toPx(57)
        y: (parent.height>900)?settingScreentextFieldLogin.y + settingScreentextFieldLogin.height - sourceSize.height + facade.toPx(7): settingScreentextFieldLogin.y + settingScreentextFieldLogin.height - sourceSize.height + 7
        source: "ui/screensIcons/humanIcon.png"
    }

    TextField {
        id: settingScreentextFieldFamily
        y: (parent.height>900)? settingScreentextFieldLogin.y + facade.toPx(100): settingScreentextFieldLogin.y + 100
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
        y: settingScreentextFieldFamily.y + settingScreentextFieldFamily.height + facade.toPx(20)
        height: 1
        border.width: 1
        border.color: "#FFFFFF"
    }
    Image {
        x: settingScreentextFieldFamily.x - facade.toPx(57)
        y: (parent.height>900)?settingScreentextFieldFamily.y + settingScreentextFieldFamily.height - sourceSize.height + facade.toPx(7): settingScreentextFieldFamily.y+settingScreentextFieldFamily.height-sourceSize.height + 7
        source: "ui/screensIcons/humanIcon.png"
    }

    TextField {
        id: settingScreentextFieldPass
        y: (parent.height>900)? settingScreentextFieldFamily.y + facade.toPx(100): settingScreentextFieldFamily.y + 100
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
        y: settingScreentextFieldPass.y + settingScreentextFieldPass.height + facade.toPx(20)
        height: 1
        border.width: 1
        border.color: "#FFFFFF"
    }
    Image {
        x: settingScreentextFieldPass.x - facade.toPx(57)
        y: (parent.height> 900)? settingScreentextFieldPass.y + settingScreentextFieldPass.height - sourceSize.height + facade.toPx(7): settingScreentextFieldPass.y + settingScreentextFieldPass.height - sourceSize.height + 7
        source: "ui/screensIcons/passIcon.png"
    }

    TextField {
        id: settingScreentextFieldPassRepeat
        y: (parent.height>900)? settingScreentextFieldPass.y + facade.toPx(100): settingScreentextFieldPass.y + 100
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
        y: settingScreentextFieldPassRepeat.y + settingScreentextFieldPassRepeat.height + facade.toPx(20)
        height: 1
        border.width: 1
        border.color: "#FFFFFF"
    }
    Image {
        x: settingScreentextFieldPassRepeat.x - facade.toPx(57)
        y: (parent.height>900)?settingScreentextFieldPassRepeat.y+settingScreentextFieldPassRepeat.height-sourceSize.height+facade.toPx(7):settingScreentextFieldPassRepeat.y+settingScreentextFieldPassRepeat.height-sourceSize.height+7
        source: "ui/screensIcons/passIcon.png"
    }

    TextField {
        id: settingScreentextFieldPhone
        y: (parent.height>900)? settingScreentextFieldPassRepeat.y + facade.toPx(100): settingScreentextFieldPassRepeat.y + 100
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
        y: settingScreentextFieldPhone.y + settingScreentextFieldPhone.height + facade.toPx(20)
        height: 1
        border.width: 1
        border.color: "#FFFFFF"
    }
    Image {
        x: settingScreentextFieldPhone.x - facade.toPx(57)
        y: (parent.height > 900)? settingScreentextFieldPhone.y + settingScreentextFieldPhone.height - sourceSize.height + facade.toPx(7): settingScreentextFieldPhone.y + settingScreentextFieldPhone.height - sourceSize.height + 7
        source: "ui/screensIcons/phoneIcon.png"
    }

    ComboBox {
        id: settingScreencomboBoxCitys
        y: (parent.height>900)? settingScreentextFieldPhone.y + facade.toPx(102): settingScreentextFieldPhone.y + 102
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
            font: settingScreencomboBoxCitys.font
            opacity: 0
            verticalAlignment: Text.AlignVCenter
            leftPadding: settingScreencomboBoxCitys.indicator.width + settingScreencomboBoxCitys.spacing
        }

        model: [
            "Волоколамск",
            "Петербург",
            "Москва"
        ]

        onActivated: {
            settingScreenComboBoxCitysField.text=textAt(currentIndex)
            popup.close()
        }

        indicator: Canvas {
            x: settingScreencomboBoxCitys.width - width - settingScreencomboBoxCitys.rightPadding
            y: settingScreencomboBoxCitys.topPadding + (settingScreencomboBoxCitys.availableHeight - height) / 2
            width: 20
            height: 12
            contextType: "2d"

            Connections {
                target: settingScreencomboBoxCitys
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
        id: settingScreenComboBoxCitysField
        y: (parent.height>900)? settingScreentextFieldPhone.y + facade.toPx(100): settingScreentextFieldPhone.y + 100
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
            settingScreencomboBoxCitys.popup.close()
        }

        onTextChanged: {
            settingScreencomboBoxCitys.popup.open()
            settingScreencomboBoxCitys.currentIndex = settingScreencomboBoxCitys.find(text,Qt.MatchContains)
        }
    }
    Rectangle {// ебаное нижнее подчеркивание. Ага, оно делается вот блять так!
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.leftMargin: 0.09 * parent.width
        anchors.rightMargin: 0.09 * parent.width
        y: settingScreenComboBoxCitysField.y + settingScreenComboBoxCitysField.height + facade.toPx(20)
        height: 1
        border.width: 1
        border.color: "#FFFFFF"
    }
    Image {
        x: settingScreenComboBoxCitysField.x - facade.toPx(57)
        y: (parent.height>900)?settingScreenComboBoxCitysField.y + settingScreenComboBoxCitysField.height - sourceSize.height+facade.toPx(7):settingScreenComboBoxCitysField.y+settingScreenComboBoxCitysField.height-sourceSize.height+7
        source: "ui/screensIcons/homeIcon.png"
    }

    Button {
        id: settingScreenButtonRegister
        y: (parent.height>900)? settingScreencomboBoxCitys.y + facade.toPx(100): settingScreencomboBoxCitys.y + 100

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
            if(settingScreentextFieldLogin.text.length< 2) {
                dialogAndroid.text = "Имя короче 2 символов"
                dialogAndroid.visible=true;
            }
            else
            if(settingScreentextFieldFamily.text.length<2) {
                dialogAndroid.text = "Фамилия менее 2 символов"
                dialogAndroid.visible=true;
            }
            else
            if(settingScreentextFieldPass.text.length < 5) {
                dialogAndroid.text = "Пароль короче 5 символов"
                dialogAndroid.visible=true;
            }
            else
            if(settingScreentextFieldPhone.text.length<11) {
                dialogAndroid.text = "Укажите корректный номер"
                dialogAndroid.visible=true;
            }
            else
            if(settingScreentextFieldPassRepeat.text!=settingScreentextFieldPass.text) {
                dialogAndroid.text = "Ваши пароли не совпадают"
                dialogAndroid.visible=true;
            }
            else {
                busyIndicatorScreen.visible = true
                if(event_handler.settingration(settingScreentextFieldLogin.text,settingScreentextFieldFamily.text,settingScreentextFieldPass.text,settingScreentextFieldPassRepeat.text,settingScreentextFieldEmail.text,settingScreentextFieldPhone.text,settingScreencomboBoxCitys.currentText)) {
                    event_handler.setFamily(settingScreentextFieldFamily.text)
                    event_handler.setPhone(settingScreentextFieldPhone.text)
                    event_handler.setLogin(settingScreentextFieldLogin.text)
                    event_handler.setMail(settingScreentextFieldEmail.text)
                    event_handler.setPass(settingScreentextFieldPass.text)
                    busyIndicatorScreen.visible = false
                    loader.source = "qrc:/main.qml"
                }
                else {
                    dialogAndroid.text="Вы уже зарегистрированы"
                    busyIndicatorScreen.visible = false
                    dialogAndroid.visible=true;
                }
            }
        }

        background: Rectangle {
                radius: 20
                color: settingScreenButtonRegister.down?"#960f133d":"#760f133d"
        }

        contentItem: Text {
                text: settingScreenButtonRegister.text
                font: settingScreenButtonRegister.font
                opacity: enabled ? 1.0 : 0.3
                color: settingScreenButtonRegister.down ? "#FFFFFF" : "#FFFFFF"
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                elide: Text.ElideRight
        }
    }

    Button {
        id: mainScreenBackButton
        width: (parent.width>500)?100*parent.width/500:100
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
    Text {
        color: "#FFFFFF"
        font.family: sfuiFont.name
        font.pointSize: facade.toPx(14)
        horizontalAlignment: Text.AlignHCenter

        text: "Вход"

        y: mainScreenBackButton.y + mainScreenBackButton.height/2 - font.pointSize/2 -facade.toPx(5)
        x: mainScreenBackButton.x + facade.toPx(30)
    }

    CourierStyle.BusyIndicator {
        id: busyIndicatorScreen
    }

    CourierStyle.DialogWindow {
        id: dialogAndroid
    }
}
//-------------------------------------------------------------------------------------------------------------

