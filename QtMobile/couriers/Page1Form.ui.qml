import QtQuick 2.7
import QtQuick.Layouts 1.0
import QtQuick.Controls 2.0

Item {
    id: item1
    property alias button1: button1
    property alias textField1: textField1
    property alias textField2: textField2

    RowLayout {
        id: rowLayout1
        anchors.fill: parent
    }

    Button {
        id: button1
        x: 236
        y: 303
        width: 362
        height: 48
        text: qsTr("Войти в систему")
        scale: 1
        autoRepeat: false
        autoExclusive: false
        checked: false
        checkable: false
        highlighted: false
        font.pointSize: 20
        anchors.horizontalCenterOffset: 0
        anchors.horizontalCenter: rowLayout1.horizontalCenter

        background: Rectangle {
                color: button1.down ? "#808080" : "#267F00"
                border.color: "#26282a"
                border.width: 1
                radius: 4
        }
        contentItem: Text {
                text: button1.text
                font: button1.font
                opacity: enabled ? 1.0 : 0.3
                color: button1.down ? "#FFFFFF" : "#FFFFFF"
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                elide: Text.ElideRight
        }
    }

    TextField {
        id: textField1
        x: 69
        y: 134
        width: 362
        height: 44
        placeholderText: qsTr("Введите логин")
        font.pixelSize: 24
        anchors.horizontalCenter: rowLayout1.horizontalCenter
    }

    TextField {
        id: textField2
        x: 69
        y: 191
        width: 362
        height: 44
        placeholderText: qsTr("Введите пароль")
        echoMode: TextInput.Password
        font.pixelSize: 24
        anchors.horizontalCenterOffset: 0
        anchors.horizontalCenter: rowLayout1.horizontalCenter
    }

    CheckBox {
        id: checkBox1
        x: 69
        y: 241
        width: 362
        height: 48
        text: qsTr("Запомнить меня")
        font.pixelSize: 24
        leftPadding: 0
        spacing: 8
        anchors.horizontalCenterOffset: 0
        anchors.horizontalCenter: rowLayout1.horizontalCenter

        indicator: Rectangle {
                implicitWidth: 26
                implicitHeight: 26
                x: checkBox1.leftPadding
                y: parent.height / 2 - height / 2
                radius: 3
                border.color: checkBox1.down ? "#17a81a" : "#21be2b"

                Rectangle {
                    width: 14
                    height: 14
                    x: 6
                    y: 6
                    radius: 2
                    color: checkBox1.down ? "#17a81a" : "#21be2b"
                    visible: checkBox1.checked
                }
            }

        contentItem: Text {
                text: checkBox1.text
                font: checkBox1.font
                opacity: enabled ? 1.0 : 0.3
                color: checkBox1.down ? "#17a81a" : "#21be2b"
                verticalAlignment: Text.AlignVCenter
                leftPadding: checkBox1.indicator.width + checkBox1.spacing
            }
    }

    Label {
        id: label1
        x: 69
        y: 365
        text: qsTr("Забыли пароль?")
        anchors.horizontalCenterOffset: -80
        anchors.horizontalCenter: rowLayout1.horizontalCenter
        font.pointSize: 20
        font.underline: true
        verticalAlignment: Text.AlignTop
    }

    Label {
        id: label2
        x: 69
        y: 404
        text: qsTr("Зарегистрироваться")
        anchors.horizontalCenterOffset: -56
        anchors.horizontalCenter: rowLayout1.horizontalCenter
        font.pointSize: 20
        font.underline: true
    }
}
