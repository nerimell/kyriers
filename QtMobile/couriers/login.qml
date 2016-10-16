import QtQuick 2.7
import QtQuick.Layouts 1.0
import QtQuick.Controls 2.0
import "CourierStyle" as CourierStyle

//--------------------------------------------------loginScreen.qml---------------------------------------------
Item {
    id: loginScreen
    anchors.fill: parent

    MouseArea {
        id: mouseArea1
        drag.minimumY: (parent.height<900)? parent.height - 900: 0.22 * parent.height
        drag.maximumY: 0.22 * parent.height
        anchors.fill: parent
        drag.target: mainScreenTextFieldLogin
        drag.axis: Drag.YAxis
    }

    Image {
        x: parent.width/2 - width/2
        y: (parent.width<parent.height)?parent.height/2-height/2:0
        height: (parent.width<parent.height)?parent.height:sourceSize.height*(width/sourceSize.width)
        width: (parent.width<parent.height)?sourceSize.width*(parent.height/sourceSize.height):parent.width
        source: "ui/background/background2.png"
    }

    Text {
        color: "#FFFFFF"
        font.family: sfuiFont.name
        font.pointSize: facade.toPx(17)
        horizontalAlignment: Text.AlignHCenter

        y: mainScreenBackButton.y + mainScreenBackButton.height/2 - font.pointSize/2 -facade.toPx(7)
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.leftMargin: parent.width /2 - facade.toPx(50)
        anchors.rightMargin: parent.width/2 - facade.toPx(50)

        text: "Войти"
    }

    Button {
        id: mainScreenButtonLogin
        y:mainScreenSwitchRememberMe.y+facade.toPx(210)
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.leftMargin: 0.09 * parent.width
        anchors.rightMargin: 0.09* parent.width
        height: (parent.height> 900)? facade.toPx(70): 70
        checked: false
        checkable: false
        autoRepeat: false
        highlighted: false
        text: qsTr("Вход")
        autoExclusive: false

        font.pointSize:  facade.toPx(14)

        onClicked: {
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
                loader.source = "qrc:/main.qml"
                busyIndicatorScreen.visible= true
                if(event_handler.networkLogin(mainScreenTextFieldLogin.text, mainScreenTextFieldPass.text)) {
                    if(mainScreenSwitchRememberMe.checked)
                    event_handler.savingToFile(mainScreenTextFieldLogin.text, mainScreenTextFieldPass.text);
                    //loader.source = "qrc:/main.qml"
                }
                else {
                    dialogAndroid.text = "Вы не зарегистрированы"
                    dialogAndroid.visible = true;
                }
                busyIndicatorScreen.visible=false
            }
        }

        background: Rectangle {
                radius: 20
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
        height: (parent.height > 900)? facade.toPx(44): 44

        y: 0.22 * parent.height
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.rightMargin: 0.09 * parent.width
        placeholderText: qsTr("Номер мобильного")
        inputMethodHints: Qt.ImhFormattedNumbersOnly
        anchors.leftMargin: 0.09 * parent.width + facade.toPx(50)

        color: "#FFFFFF"
        validator: DoubleValidator {}
        font.pointSize: facade.toPx(18)
        verticalAlignment: Text.AlignVCenter

        onFocusChanged: {
            if(text.length== 0)
            text = "+7"
        }
        background: Rectangle {
            opacity: 0
        }
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
        x: mainScreenTextFieldLogin.x - facade.toPx(47)
        y: (parent.height>900)?mainScreenTextFieldLogin.y + mainScreenTextFieldLogin.height - sourceSize.height + facade.toPx(7):mainScreenTextFieldLogin.y+mainScreenTextFieldLogin.height-sourceSize.height + 7
        source: "ui/screensIcons/phoneIcon.png"
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

        background: Rectangle { opacity: 0 }

        color: "#FFFFFF"
        echoMode: TextInput.Password
        font.pointSize: facade.toPx(18)
        verticalAlignment: Text.AlignVCenter

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
        x: mainScreenTextFieldPass.x - facade.toPx(47)
        y: (parent.height>900)?mainScreenTextFieldPass.y + mainScreenTextFieldPass.height - sourceSize.height + facade.toPx(7):mainScreenTextFieldPass.y + mainScreenTextFieldPass.height - sourceSize.height + 7
        source: "ui/screensIcons/passIcon.png"
    }

    Switch {
        id: mainScreenSwitchRememberMe
        y: (parent.height > 900)? mainScreenTextFieldPass.y+ facade.toPx(100): mainScreenTextFieldPass.y + 100
        anchors.left: parent.left
        anchors.leftMargin: 0.09 * parent.width
        height: (parent.height > 900)? facade.toPx(48): 48

        leftPadding: 0
        spacing: facade.toPx(15)

        text: qsTr("Запомнить меня")
        font.pointSize: facade.toPx(18)

        indicator: Rectangle {
            radius: facade.toPx(15)
            implicitWidth: facade.toPx(80)
            implicitHeight: facade.toPx(42)
            x: mainScreenSwitchRememberMe.leftPadding
            y: parent.height / 2 - height / 2
            color:mainScreenSwitchRememberMe.checked?"#337CFD" : "#FFFFFF"

            Rectangle {
                x: mainScreenSwitchRememberMe.checked ? parent.width - (width + (parent.height-height)/2): (parent.height-height)/2
                anchors.verticalCenter: parent.verticalCenter
                width: mainScreenSwitchRememberMe.height/1.8
                height: mainScreenSwitchRememberMe.height/1.8
                radius: width / 2
                color: mainScreenSwitchRememberMe.down ? "#10387E" : (mainScreenSwitchRememberMe.checked ? "#FFFFFF" : "#337CFD")
            }
        }

        contentItem: Text {
            text: mainScreenSwitchRememberMe.text
            font: mainScreenSwitchRememberMe.font
            opacity: enabled ? 1.0 : 0.3
            color: mainScreenSwitchRememberMe.down ? "#FFFFFF" : (mainScreenSwitchRememberMe.checked ? "#FFFFFF" : "#BDB5B5")
            verticalAlignment: Text.AlignVCenter
            leftPadding: mainScreenSwitchRememberMe.indicator.width + mainScreenSwitchRememberMe.spacing
        }
    }

    Button {
        id: mainScreenLabelForgotPass
        y: (parent.height > 900)? mainScreenButtonLogin.y + facade.toPx(90): mainScreenButtonLogin.y + 90
        text: qsTr("Забыли пароль?")

        font.pointSize: facade.toPx(16)

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
            loader.source = "qrc:/regist.qml"
        }
    }
    Text {
        color: "#FFFFFF"
        font.family: sfuiFont.name
        font.pointSize: facade.toPx(14)
        horizontalAlignment: Text.AlignHCenter

        text: "Рег."

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
