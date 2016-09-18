import QtQuick 2.7
import QtQuick.Layouts 1.0
import QtQuick.Controls 2.0
import couriers.EventHandler 1.0

ApplicationWindow {
    visible: true
    width: 500
    height: 700
    title: qsTr("Couriers")

    EventHandler {
        id: event_handler
    }

    //http://doc.qt.io/qt-5/qtquickcontrols2-customize.html

    Page1Form {
        id: page1Form
        button1.onClicked: {
            event_handler.network_login(textField1.text,textField2.text);
        }
        anchors.fill: parent
    }

    /*
    footer: TabBar {
        id: tabBar
        currentIndex: swipeView.currentIndex
        TabButton {
            text: qsTr("First")
        }
        TabButton {
            text: qsTr("Second")
        }
    }
    */
}





/*
import QtQuick 2.7
import QtQuick.Layouts 1.0
import QtQuick.Controls 2.0
import couriers.EventHandler 1.0

ApplicationWindow {
    id: window
    visible: true
    width: 500
    height: 700
    title: qsTr("Couriers")

    Drawer {
        id: drawer
        width: 0.75 * window.width
        height: window.height
        dragMargin: 10
    }

    Loader
    {
        anchors.fill: parent
        id: loader
    }

    EventHandler {
        id: event_handler
    }

    ColumnLayout {
        id: loginLayout
        anchors.fill: parent

        TextField {
            id: numField
            placeholderText: "Введите логин"
            Layout.alignment: Qt.AlignHCenter | Qt.AlignBottom
        }

        TextField {
            id: codeField
            placeholderText: "Введите пароль"
            Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
        }

        Button {
            id: loginButton
            text: "Вход в систему"
            rotation: 0
            transformOrigin: Item.Center
            smooth: true
            antialiasing: false
            Layout.alignment: Qt.AlignHCenter | Qt.AlignTop
            highlighted: true
            onClicked: {
                event_handler.network_login(numField.text,codeField.text);
            }
        }
    }
}

  */
