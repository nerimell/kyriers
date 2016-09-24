import QtQuick 2.7
import QtQuick.Layouts 1.0
import QtQuick.Dialogs 1.2
import QtQuick.Controls 2.0

Item {
    id: pinMenu
    visible: true


    //--------------------------------------------------dialogAndroid----------------------------------------------
    Dialog {
        id: dialogAndroid

        /* */
        width: pinMenu.width-40 // Задаём ширину диалога, работает на десктопе, но не на Android
        height:pinMenu.height/2 // Задаём высоту диалога, работает на декстопе, но не на Android
        /* */

        // Создаём содержимое диалогового окна
        contentItem: Rectangle {
            color: "#f7f7f7"     // Задаём цвет
            width: pinMenu.width-40 // Устанавливаем ширину, необходимо для Android - устройства
            height:pinMenu.height/2 // Устанавливаем высоту, необходимо для Android - устройства

            // Область для сообщения диалогового окна
            Rectangle {
                anchors.top: parent.top
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.bottom: dialogAndroidDividerHorizontal.top
                color: "#f7f7f7"//Задаём цвет области

                Label {
                    id: dialogAndroidTextLabel

                    font.pointSize: 20

                    color: "#34aadc"
                    anchors.centerIn: parent//Помещаем сообщение в центр области отобраэжения
                }
            }

            // Создаём горизонтальный разделитель с Rectangle
            Rectangle {
                id: dialogAndroidDividerHorizontal
                color: "#d7d7d7"
                height: 2 // Устанавливаем ширину в два пикселя
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
                height: 50
                // А также прибиваем строку к низу диалогового окна
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.bottom: parent.bottom

                Button {
                    id: dialogAndroiddialogButtonCancel

                    // Растягиваем кнопку по высоте строки
                    anchors.top: parent.top
                    anchors.bottom: parent.bottom
                    //Задаём ширину кнопки на половину строки минус 1 пиксел
                    width: parent.width / 2 - 1

                    contentItem: Text {

                        font.pointSize: 24

                        color: "#34aadc"
                        text: qsTr("Отмена")
                        verticalAlignment: Text.AlignVCenter
                        horizontalAlignment: Text.AlignHCenter
                    }

                    // Стилизуем кнопку
                    background: Rectangle {
                        border.width: 0
                        color:dialogAndroiddialogButtonCancel.pressed?"#d7d7d7":"#f7f7f7"
                    }

                    onClicked: dialogAndroid.close()// По нажатию кнопки закрываем диалог
                }

                // Создаём разделитель между кнопками шириной в 2 пикселя
                Rectangle {
                    id: dialogAndroidDividerVertical
                    width: 2
                    // Растягиваем разделитель по высоте объекта строки
                    anchors.top: parent.top
                    anchors.bottom: parent.bottom
                    color: "#d7d7d7" // Задаём цвет разделителя
                }

                Button {
                    id: dialogAndroidDialogButtonOk

                    // Растягиваем кнопку по высоте строки
                    anchors.top: parent.top
                    anchors.bottom: parent.bottom
                    //Задаём ширину кнопки на половину строки минус 1 пиксел
                    width: parent.width / 2 - 1

                    contentItem: Text {

                        font.pointSize: 24

                        color: "#34aadc"
                        text: qsTr("Ок")
                        verticalAlignment: Text.AlignVCenter
                        horizontalAlignment: Text.AlignHCenter
                    }

                    // Стилизуем кнопку
                    background: Rectangle {
                        border.width: 0
                        color: dialogAndroidDialogButtonOk.pressed ? "#d7d7d7" : "#f7f7f7"
                    }

                    onClicked: {
                        pinSquare1.color="#10387E"
                        pinSquare2.color="#10387E"
                        pinSquare3.color="#10387E"
                        pinSquare4.color="#10387E"
                        event_handler.clearPin()
                        dialogAndroid.close()
                    }// По нажатию кнопки закрываем диалог
                }
            }
        }
    }
    //-------------------------------------------------------------------------------------------------------------


    //--------------------------------------------------busyIndicator----------------------------------------------
    Item {
        visible: false
        anchors.fill: parent
        id: busyIndicatorMainScreen

        RowLayout {
            anchors.fill: parent
            id: busyIndicatorRowLayout

            Image {
                anchors.fill: parent
                source: "ui/background1.png"
            }
        }

        BusyIndicator {
            id: busyIndicator
            width: busyIndicatorRowLayout.width  /2
            height: busyIndicatorRowLayout.height/2
            x: busyIndicatorRowLayout.width/2 - busyIndicator.width  /2
            y: busyIndicatorRowLayout.height/2 - busyIndicator.height/2
        }
    }
    //-------------------------------------------------------------------------------------------------------------

    Item {
        visible:true
        id: pinScreen
        anchors.fill: parent

        RowLayout {
            anchors.fill: parent
            id: mainScreenRowLayout

            Image {
                anchors.fill: parent
                source: "ui/background1.png"
            }
        }

        Image {
            id: firstScreenNavbarMenu
            x: 0
            anchors.topMargin: 0
            anchors.top: parent.top
            source: "ui/navbarMenu.png"

            anchors.left: parent.left
            anchors.right: parent.right
        }


        RowLayout {
            id: rowLayout0

            anchors.top: parent.top
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.topMargin: 0.2 * parent.height
            anchors.leftMargin: parent.width / 2 - 5*pinSquare1.width / 2 + gridLayout1.columnSpacing
            anchors.rightMargin: parent.width/ 2 - 5*pinSquare1.width / 2

            Rectangle {
                id: pinSquare1
                color: "#10387E"
                width: 80
                height: 80
                radius: 80
            }

            Rectangle {
                id: pinSquare2
                color: "#10387E"
                width: 80
                height: 80
                radius: 80
            }

            Rectangle {
                id: pinSquare3
                color: "#10387E"
                width: 80
                height: 80
                radius: 80
            }

            Rectangle {
                id: pinSquare4
                color: "#10387E"
                width: 80
                height: 80
                radius: 80
            }
        }

        Grid {
            id: gridLayout1
            columns: 3
            rowSpacing: 5
            columnSpacing: 5
            height: parent.height/2

            width: 400
            x: parent.width/2-gridLayout1.width/2

            anchors.bottom: parent.bottom
            anchors.bottomMargin: 0.09 * parent.height

            Button {
                id: button1
                text: qsTr("1")
                font.pointSize: 44

                height:gridLayout1.height/4-gridLayout1.rowSpacing
                width:gridLayout1.width/3-gridLayout1.columnSpacing

                background: Rectangle {
                    color: button1.down ? "#10387E" : "#337CFD"
                }
                contentItem: Text {
                    text: button1.text
                    font: button1.font
                    verticalAlignment: Text.AlignVCenter
                    horizontalAlignment: Text.AlignHCenter
                    color: button1.down ? "#FFFFFF" : "#FFFFFF"
                }
                onClicked: {
                    event_handler.setMyPin(text)
                    switch(event_handler.getMyPinLength()) {
                    case -1:
                        pinSquare4.color="#337CFD"
                        pinScreen.visible = false
                        busyIndicatorMainScreen.visible = true
                        if(event_handler.network_login()) {
                            loader.source = "qrc:/main.qml"
                        }
                        else {
                            dialogAndroidTextLabel.text="Нет доступа к сети"
                            pinScreen.visible = true
                            dialogAndroid.open();
                        }
                        busyIndicatorMainScreen.visible = false
                        break
                    case 1:
                        pinSquare1.color="#337CFD"
                        break
                    case 2:
                        pinSquare2.color="#337CFD"
                        break
                    case 3:
                        pinSquare3.color="#337CFD"
                        break
                    case 4:
                        pinSquare4.color="#337CFD"
                        dialogAndroidTextLabel.text = "Введен не верный пин"
                        dialogAndroid.open();
                        break
                    }
                }
            }

            Button {
                id: button2
                text: qsTr("2")
                font.pointSize: 44

                height:gridLayout1.height/4-gridLayout1.rowSpacing
                width:gridLayout1.width/3-gridLayout1.columnSpacing

                background: Rectangle {
                    color: button2.down ? "#10387E" : "#337CFD"
                }
                contentItem: Text {
                    text: button2.text
                    font: button2.font
                    verticalAlignment: Text.AlignVCenter
                    horizontalAlignment: Text.AlignHCenter
                    color: button2.down ? "#FFFFFF" : "#FFFFFF"
                }
                onClicked: {
                    event_handler.setMyPin(text)
                    switch(event_handler.getMyPinLength()) {
                    case -1:
                        pinSquare4.color="#337CFD"
                        pinScreen.visible = false
                        busyIndicatorMainScreen.visible = true
                        if(event_handler.network_login()) {
                            loader.source = "qrc:/main.qml"
                        }
                        else {
                            dialogAndroidTextLabel.text="Нет доступа к сети"
                            pinScreen.visible = true
                            dialogAndroid.open();
                        }
                        busyIndicatorMainScreen.visible = false
                        break
                    case 1:
                        pinSquare1.color="#337CFD"
                        break
                    case 2:
                        pinSquare2.color="#337CFD"
                        break
                    case 3:
                        pinSquare3.color="#337CFD"
                        break
                    case 4:
                        pinSquare4.color="#337CFD"
                        dialogAndroidTextLabel.text = "Введен не верный пин"
                        dialogAndroid.open();
                        break
                    }
                }
            }

            Button {
                id: button3
                text: qsTr("3")
                font.pointSize: 44

                height:gridLayout1.height/4-gridLayout1.rowSpacing
                width:gridLayout1.width/3-gridLayout1.columnSpacing

                background: Rectangle {
                    color: button3.down ? "#10387E" : "#337CFD"
                }
                contentItem: Text {
                    text: button3.text
                    font: button3.font
                    verticalAlignment: Text.AlignVCenter
                    horizontalAlignment: Text.AlignHCenter
                    color: button3.down ? "#FFFFFF" : "#FFFFFF"
                }
                onClicked: {
                    event_handler.setMyPin(text)
                    switch(event_handler.getMyPinLength()) {
                    case -1:
                        pinSquare4.color="#337CFD"
                        pinScreen.visible = false
                        busyIndicatorMainScreen.visible = true
                        if(event_handler.network_login()) {
                            loader.source = "qrc:/main.qml"
                        }
                        else {
                            dialogAndroidTextLabel.text="Нет доступа к сети"
                            pinScreen.visible = true
                            dialogAndroid.open();
                        }
                        busyIndicatorMainScreen.visible = false
                        break
                    case 1:
                        pinSquare1.color="#337CFD"
                        break
                    case 2:
                        pinSquare2.color="#337CFD"
                        break
                    case 3:
                        pinSquare3.color="#337CFD"
                        break
                    case 4:
                        pinSquare4.color="#337CFD"
                        dialogAndroidTextLabel.text = "Введен не верный пин"
                        dialogAndroid.open();
                        break
                    }
                }
            }

            Button {
                id: button4
                text: qsTr("4")
                font.pointSize: 44

                height:gridLayout1.height/4-gridLayout1.rowSpacing
                width:gridLayout1.width/3-gridLayout1.columnSpacing

                background: Rectangle {
                    color: button4.down ? "#10387E" : "#337CFD"
                }
                contentItem: Text {
                    text: button4.text
                    font: button4.font
                    verticalAlignment: Text.AlignVCenter
                    horizontalAlignment: Text.AlignHCenter
                    color: button4.down ? "#FFFFFF" : "#FFFFFF"
                }
                onClicked: {
                    event_handler.setMyPin(text)
                    switch(event_handler.getMyPinLength()) {
                    case -1:
                        pinSquare4.color="#337CFD"
                        pinScreen.visible = false
                        busyIndicatorMainScreen.visible = true
                        if(event_handler.network_login()) {
                            loader.source = "qrc:/main.qml"
                        }
                        else {
                            dialogAndroidTextLabel.text="Нет доступа к сети"
                            pinScreen.visible = true
                            dialogAndroid.open();
                        }
                        busyIndicatorMainScreen.visible = false
                        break
                    case 1:
                        pinSquare1.color="#337CFD"
                        break
                    case 2:
                        pinSquare2.color="#337CFD"
                        break
                    case 3:
                        pinSquare3.color="#337CFD"
                        break
                    case 4:
                        pinSquare4.color="#337CFD"
                        dialogAndroidTextLabel.text = "Введен не верный пин"
                        dialogAndroid.open();
                        break
                    }
                }
            }

            Button {
                id: button5
                text: qsTr("5")
                font.pointSize: 44

                height:gridLayout1.height/4-gridLayout1.rowSpacing
                width:gridLayout1.width/3-gridLayout1.columnSpacing

                background: Rectangle {
                    color: button5.down ? "#10387E" : "#337CFD"
                }
                contentItem: Text {
                    text: button5.text
                    font: button5.font
                    verticalAlignment: Text.AlignVCenter
                    horizontalAlignment: Text.AlignHCenter
                    color: button5.down ? "#FFFFFF" : "#FFFFFF"
                }
                onClicked: {
                    event_handler.setMyPin(text)
                    switch(event_handler.getMyPinLength()) {
                    case -1:
                        pinSquare4.color="#337CFD"
                        pinScreen.visible = false
                        busyIndicatorMainScreen.visible = true
                        if(event_handler.network_login()) {
                            loader.source = "qrc:/main.qml"
                        }
                        else {
                            dialogAndroidTextLabel.text="Нет доступа к сети"
                            pinScreen.visible = true
                            dialogAndroid.open();
                        }
                        busyIndicatorMainScreen.visible = false
                        break
                    case 1:
                        pinSquare1.color="#337CFD"
                        break
                    case 2:
                        pinSquare2.color="#337CFD"
                        break
                    case 3:
                        pinSquare3.color="#337CFD"
                        break
                    case 4:
                        pinSquare4.color="#337CFD"
                        dialogAndroidTextLabel.text = "Введен не верный пин"
                        dialogAndroid.open();
                        break
                    }
                }
            }

            Button {
                id: button6
                text: qsTr("6")
                font.pointSize: 44

                height:gridLayout1.height/4-gridLayout1.rowSpacing
                width:gridLayout1.width/3-gridLayout1.columnSpacing

                background: Rectangle {
                    color: button6.down ? "#10387E" : "#337CFD"
                }
                contentItem: Text {
                    text: button6.text
                    font: button6.font
                    verticalAlignment: Text.AlignVCenter
                    horizontalAlignment: Text.AlignHCenter
                    color: button6.down ? "#FFFFFF" : "#FFFFFF"
                }
                onClicked: {
                    event_handler.setMyPin(text)
                    switch(event_handler.getMyPinLength()) {
                    case -1:
                        pinSquare4.color="#337CFD"
                        pinScreen.visible = false
                        busyIndicatorMainScreen.visible = true
                        if(event_handler.network_login()) {
                            loader.source = "qrc:/main.qml"
                        }
                        else {
                            dialogAndroidTextLabel.text="Нет доступа к сети"
                            pinScreen.visible = true
                            dialogAndroid.open();
                        }
                        busyIndicatorMainScreen.visible = false
                        break
                    case 1:
                        pinSquare1.color="#337CFD"
                        break
                    case 2:
                        pinSquare2.color="#337CFD"
                        break
                    case 3:
                        pinSquare3.color="#337CFD"
                        break
                    case 4:
                        pinSquare4.color="#337CFD"
                        dialogAndroidTextLabel.text = "Введен не верный пин"
                        dialogAndroid.open();
                        break
                    }
                }
            }

            Button {
                id: button7
                text: qsTr("7")
                font.pointSize: 44

                height:gridLayout1.height/4-gridLayout1.rowSpacing
                width:gridLayout1.width/3-gridLayout1.columnSpacing

                background: Rectangle {
                    color: button7.down ? "#10387E" : "#337CFD"
                }
                contentItem: Text {
                    text: button7.text
                    font: button7.font
                    verticalAlignment: Text.AlignVCenter
                    horizontalAlignment: Text.AlignHCenter
                    color: button7.down ? "#FFFFFF" : "#FFFFFF"
                }
                onClicked: {
                    event_handler.setMyPin(text)
                    switch(event_handler.getMyPinLength()) {
                    case -1:
                        pinSquare4.color="#337CFD"
                        pinScreen.visible = false
                        busyIndicatorMainScreen.visible = true
                        if(event_handler.network_login()) {
                            loader.source = "qrc:/main.qml"
                        }
                        else {
                            dialogAndroidTextLabel.text="Нет доступа к сети"
                            pinScreen.visible = true
                            dialogAndroid.open();
                        }
                        busyIndicatorMainScreen.visible = false
                        break
                    case 1:
                        pinSquare1.color="#337CFD"
                        break
                    case 2:
                        pinSquare2.color="#337CFD"
                        break
                    case 3:
                        pinSquare3.color="#337CFD"
                        break
                    case 4:
                        pinSquare4.color="#337CFD"
                        dialogAndroidTextLabel.text = "Введен не верный пин"
                        dialogAndroid.open();
                        break
                    }
                }
            }

            Button {
                id: button8
                text: qsTr("8")
                font.pointSize: 44

                height:gridLayout1.height/4-gridLayout1.rowSpacing
                width:gridLayout1.width/3-gridLayout1.columnSpacing

                background: Rectangle {
                    color: button8.down ? "#10387E" : "#337CFD"
                }
                contentItem: Text {
                    text: button8.text
                    font: button8.font
                    verticalAlignment: Text.AlignVCenter
                    horizontalAlignment: Text.AlignHCenter
                    color: button8.down ? "#FFFFFF" : "#FFFFFF"
                }
                onClicked: {
                    event_handler.setMyPin(text)
                    switch(event_handler.getMyPinLength()) {
                    case -1:
                        pinSquare4.color="#337CFD"
                        pinScreen.visible = false
                        busyIndicatorMainScreen.visible = true
                        if(event_handler.network_login()) {
                            loader.source = "qrc:/main.qml"
                        }
                        else {
                            dialogAndroidTextLabel.text="Нет доступа к сети"
                            pinScreen.visible = true
                            dialogAndroid.open();
                        }
                        busyIndicatorMainScreen.visible = false
                        break
                    case 1:
                        pinSquare1.color="#337CFD"
                        break
                    case 2:
                        pinSquare2.color="#337CFD"
                        break
                    case 3:
                        pinSquare3.color="#337CFD"
                        break
                    case 4:
                        pinSquare4.color="#337CFD"
                        dialogAndroidTextLabel.text = "Введен не верный пин"
                        dialogAndroid.open();
                        break
                    }
                }
            }

            Button {
                id: button9
                text: qsTr("9")
                font.pointSize: 44

                height:gridLayout1.height/4-gridLayout1.rowSpacing
                width:gridLayout1.width/3-gridLayout1.columnSpacing

                background: Rectangle {
                    color: button9.down ? "#10387E" : "#337CFD"
                }
                contentItem: Text {
                    text: button9.text
                    font: button9.font
                    verticalAlignment: Text.AlignVCenter
                    horizontalAlignment: Text.AlignHCenter
                    color: button9.down ? "#FFFFFF" : "#FFFFFF"
                }
                onClicked: {
                    event_handler.setMyPin(text)
                    switch(event_handler.getMyPinLength()) {
                    case -1:
                        pinSquare4.color="#337CFD"
                        pinScreen.visible = false
                        busyIndicatorMainScreen.visible = true
                        if(event_handler.network_login()) {
                            loader.source = "qrc:/main.qml"
                        }
                        else {
                            dialogAndroidTextLabel.text="Нет доступа к сети"
                            pinScreen.visible = true
                            dialogAndroid.open();
                        }
                        busyIndicatorMainScreen.visible = false
                        break
                    case 1:
                        pinSquare1.color="#337CFD"
                        break
                    case 2:
                        pinSquare2.color="#337CFD"
                        break
                    case 3:
                        pinSquare3.color="#337CFD"
                        break
                    case 4:
                        pinSquare4.color="#337CFD"
                        dialogAndroidTextLabel.text = "Введен не верный пин"
                        dialogAndroid.open();
                        break
                    }
                }
            }

            Button {
                id: button10
                text: qsTr("Домой")
                font.pointSize: 24

                height:gridLayout1.height/4-gridLayout1.rowSpacing
                width:gridLayout1.width/3-gridLayout1.columnSpacing

                background: Rectangle {
                    color: button10.down ? "#10387E" : "#337CFD"
                }
                contentItem: Text {
                    text: button10.text
                    font: button10.font
                    verticalAlignment: Text.AlignVCenter
                    horizontalAlignment: Text.AlignHCenter
                    color: button10.down ? "#FFFFFF" : "#FFFFFF"
                }

                onClicked: {
                    loader.source="qrc:/login.qml"
                }
            }

            Button {
                id: button11
                text: qsTr("0")
                font.pointSize: 44

                height:gridLayout1.height/4-gridLayout1.rowSpacing
                width:gridLayout1.width/3-gridLayout1.columnSpacing

                background: Rectangle {
                    color: button11.down ? "#10387E" : "#337CFD"
                }
                contentItem: Text {
                    text: button11.text
                    font: button11.font
                    verticalAlignment: Text.AlignVCenter
                    horizontalAlignment: Text.AlignHCenter
                    color: button11.down ? "#FFFFFF" : "#FFFFFF"
                }
                onClicked: {
                    event_handler.setMyPin(text)
                    switch(event_handler.getMyPinLength()) {
                    case -1:
                        pinSquare4.color="#337CFD"
                        pinScreen.visible = false
                        busyIndicatorMainScreen.visible = true
                        if(event_handler.network_login()) {
                            loader.source = "qrc:/main.qml"
                        }
                        else {
                            dialogAndroidTextLabel.text="Нет доступа к сети"
                            pinScreen.visible = true
                            dialogAndroid.open();
                        }
                        busyIndicatorMainScreen.visible = false
                        break
                    case 1:
                        pinSquare1.color="#337CFD"
                        break
                    case 2:
                        pinSquare2.color="#337CFD"
                        break
                    case 3:
                        pinSquare3.color="#337CFD"
                        break
                    case 4:
                        pinSquare4.color="#337CFD"
                        dialogAndroidTextLabel.text = "Введен не верный пин"
                        dialogAndroid.open();
                        break
                    }
                }
            }

            Button {
                id: button12
                text: qsTr("Сбросить")
                font.pointSize: 24

                height:gridLayout1.height/4-gridLayout1.rowSpacing
                width:gridLayout1.width/3-gridLayout1.columnSpacing

                background: Rectangle {
                    color: button12.down ? "#10387E" : "#337CFD"
                }
                contentItem: Text {
                    text: button12.text
                    font: button12.font
                    verticalAlignment: Text.AlignVCenter
                    horizontalAlignment: Text.AlignHCenter
                    color: button12.down ? "#FFFFFF" : "#FFFFFF"
                }
                onClicked: {
                    event_handler.clearPin()
                    pinSquare1.color="#10387E"
                    pinSquare2.color="#10387E"
                    pinSquare3.color="#10387E"
                    pinSquare4.color="#10387E"
                }
            }
        }
    }
}
