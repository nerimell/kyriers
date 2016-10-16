import QtQuick 2.7
import QtQuick.Layouts 1.0
import QtQuick.Controls 2.0

//--------------------------------------------------basicScreen.qml--------------------------------------------
Item {
    id: basicScreen
    anchors.fill: parent

    Image {
        x: parent.width/2 - width/2
        y: (parent.width<parent.height)? parent.height/2-height/2: 0
        height: (parent.width<parent.height)? parent.height:sourceSize.height*(width/sourceSize.width)
        width:  (parent.width<parent.height)? sourceSize.width*(parent.height/sourceSize.height): parent.width
        source: "ui/background/background1.png"
    }

    Image {
        id: imagelogo
        x: parent.width/2 - imagelogo.width / 2
        y: 0.21*basicScreen.height
        width: (parent.width<600)?sourceSize.width/1.5 * parent.width/500: sourceSize.width/1.5 * 600/500
        height: (parent.width<600)?sourceSize.height/1.5 * parent.width/500: sourceSize.height/1.5 * 600/500
        source: "ui/mainlogo.png"
    }

    Text {
        anchors.left: basicScreen.left
        anchors.right: basicScreen.right
        anchors.leftMargin: basicScreen.width / 2 - facade.toPx(100)
        anchors.rightMargin: basicScreen.width/ 2 - facade.toPx(100)

        font.family: sfuiFont.name
        font.pointSize: facade.toPx(18)

        color: "#FFFFFF"
        y: imagelogo.y+imagelogo.height+(basicScreenButtonLogin.y-(imagelogo.y+imagelogo.height))/2-facade.toPx(30)
        horizontalAlignment: Text.AlignHCenter

        text: "Какой-то текст, слоган\nкакой-то текст"
    }

    Button {
        id: basicScreenButtonLogin
        y: 0.64* basicScreen.height
        x: parent.width/2-basicScreenButtonLogin.width/2

        height: (parent.height>900)? facade.toPx(70): 70
        width: (parent.width<520)? 433 * parent.width/500: 433 * 520/500
        text: qsTr("Войти")
        autoRepeat: false
        autoExclusive: false
        checked: false
        checkable: false
        highlighted: false

        font.family: sfuiFont.name
        font.pointSize: facade.toPx(14)

        onClicked: {
            loader.source="qrc:/login.qml"
        }

        background: Rectangle {
                radius: 20
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
        y: basicScreenButtonLogin.y + basicScreenButtonLogin.height + facade.toPx(18)

        height: (parent.height>900)? facade.toPx(70): 70
        width: (parent.width<520)? 433 * parent.width/500: 433 * 520/500
        checked: false
        checkable: false
        autoRepeat: false
        highlighted: false
        autoExclusive: false
        text: qsTr("Регистрация")

        font.family: sfuiFont.name
        font.pointSize: facade.toPx(14)

        onClicked: {
            loader.source="qrc:/regist.qml"
        }

        background: Rectangle {
                radius: 20
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
