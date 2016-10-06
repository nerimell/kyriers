import QtQuick 2.7
import QtQuick.Layouts 1.0
import QtQuick.Dialogs 1.2
import QtQuick.Controls 2.0

Item {
    id: rootMain
    visible: true

    //http://doc.qt.io/qt-5/qtquickcontrols2-customize.html

    //--------------------------------------------------dialogAndroid----------------------------------------------
    Dialog {
        id: dialogAndroid

        // Создаём содержимое диалогового окна
        contentItem: Rectangle {
            color: "#f7f7f7"
            width: rootMain.width-80
            height: rootMain.height/3

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
                        color:dialogAndroidDialogButtonOk.pressed? "#d7d7d7" : "#f7f7f7"
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
        id: busyIndicatorMainScreen

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


    //--------------------------------------------------basicScreen.qml--------------------------------------------
    Item {
        visible: false
        id: basicScreen
        anchors.fill: parent

        Image {
            x: parent.width/2 - width/2
            y: (parent.width<parent.height)?parent.height/2-height/2:0
            height: (parent.width<parent.height)? parent.height:sourceSize.height*(width/sourceSize.width)
            width:  (parent.width<parent.height)? sourceSize.width*(parent.height/sourceSize.height): parent.width
            source: "ui/background1.png"
        }

        Image {
            id: imagelogo
            x: parent.width/2-imagelogo.width/2
            y: 0.21*basicScreen.height
            width: (parent.width<620)? 365 * parent.width/500: 365 * 620/500
            height: (parent.width<620)? 164 * parent.width/500: 164 * 620/500
            source: "ui/mainlogo.png"
        }

        Text {
            anchors.left: basicScreen.left
            anchors.right: basicScreen.right
            anchors.leftMargin: basicScreen.width / 2 - 100
            anchors.rightMargin: basicScreen.width/ 2 - 100

            font.pointSize: 18
            font.family: sfuiFont.name
            color: "#FFFFFF"
            y: imagelogo.y+imagelogo.height+(basicScreenButtonLogin.y-(imagelogo.y+imagelogo.height))/2-30
            horizontalAlignment: Text.AlignHCenter

            text: "Какой-то текст, слоган\nкакой-то текст"
        }

        Drawer {
            id: basicScreenDrawer
            dragMargin: 20
            height: rootMain.height
            width: 0.75 * rootMain.width

            Image {
                anchors.fill: parent
                source: "ui/navbarBack.png"
            }
            Image {
                x: parent.width/2 - width/2
                y: basicScreenDrawerButtonExit.y/2- height/2 - 10 * parent.height/900
                width: sourceSize.width * 500 / 750
                height: (parent.height<900)? sourceSize.height* (parent.height+100)/1334: sourceSize.height*900/1334
                source: "ui/navbarLogo.png"
            }
            Rectangle {
                y: basicScreenDrawerButtonExit.y + basicScreenDrawerButtonExit.height + 1
                color: "#87FFFFFF"
                width: parent.width
                height:parent.height - y
            }

            Button {
                id: basicScreenDrawerButtonExit
                x: 0
                y: 156 * parent.height/900
                height: (parent.height > 900)? 77 * parent.height/900: 77
                text: qsTr("Выйти из программы")

                font.pointSize: 19
                font.family: sfuiFontLight.name

                anchors.left: parent.left
                anchors.right: parent.right

                background: Rectangle {
                    color: "#87FFFFFF"
                    anchors.fill: parent
                    id: basicScreenDrawerRectangle1
                }

                Image {
                    id: basicScreenDrawerImage1
                    x: 30
                    y: parent.height/2 - sourceSize.height/2
                    source: "ui/icons/exit_blue.png"
                }

                contentItem: Text {
                        text: basicScreenDrawerButtonExit.text
                        font: basicScreenDrawerButtonExit.font
                        opacity: enabled ? 1.0 : 0.3
                        color: basicScreenDrawerButtonExit.down ? "#FFFFFF" : "#10387F"
                        leftPadding: 80
                        verticalAlignment: Text.AlignVCenter
                        elide: Text.ElideRight
                }

                onPressed: {
                    basicScreenDrawerRectangle1.opacity = 0
                    basicScreenDrawerImage1.source= "ui/icons/exit_white.png"
                }

                onPressedChanged: {
                    basicScreenDrawerRectangle1.opacity = 1
                    basicScreenDrawerImage1.source= "ui/icons/exit_blue.png"
                }

                onClicked: Qt.quit()
            }
        }

        Button {
            id: basicScreenButtonLogin
            y: 0.67* basicScreen.height
            x: parent.width/2-basicScreenButtonLogin.width/2

            height: (parent.height>900)? 70*parent.height/900: 70
            width: (parent.width<540)? 433 * parent.width/500: 433 * 540/500
            text: qsTr("Войти")
            autoRepeat: false
            autoExclusive: false
            checked: false
            checkable: false
            highlighted: false

            font.pointSize: 14
            font.family: sfuiFont.name

            onClicked: {
                loader.source="qrc:/login.qml"
            }

            background: Rectangle {
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
            y: basicScreenButtonLogin.y + basicScreenButtonLogin.height + 18 * parent.height/900

            height: (parent.height>900)? 70*parent.height/900: 70
            width: (parent.width<540)? 433 * parent.width/500: 433 * 540/500
            checked: false
            checkable: false
            autoRepeat: false
            highlighted: false
            autoExclusive: false
            text: qsTr("Регистрация")

            font.pointSize: 14
            font.family: sfuiFont.name

            onClicked: {
                loader.source="qrc:/regist.qml"
            }

            background: Rectangle {
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


    //--------------------------------------------------firstScreen.qml--------------------------------------------
    Item {
        visible: true
        id: firstScreen
        anchors.fill: parent

        Image {
            x: parent.width/2 - width/2
            y: (parent.width<parent.height)?parent.height/2-height/2:0
            height: (parent.width<parent.height)?parent.height:sourceSize.height*(width/sourceSize.width)
            width: (parent.width<parent.height)?sourceSize.width*(parent.height/sourceSize.height):parent.width
            source: "ui/background4.png"
        }

        Drawer {
            id: firstScreenDrawer
            dragMargin: 20
            height: rootMain.height
            width: 0.75 * rootMain.width

            Image {
                anchors.fill: parent
                source: "ui/navbarBack.png"
            }
            Image {
                x: parent.width/2 - width/2
                y: firstScreenDrawerButtonMyStatus.y/2- height/2 - 10 * parent.height/900
                width: sourceSize.width * 500 / 750
                height: (parent.height<900)? sourceSize.height* (parent.height+100)/1334: sourceSize.height*900/1334
                source: "ui/navbarLogo.png"
            }
            Rectangle {
                y: firstScreenDrawerButtonExit.y + firstScreenDrawerButtonExit.height + 1
                color: "#87FFFFFF"
                width: parent.width
                height:parent.height - y
            }

            Button {
                id: firstScreenDrawerButtonMyStatus
                x: 0
                y: 156 * parent.height/900
                height: (parent.height > 900)? 77 * parent.height/900: 77
                text: qsTr("Мой статус")

                font.pointSize: 19
                font.family: sfuiFontLight.name

                anchors.left: parent.left
                anchors.right: parent.right

                background: Rectangle {
                    color: "#87FFFFFF"
                    anchors.fill: parent
                    id: firstScreenDrawerRectangle1
                }

                Image {
                    id: firstScreenDrawerImage1
                    x: 30
                    y: parent.height/2 - sourceSize.height/2
                    source: "ui/icons/status_blue.png"
                }

                contentItem: Text {
                        text: firstScreenDrawerButtonMyStatus.text
                        font: firstScreenDrawerButtonMyStatus.font
                        opacity: enabled ? 1.0 : 0.3
                        color: firstScreenDrawerButtonMyStatus.down ? "#FFFFFF" : "#10387F"
                        leftPadding: 80
                        verticalAlignment: Text.AlignVCenter
                        elide: Text.ElideRight
                }

                onPressed: {
                    firstScreenDrawerRectangle1.opacity = 0
                    firstScreenDrawerImage1.source= "ui/icons/status_white.png"
                }

                onPressedChanged: {
                    firstScreenDrawerRectangle1.opacity = 1
                    firstScreenDrawerImage1.source= "ui/icons/status_blue.png"
                }

                onClicked: {
                    firstScreenDrawer.close()
                    firstScreen.visible=false
                    statusScreen.visible=true
                }
            }

            Button {
                id: firstScreenDrawerButtonMyAddverts
                x: 0
                y: firstScreenDrawerButtonMyStatus.y+firstScreenDrawerButtonMyStatus.height+1
                height: (parent.height > 900)? 77 * parent.height/900: 77
                text: qsTr("Мои объявления")

                font.pointSize: 19
                font.family: sfuiFontLight.name

                anchors.left: parent.left
                anchors.right: parent.right

                background: Rectangle {
                    color: "#87FFFFFF"
                    anchors.fill: parent
                    id: firstScreenDrawerRectangle2
                }

                Image {
                    id: firstScreenDrawerImage2
                    x: 30
                    y: parent.height/2 - sourceSize.height/2
                    source: "ui/icons/orders_blue.png"
                }

                contentItem: Text {
                        text: firstScreenDrawerButtonMyAddverts.text
                        font: firstScreenDrawerButtonMyAddverts.font
                        opacity: enabled ? 1.0 : 0.3
                        color: firstScreenDrawerButtonMyAddverts.down ? "#FFFFFF" : "#10387F"
                        leftPadding: 80
                        verticalAlignment: Text.AlignVCenter
                        elide: Text.ElideRight
                }

                onPressed: {
                    firstScreenDrawerRectangle2.opacity = 0
                    firstScreenDrawerImage2.source= "ui/icons/orders_white.png"
                }

                onPressedChanged: {
                    firstScreenDrawerRectangle2.opacity = 1
                    firstScreenDrawerImage2.source= "ui/icons/orders_blue.png"
                }
            }

            Button {
                id: firstScreenDrawerButtonFindAdverts
                x: 0
                y: firstScreenDrawerButtonMyAddverts.y+firstScreenDrawerButtonMyAddverts.height+1
                height: (parent.height > 900)? 77 * parent.height/900: 77
                text: qsTr("Найти объявление")

                font.pointSize: 19
                font.family: sfuiFontLight.name

                anchors.left: parent.left
                anchors.right: parent.right

                background: Rectangle {
                    color: "#87FFFFFF"
                    anchors.fill: parent
                    id: firstScreenDrawerRectangle3
                }

                Image {
                    id: firstScreenDrawerImage3
                    x: 30
                    y: parent.height/2 - sourceSize.height/2
                    source: "ui/icons/find_blue.png"
                }

                contentItem: Text {
                        text: firstScreenDrawerButtonFindAdverts.text
                        font: firstScreenDrawerButtonFindAdverts.font
                        opacity: enabled ? 1.0 : 0.3
                        color: firstScreenDrawerButtonFindAdverts.down ? "#FFFFFF" : "#10387F"
                        leftPadding: 80
                        verticalAlignment: Text.AlignVCenter
                        elide: Text.ElideRight
                }

                onPressed: {
                    firstScreenDrawerRectangle3.opacity = 0
                    firstScreenDrawerImage3.source= "ui/icons/find_white.png"
                }

                onPressedChanged: {
                    firstScreenDrawerRectangle3.opacity = 1
                    firstScreenDrawerImage3.source= "ui/icons/find_blue.png"
                }
            }

            Button {
                id: firstScreenDrawerButtonMySettings
                x: 0
                y: firstScreenDrawerButtonFindAdverts.y+firstScreenDrawerButtonFindAdverts.height+1
                height: (parent.height > 900)? 77 * parent.height/900: 77
                text: qsTr("Мои настройки")

                font.pointSize: 19
                font.family: sfuiFontLight.name

                anchors.left: parent.left
                anchors.right: parent.right

                background: Rectangle {
                    color: "#87FFFFFF"
                    anchors.fill: parent
                    id: firstScreenDrawerRectangle4
                }

                Image {
                    id: firstScreenDrawerImage4
                    x: 30
                    y: parent.height/2 - sourceSize.height/2
                    source: "ui/icons/config_blue.png"
                }

                contentItem: Text {
                        text: firstScreenDrawerButtonMySettings.text
                        font: firstScreenDrawerButtonMySettings.font
                        opacity: enabled ? 1.0 : 0.3
                        color: firstScreenDrawerButtonMySettings.down ? "#FFFFFF" : "#10387F"
                        leftPadding: 80
                        verticalAlignment: Text.AlignVCenter
                        elide: Text.ElideRight
                }

                onPressed: {
                    firstScreenDrawerRectangle4.opacity = 0
                    firstScreenDrawerImage4.source= "ui/icons/config_white.png"
                }

                onPressedChanged: {
                    firstScreenDrawerRectangle4.opacity = 1
                    firstScreenDrawerImage4.source= "ui/icons/config_blue.png"
                }

                onClicked: {
                    settingsScreen.visible=true
                    firstScreen.visible=false
                    firstScreenDrawer.close()
                }
            }

            Button {
                id: firstScreenDrawerButtonExit
                x: 0
                y: firstScreenDrawerButtonMySettings.y+firstScreenDrawerButtonMySettings.height+1
                height: (parent.height > 900)? 77 * parent.height/900: 77
                text: qsTr("Разлогиниться")

                font.pointSize: 19
                font.family: sfuiFontLight.name

                anchors.left: parent.left
                anchors.right: parent.right

                background: Rectangle {
                    color: "#87FFFFFF"
                    anchors.fill: parent
                    id: firstScreenDrawerRectangle5
                }

                Image {
                    id: firstScreenDrawerImage5
                    x: 30
                    y: parent.height/2 - sourceSize.height/2
                    source: "ui/icons/exit_blue.png"
                }

                contentItem: Text {
                        text: firstScreenDrawerButtonExit.text
                        font: firstScreenDrawerButtonExit.font
                        opacity: enabled ? 1.0 : 0.3
                        color: firstScreenDrawerButtonExit.down ? "#FFFFFF" : "#10387F"
                        leftPadding: 80
                        verticalAlignment: Text.AlignVCenter
                        elide: Text.ElideRight
                }

                onPressed: {
                    firstScreenDrawerRectangle5.opacity = 0
                    firstScreenDrawerImage5.source= "ui/icons/exit_white.png"
                }

                onPressedChanged: {
                    firstScreenDrawerRectangle5.opacity = 1
                    firstScreenDrawerImage5.source= "ui/icons/exit_blue.png"
                }

                onClicked: {
                    event_handler.exitMenu()
                    basicScreen.visible=true
                    firstScreen.visible=false
                    firstScreenDrawer.close()
                }
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
            height: (parent.height > 900)? sourceSize.height * parent.height/900: sourceSize.height

            Button {
                id: firstScreenNavbarButton
                x: 20
                width: 80
                height: 48
                y: firstScreenNavbarMenu.height/2 - firstDrawerButton.height / 2

                background: Rectangle {
                    opacity: 0
                }

                onClicked: {
                    firstScreenDrawer.open()
                }

                Image {
                    id: firstDrawerButton
                    anchors.fill: parent
                    source: "ui/drawerButton.png"
                    fillMode: Image.PreserveAspectFit
                }
            }
        }
    }
    //-------------------------------------------------------------------------------------------------------------


    //--------------------------------------------------statusScreen.qml-------------------------------------------
    Item {
        visible: false
        id: statusScreen
        anchors.fill: parent

        Image {
            x: parent.width/2 - width/2
            y: (parent.width<parent.height)?parent.height/2-height/2:0
            height: (parent.width<parent.height)?parent.height:sourceSize.height*(width/sourceSize.width)
            width: (parent.width<parent.height)?sourceSize.width*(parent.height/sourceSize.height):parent.width
            source: "ui/background4.png"
        }

        MouseArea {
            drag.minimumY: -20
            drag.maximumY: 111
            anchors.fill: parent
            drag.target: statusScreenSwitchBusy
            drag.axis: Drag.YAxis
        }

        Drawer {
            id: statusScreenDrawer
            dragMargin: 20
            height: rootMain.height
            width: 0.75 * rootMain.width

            Image {
                anchors.fill: parent
                source: "ui/navbarBack.png"
            }
            Image {
                x: parent.width/2 - width/2
                y: statusScreenDrawerButtonMyStatus.y/2 - height/2 - 10 * parent.height/900
                width: sourceSize.width * 500 / 750
                height: (parent.height<900)? sourceSize.height* (parent.height+100)/1334: sourceSize.height*900/1334
                source: "ui/navbarLogo.png"
            }
            Rectangle {
                y: statusScreenDrawerButtonExit.y + statusScreenDrawerButtonExit.height + 1
                color: "#87FFFFFF"
                width: parent.width
                height:parent.height - y
            }

            Button {
                id: statusScreenDrawerButtonMyStatus
                x: 0
                y: 156 * parent.height/900
                height: (parent.height > 900)? 77 * parent.height/900: 77
                text: qsTr("Мой статус")

                font.pointSize: 19
                font.family: sfuiFontLight.name

                anchors.left: parent.left
                anchors.right: parent.right

                background: Rectangle {
                    color: "#87FFFFFF"
                    anchors.fill: parent
                    id: statusScreenDrawerRectangle1
                }

                Image {
                    id: statusScreenDrawerImage1
                    x: 30
                    y: parent.height/2 - sourceSize.height/2
                    source: "ui/icons/status_blue.png"
                }

                contentItem: Text {
                        text: statusScreenDrawerButtonMyStatus.text
                        font: statusScreenDrawerButtonMyStatus.font
                        opacity: enabled ? 1.0 : 0.3
                        color: statusScreenDrawerButtonMyStatus.down ? "#FFFFFF" : "#10387F"
                        leftPadding: 80
                        verticalAlignment: Text.AlignVCenter
                        elide: Text.ElideRight
                }

                onPressed: {
                    statusScreenDrawerRectangle1.opacity = 0
                    statusScreenDrawerImage1.source= "ui/icons/status_white.png"
                }

                onPressedChanged: {
                    statusScreenDrawerRectangle1.opacity = 1
                    statusScreenDrawerImage1.source= "ui/icons/status_blue.png"
                }

                onClicked: {
                    statusScreenDrawer.close()
                }
            }

            Button {
                id: statusScreenDrawerButtonMyAddverts
                x: 0
                y: statusScreenDrawerButtonMyStatus.y+statusScreenDrawerButtonMyStatus.height+1
                height: (parent.height > 900)? 77 * parent.height/900: 77
                text: qsTr("Мои объявления")

                font.pointSize: 19
                font.family: sfuiFontLight.name

                anchors.left: parent.left
                anchors.right: parent.right

                background: Rectangle {
                    color: "#87FFFFFF"
                    anchors.fill: parent
                    id: statusScreenDrawerRectangle2
                }

                Image {
                    id: statusScreenDrawerImage2
                    x: 30
                    y: parent.height/2 - sourceSize.height/2
                    source: "ui/icons/orders_blue.png"
                }

                contentItem: Text {
                        text: statusScreenDrawerButtonMyAddverts.text
                        font: statusScreenDrawerButtonMyAddverts.font
                        opacity: enabled ? 1.0 : 0.3
                        color: statusScreenDrawerButtonMyAddverts.down ? "#FFFFFF" : "#10387F"
                        leftPadding: 80
                        verticalAlignment: Text.AlignVCenter
                        elide: Text.ElideRight
                }

                onPressed: {
                    statusScreenDrawerRectangle2.opacity = 0
                    statusScreenDrawerImage2.source= "ui/icons/orders_white.png"
                }

                onPressedChanged: {
                    statusScreenDrawerRectangle2.opacity = 1
                    statusScreenDrawerImage2.source= "ui/icons/orders_blue.png"
                }
            }

            Button {
                id: statusScreenDrawerButtonFindAdverts
                x: 0
                y: statusScreenDrawerButtonMyAddverts.y+statusScreenDrawerButtonMyAddverts.height+1
                height: (parent.height > 900)? 77 * parent.height/900: 77
                text: qsTr("Найти объявление")

                font.pointSize: 19
                font.family: sfuiFontLight.name

                anchors.left: parent.left
                anchors.right: parent.right

                background: Rectangle {
                    color: "#87FFFFFF"
                    anchors.fill: parent
                    id: statusScreenDrawerRectangle3
                }

                Image {
                    id: statusScreenDrawerImage3
                    x: 30
                    y: parent.height/2 - sourceSize.height/2
                    source: "ui/icons/find_blue.png"
                }

                contentItem: Text {
                        text: statusScreenDrawerButtonFindAdverts.text
                        font: statusScreenDrawerButtonFindAdverts.font
                        opacity: enabled ? 1.0 : 0.3
                        color: statusScreenDrawerButtonFindAdverts.down ? "#FFFFFF" : "#10387F"
                        leftPadding: 80
                        verticalAlignment: Text.AlignVCenter
                        elide: Text.ElideRight
                }

                onPressed: {
                    statusScreenDrawerRectangle3.opacity = 0
                    statusScreenDrawerImage3.source= "ui/icons/find_white.png"
                }

                onPressedChanged: {
                    statusScreenDrawerRectangle3.opacity = 1
                    statusScreenDrawerImage3.source= "ui/icons/find_blue.png"
                }
            }

            Button {
                id: statusScreenDrawerButtonMySettings
                x: 0
                y: statusScreenDrawerButtonFindAdverts.y+statusScreenDrawerButtonFindAdverts.height+1
                height: (parent.height > 900)? 77 * parent.height/900: 77
                text: qsTr("Мои настройки")

                font.pointSize: 19
                font.family: sfuiFontLight.name

                anchors.left: parent.left
                anchors.right: parent.right

                background: Rectangle {
                    color: "#87FFFFFF"
                    anchors.fill: parent
                    id: statusScreenDrawerRectangle4
                }

                Image {
                    id: statusScreenDrawerImage4
                    x: 30
                    y: parent.height/2 - sourceSize.height/2
                    source: "ui/icons/config_blue.png"
                }

                contentItem: Text {
                        text: statusScreenDrawerButtonMySettings.text
                        font: statusScreenDrawerButtonMySettings.font
                        opacity: enabled ? 1.0 : 0.3
                        color: statusScreenDrawerButtonMySettings.down ? "#FFFFFF" : "#10387F"
                        leftPadding: 80
                        verticalAlignment: Text.AlignVCenter
                        elide: Text.ElideRight
                }

                onPressed: {
                    statusScreenDrawerRectangle4.opacity = 0
                    statusScreenDrawerImage4.source= "ui/icons/config_white.png"
                }

                onPressedChanged: {
                    statusScreenDrawerRectangle4.opacity = 1
                    statusScreenDrawerImage4.source= "ui/icons/config_blue.png"
                }

                onClicked: {
                    settingsScreen.visible=true
                    statusScreen.visible=false
                    statusScreenDrawer.close()
                }
            }

            Button {
                id: statusScreenDrawerButtonExit
                x: 0
                y: statusScreenDrawerButtonMySettings.y+statusScreenDrawerButtonMySettings.height+1
                height: (parent.height > 900)? 77 * parent.height/900: 77
                text: qsTr("Разлогиниться")

                font.pointSize: 19
                font.family: sfuiFontLight.name

                anchors.left: parent.left
                anchors.right: parent.right

                background: Rectangle {
                    color: "#87FFFFFF"
                    anchors.fill: parent
                    id: statusScreenDrawerRectangle5
                }

                Image {
                    id: statusScreenDrawerImage5
                    x: 30
                    y: parent.height/2 - sourceSize.height/2
                    source: "ui/icons/exit_blue.png"
                }

                contentItem: Text {
                        text: statusScreenDrawerButtonExit.text
                        font: statusScreenDrawerButtonExit.font
                        opacity: enabled ? 1.0 : 0.3
                        color: statusScreenDrawerButtonExit.down ? "#FFFFFF" : "#10387F"
                        leftPadding: 80
                        verticalAlignment: Text.AlignVCenter
                        elide: Text.ElideRight
                }

                onPressed: {
                    statusScreenDrawerRectangle5.opacity = 0
                    statusScreenDrawerImage5.source= "ui/icons/exit_white.png"
                }

                onPressedChanged: {
                    statusScreenDrawerRectangle5.opacity = 1
                    statusScreenDrawerImage5.source= "ui/icons/exit_blue.png"
                }

                onClicked: {
                    event_handler.exitMenu()
                    basicScreen.visible=true
                    statusScreen.visible=false
                    statusScreenDrawer.close()
                }
            }
        }

        Switch {
            id: statusScreenSwitchBusy
            x: 40
            y: 111

            onClicked: {
                if(statusScreenSwitchBusy.checked) {
                statusScreenSwitchFreeText.color= "#A8A8A8"
                statusScreenSwitchBusyText.color= "#FFFFFF"
                statusScreenSwitchepartedText.color= "#A8A8A8"
                statusScreenSwitchDoOrderText.color= "#A8A8A8"
                }
                else statusScreenSwitchBusyText.color="#A8A8A8"
                statusScreenSwitchFree.checked=false
                statusScreenSwitchDoOrder.checked=false
                statusScreenSwitchDeparted.checked=false
            }
        }
        Text {
            id: statusScreenSwitchBusyText
            color: "#A8A8A8"
            font.pointSize: 40
            text: qsTr("Занят")
            y: statusScreenSwitchBusy.y - 15
            x: statusScreenSwitchBusy.x + 80
        }
        Rectangle { // ебаное нижнее подчеркивание. Ага, оно делается вот блять так!
            x: 0
            y: statusScreenSwitchBusy.y + 60
            width: parent.width
            height: 1
            border.color: "#FFFFFF"
            border.width: 1
        }

        Switch {
            id: statusScreenSwitchFree
            x: 40
            y:statusScreenSwitchBusy.y + 100

            onClicked: {
                if(statusScreenSwitchFree.checked) {
                statusScreenSwitchFreeText.color= "#FFFFFF"
                statusScreenSwitchBusyText.color= "#A8A8A8"
                statusScreenSwitchepartedText.color= "#A8A8A8"
                statusScreenSwitchDoOrderText.color= "#A8A8A8"
                }
                else statusScreenSwitchFreeText.color="#A8A8A8"
                statusScreenSwitchBusy.checked=false
                statusScreenSwitchDoOrder.checked=false
                statusScreenSwitchDeparted.checked=false
            }
        }
        Text {
            id: statusScreenSwitchFreeText
            color: "#A8A8A8"
            font.pointSize: 40
            text: qsTr("Свободен")
            y: statusScreenSwitchFree.y - 15
            x: statusScreenSwitchFree.x + 80
        }
        Rectangle { // ебаное нижнее подчеркивание. Ага, оно делается вот блять так!
            x: 0
            y: statusScreenSwitchFree.y + 60
            width: parent.width
            height: 1
            border.color: "#FFFFFF"
            border.width: 1
        }

        Switch {
            id: statusScreenSwitchDeparted
            x: 40
            y:statusScreenSwitchBusy.y + 200

            onClicked: {
                if(statusScreenSwitchDeparted.checked) {
                statusScreenSwitchFreeText.color= "#A8A8A8"
                statusScreenSwitchBusyText.color= "#A8A8A8"
                statusScreenSwitchepartedText.color= "#FFFFFF"
                statusScreenSwitchDoOrderText.color= "#A8A8A8"
                }
                else statusScreenSwitchepartedText.color="#A8A8A8"
                statusScreenSwitchBusy.checked=false
                statusScreenSwitchFree.checked=false
                statusScreenSwitchDoOrder.checked=false
            }
        }
        Text {
            id: statusScreenSwitchepartedText
            color: "#A8A8A8"
            font.pointSize: 40
            text: qsTr("Отошел")
            y: statusScreenSwitchDeparted.y - 15
            x: statusScreenSwitchDeparted.x + 80
        }
        Rectangle { // ебаное нижнее подчеркивание. Ага, оно делается вот блять так!
            x: 0
            y: statusScreenSwitchDeparted.y + 60
            width: parent.width
            height: 1
            border.color: "#FFFFFF"
            border.width: 1
        }

        Switch {
            id: statusScreenSwitchDoOrder
            x: 40
            y:statusScreenSwitchBusy.y + 300

            onClicked: {
                if(statusScreenSwitchDoOrder.checked) {
                statusScreenSwitchFreeText.color= "#A8A8A8"
                statusScreenSwitchBusyText.color= "#A8A8A8"
                statusScreenSwitchepartedText.color= "#A8A8A8"
                statusScreenSwitchDoOrderText.color= "#FFFFFF"
                }
                else statusScreenSwitchDoOrderText.color="#A8A8A8"
                statusScreenSwitchBusy.checked=false
                statusScreenSwitchFree.checked=false
                statusScreenSwitchDeparted.checked=false
            }
        }
        Text {
            id: statusScreenSwitchDoOrderText
            color: "#A8A8A8"
            font.pointSize: 40
            text: qsTr("Выполняю\nзаказ\nID = 5497")
            y: statusScreenSwitchDoOrder.y - 15
            x: statusScreenSwitchDoOrder.x + 80
        }
        Rectangle { // ебаное нижнее подчеркивание. Ага, оно делается вот блять так!
            x: 0
            y: statusScreenSwitchDoOrder.y + 190
            width: parent.width
            height: 1
            border.color: "#FFFFFF"
            border.width: 1
        }

        Image {
            id: statusScreenNavbarMenu
            x: 0
            anchors.topMargin: 0
            anchors.top: parent.top
            source: "ui/navbarMenu.png"

            anchors.left: parent.left
            anchors.right: parent.right
            height: (parent.height > 900)? sourceSize.height * parent.height/900: sourceSize.height

            Button {
                id: statusScreenNavbarButton
                x: 20
                width: 80
                height: 48
                y: statusScreenNavbarMenu.height/2 - statusDrawerButton.height / 2

                background: Rectangle {
                    opacity: 0
                }

                onClicked: {
                    statusScreenDrawer.open()
                }

                Image {
                    id: statusDrawerButton
                    anchors.fill: parent
                    source: "ui/drawerButton.png"
                    fillMode: Image.PreserveAspectFit
                }
            }
        }
    }
    //-------------------------------------------------------------------------------------------------------------


    //--------------------------------------------------settingsScreen.qml--------------------------------------------
    Item {
        visible: false
        id: settingsScreen
        anchors.fill: parent

        Image {
            x: parent.width/2 - width/2
            y: (parent.width<parent.height)?parent.height/2-height/2:0
            height: (parent.width<parent.height)?parent.height:sourceSize.height*(width/sourceSize.width)
            width: (parent.width<parent.height)?sourceSize.width*(parent.height/sourceSize.height):parent.width
            source: "ui/background4.png"
        }

        MouseArea {
            drag.minimumY: -20
            drag.maximumY: 100
            anchors.fill: parent
            drag.target: settingScreentextFieldLogin
            drag.axis: Drag.YAxis
        }

        Drawer {
            id: settingScreenDrawer
            dragMargin: 20
            height: rootMain.height
            width: 0.75 * rootMain.width

            Image {
                anchors.fill: parent
                source: "ui/navbarBack.png"
            }
            Image {
                x: parent.width/2 - width/2
                y: settingScreenDrawerButtonMyStatus.y/2 - height/2 - 10 * parent.height/ 900
                width: sourceSize.width * 500 / 750
                height: (parent.height<900)? sourceSize.height* (parent.height+100)/1334: sourceSize.height*900/1334
                source: "ui/navbarLogo.png"
            }
            Rectangle {
                y: settingScreenDrawerButtonExit.y + settingScreenDrawerButtonExit.height + 1
                color: "#87FFFFFF"
                width: parent.width
                height:parent.height - y
            }

            Button {
                id: settingScreenDrawerButtonMyStatus
                x: 0
                y: 156 * parent.height/900
                height: (parent.height > 900)? 77 * parent.height/900: 77
                text: qsTr("Мой статус")

                font.pointSize: 19
                font.family: sfuiFontLight.name

                anchors.left: parent.left
                anchors.right: parent.right

                background: Rectangle {
                    color: "#87FFFFFF"
                    anchors.fill: parent
                    id: settingScreenDrawerRectangle1
                }

                Image {
                    id: settingScreenDrawerImage1
                    x: 30
                    y: parent.height/2 - sourceSize.height/2
                    source: "ui/icons/status_blue.png"
                }

                contentItem: Text {
                        text: settingScreenDrawerButtonMyStatus.text
                        font: settingScreenDrawerButtonMyStatus.font
                        opacity: enabled ? 1.0 : 0.3
                        color: settingScreenDrawerButtonMyStatus.down ? "#FFFFFF" : "#10387F"
                        leftPadding: 80
                        verticalAlignment: Text.AlignVCenter
                        elide: Text.ElideRight
                }

                onPressed: {
                    settingScreenDrawerRectangle1.opacity = 0
                    settingScreenDrawerImage1.source= "ui/icons/status_white.png"
                }

                onPressedChanged: {
                    settingScreenDrawerRectangle1.opacity = 1
                    settingScreenDrawerImage1.source= "ui/icons/status_blue.png"
                }

                onClicked: {
                    settingsScreen.visible=false
                    statusScreen.visible = true
                    settingScreenDrawer.close()
                }
            }

            Button {
                id: settingScreenDrawerButtonMyAddverts
                x: 0
                y: settingScreenDrawerButtonMyStatus.y+settingScreenDrawerButtonMyStatus.height+1
                height: (parent.height > 900)? 77 * parent.height/900: 77
                text: qsTr("Мои объявления")

                font.pointSize: 19
                font.family: sfuiFontLight.name

                anchors.left: parent.left
                anchors.right: parent.right

                background: Rectangle {
                    color: "#87FFFFFF"
                    anchors.fill: parent
                    id: settingScreenDrawerRectangle2
                }

                Image {
                    id: settingScreenDrawerImage2
                    x: 30
                    y: parent.height/2 - sourceSize.height/2
                    source: "ui/icons/orders_blue.png"
                }

                contentItem: Text {
                        text: settingScreenDrawerButtonMyAddverts.text
                        font: settingScreenDrawerButtonMyAddverts.font
                        opacity: enabled ? 1.0 : 0.3
                        color: settingScreenDrawerButtonMyAddverts.down ? "#FFFFFF" : "#10387F"
                        leftPadding: 80
                        verticalAlignment: Text.AlignVCenter
                        elide: Text.ElideRight
                }

                onPressed: {
                    settingScreenDrawerRectangle2.opacity = 0
                    settingScreenDrawerImage2.source= "ui/icons/orders_white.png"
                }

                onPressedChanged: {
                    settingScreenDrawerRectangle2.opacity = 1
                    settingScreenDrawerImage2.source= "ui/icons/orders_blue.png"
                }
            }

            Button {
                id: settingScreenDrawerButtonFindAdverts
                x: 0
                y: settingScreenDrawerButtonMyAddverts.y+settingScreenDrawerButtonMyAddverts.height+1
                height: (parent.height > 900)? 77 * parent.height/900: 77
                text: qsTr("Найти объявление")

                font.pointSize: 19
                font.family: sfuiFontLight.name

                anchors.left: parent.left
                anchors.right: parent.right

                background: Rectangle {
                    color: "#87FFFFFF"
                    anchors.fill: parent
                    id: settingScreenDrawerRectangle3
                }

                Image {
                    id: settingScreenDrawerImage3
                    x: 30
                    y: parent.height/2 - sourceSize.height/2
                    source: "ui/icons/find_blue.png"
                }

                contentItem: Text {
                        text: settingScreenDrawerButtonFindAdverts.text
                        font: settingScreenDrawerButtonFindAdverts.font
                        opacity: enabled ? 1.0 : 0.3
                        color: settingScreenDrawerButtonFindAdverts.down ? "#FFFFFF" : "#10387F"
                        leftPadding: 80
                        verticalAlignment: Text.AlignVCenter
                        elide: Text.ElideRight
                }

                onPressed: {
                    settingScreenDrawerRectangle3.opacity = 0
                    settingScreenDrawerImage3.source= "ui/icons/find_white.png"
                }

                onPressedChanged: {
                    settingScreenDrawerRectangle3.opacity = 1
                    settingScreenDrawerImage3.source= "ui/icons/find_blue.png"
                }
            }

            Button {
                id: settingScreenDrawerButtonMySettings
                x: 0
                y: settingScreenDrawerButtonFindAdverts.y+settingScreenDrawerButtonFindAdverts.height+1
                height: (parent.height > 900)? 77 * parent.height/900: 77
                text: qsTr("Мои настройки")

                font.pointSize: 19
                font.family: sfuiFontLight.name

                anchors.left: parent.left
                anchors.right: parent.right

                background: Rectangle {
                    color: "#87FFFFFF"
                    anchors.fill: parent
                    id: settingScreenDrawerRectangle4
                }

                Image {
                    id: settingScreenDrawerImage4
                    x: 30
                    y: parent.height/2 - sourceSize.height/2
                    source: "ui/icons/config_blue.png"
                }

                contentItem: Text {
                        text: settingScreenDrawerButtonMySettings.text
                        font: settingScreenDrawerButtonMySettings.font
                        opacity: enabled ? 1.0 : 0.3
                        color: settingScreenDrawerButtonMySettings.down ? "#FFFFFF" : "#10387F"
                        leftPadding: 80
                        verticalAlignment: Text.AlignVCenter
                        elide: Text.ElideRight
                }

                onPressed: {
                    settingScreenDrawerRectangle4.opacity = 0
                    settingScreenDrawerImage4.source= "ui/icons/config_white.png"
                }

                onPressedChanged: {
                    settingScreenDrawerRectangle4.opacity = 1
                    settingScreenDrawerImage4.source= "ui/icons/config_blue.png"
                }

                onClicked: {
                    settingScreenDrawer.close()
                }
            }

            Button {
                id: settingScreenDrawerButtonExit
                x: 0
                y: settingScreenDrawerButtonMySettings.y+settingScreenDrawerButtonMySettings.height+1
                height: (parent.height > 900)? 77 * parent.height/900: 77
                text: qsTr("Разлогиниться")

                font.pointSize: 19
                font.family: sfuiFontLight.name

                anchors.left: parent.left
                anchors.right: parent.right

                background: Rectangle {
                    color: "#87FFFFFF"
                    anchors.fill: parent
                    id: settingScreenDrawerRectangle5
                }

                Image {
                    id: settingScreenDrawerImage5
                    x: 30
                    y: parent.height/2 - sourceSize.height/2
                    source: "ui/icons/exit_blue.png"
                }

                contentItem: Text {
                        text: settingScreenDrawerButtonExit.text
                        font: settingScreenDrawerButtonExit.font
                        opacity: enabled ? 1.0 : 0.3
                        color: settingScreenDrawerButtonExit.down ? "#FFFFFF" : "#10387F"
                        leftPadding: 80
                        verticalAlignment: Text.AlignVCenter
                        elide: Text.ElideRight
                }

                onPressed: {
                    settingScreenDrawerRectangle5.opacity = 0
                    settingScreenDrawerImage5.source= "ui/icons/exit_white.png"
                }

                onPressedChanged: {
                    settingScreenDrawerRectangle5.opacity = 1
                    settingScreenDrawerImage5.source= "ui/icons/exit_blue.png"
                }

                onClicked: {
                    event_handler.exitMenu()
                    basicScreen.visible = true
                    settingScreenDrawer.close()
                    settingsScreen.visible=false
                }
            }
        }

        TextField {
            id: settingScreentextFieldLogin
            y: 100
            anchors.left: parent.left
            anchors.right: parent.right
            height: (parent.height > 900)? 44 * (parent.height/900): 44
            anchors.rightMargin: 0.09 * parent.width
            anchors.leftMargin: 0.09 * parent.width + 50
            placeholderText: qsTr("Имя")
            text: event_handler.getLogin()

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
            y: settingScreentextFieldLogin.y + settingScreentextFieldLogin.height + 20
            height: 1
            border.width: 1
            border.color: "#FFFFFF"
        }
        Image {
            x: settingScreentextFieldLogin.x - 47
            y: settingScreentextFieldLogin.y + settingScreentextFieldLogin.height - sourceSize.height + 7 / (parent.height/900)
            source: "ui/humanIcon.png"
        }

        TextField {
            id: settingScreentextFieldFamily
            y: settingScreentextFieldLogin.y + 100*parent.height/900
            anchors.left: parent.left
            anchors.right: parent.right
            height: (parent.height > 900)? 44 * (parent.height/900): 44
            anchors.rightMargin: 0.09 * parent.width
            anchors.leftMargin: 0.09 * parent.width + 50
            placeholderText: qsTr("Фамилия")
            text: event_handler.getFamily()

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
            y: settingScreentextFieldFamily.y + settingScreentextFieldFamily.height + 20
            height: 1
            border.width: 1
            border.color: "#FFFFFF"
        }
        Image {
            x: settingScreentextFieldFamily.x - 47
            y: settingScreentextFieldFamily.y + settingScreentextFieldFamily.height - sourceSize.height + 7 / (parent.height/900)
            source: "ui/humanIcon.png"
        }

        TextField {
            id: settingScreentextFieldEmail
            y: settingScreentextFieldLogin.y + 200*parent.height/900
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
            y: settingScreentextFieldEmail.y + settingScreentextFieldEmail.height + 20
            height: 1
            border.width: 1
            border.color: "#FFFFFF"
        }
        Image {
            x: settingScreentextFieldEmail.x - 47
            y: settingScreentextFieldEmail.y + settingScreentextFieldEmail.height - sourceSize.height + 7 / (parent.height/900)
            source: "ui/phoneIcon.png"
        }

        TextField {
            id: settingScreentextFieldPass
            y: settingScreentextFieldLogin.y + 300*parent.height/900
            anchors.left: parent.left
            anchors.right: parent.right
            height: (parent.height > 900)? 44 * (parent.height/900): 44
            anchors.rightMargin: 0.09 * parent.width
            anchors.leftMargin: 0.09 * parent.width + 50
            placeholderText: qsTr("Пароль")
            text: event_handler.getPass()

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
            y: settingScreentextFieldPass.y + settingScreentextFieldPass.height + 20
            height: 1
            border.width: 1
            border.color: "#FFFFFF"
        }
        Image {
            x: settingScreentextFieldPass.x - 47
            y: settingScreentextFieldPass.y + settingScreentextFieldPass.height - sourceSize.height + 7 / (parent.height/900)
            source: "ui/passIcon.png"
        }

        TextField {
            id: settingScreentextFieldPassRepeat
            y: settingScreentextFieldLogin.y + 400*parent.height/900
            anchors.left: parent.left
            anchors.right: parent.right
            height: (parent.height > 900)? 44 * (parent.height/900): 44
            anchors.rightMargin: 0.09 * parent.width
            anchors.leftMargin: 0.09 * parent.width + 50
            placeholderText: qsTr("Повтор пароля")
            text: event_handler.getPass()

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
            y: settingScreentextFieldPassRepeat.y + settingScreentextFieldPassRepeat.height + 20
            height: 1
            border.width: 1
            border.color: "#FFFFFF"
        }
        Image {
            x: settingScreentextFieldPassRepeat.x - 47
            y: settingScreentextFieldPassRepeat.y + settingScreentextFieldPassRepeat.height - sourceSize.height + 7 / (parent.height/900)
            source: "ui/passIcon.png"
        }

        TextField {
            id: settingScreentextFieldPhone
            y: settingScreentextFieldLogin.y + 500*parent.height/900
            anchors.left: parent.left
            anchors.right: parent.right
            height: (parent.height > 900)? 44 * (parent.height/900): 44
            anchors.rightMargin: 0.09 * parent.width
            anchors.leftMargin: 0.09 * parent.width + 50
            placeholderText: qsTr("Номер мобильного")
            text: event_handler.getPhone()

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
            y: settingScreentextFieldPhone.y + settingScreentextFieldPhone.height + 20
            height: 1
            border.width: 1
            border.color: "#FFFFFF"
        }
        Image {
            x: settingScreentextFieldPhone.x - 47
            y: settingScreentextFieldPhone.y + settingScreentextFieldPhone.height - sourceSize.height + 7 / (parent.height/900)
            source: "ui/phoneIcon.png"
        }

        Button {
            id: settingScreenButtonRegister
            y: (parent.height>900)? settingScreentextFieldPhone.y + 86 * parent.height/900: settingScreentextFieldPhone.y + 86
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
            text: qsTr("Применить изменения")

            font.pointSize: 18

            onClicked: {
                if(settingScreentextFieldLogin.text.length< 2) {
                    dialogAndroidTextLabel.text = "Имя короче 2 символов"
                    dialogAndroid.open();
                }
                else
                if(settingScreentextFieldFamily.text.length<2) {
                    dialogAndroidTextLabel.text = "Фамилия менее 2 символов"
                    dialogAndroid.open();
                }
                else
                if(settingScreentextFieldPass.text.length < 5) {
                    dialogAndroidTextLabel.text = "Пароль короче 5 символов"
                    dialogAndroid.open();
                }
                else
                if(settingScreentextFieldPhone.text.length<11) {
                    dialogAndroidTextLabel.text = "Укажите корректный номер"
                    dialogAndroid.open();
                }
                else
                if(settingScreentextFieldPassRepeat.text!=settingScreentextFieldPass.text) {
                    dialogAndroidTextLabel.text = "Ваши пароли не совпадают"
                    dialogAndroid.open();
                }
                else {
                    busyIndicatorMainScreen.visible = true
                    if(true) {
                        dialogAndroidTextLabel.text = "Изменения успешно сохранены"
                        event_handler.setFamily(settingScreentextFieldFamily.text)
                        event_handler.setPhone(settingScreentextFieldPhone.text)
                        event_handler.setLogin(settingScreentextFieldLogin.text)
                        event_handler.setMail(settingScreentextFieldEmail.text)
                        event_handler.setPass(settingScreentextFieldPass.text)
                        dialogAndroid.open();
                        busyIndicatorMainScreen.visible = false
                    }
                    else {
                        dialogAndroidTextLabel.text="Не удалось связаться с сервером"
                        busyIndicatorMainScreen.visible = false
                        dialogAndroid.open();
                    }
                }
            }

            background: Rectangle {
                    color: settingScreenButtonRegister.down ? "#9610387E":"#10387E"
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

        Image {
            id: settingScreenNavbarMenu
            x: 0
            anchors.topMargin: 0
            anchors.top: parent.top
            source: "ui/navbarMenu.png"

            anchors.left: parent.left
            anchors.right: parent.right
            height: (parent.height > 900)? sourceSize.height * parent.height/900: sourceSize.height

            Button {
                id: settingScreenNavbarButton
                x: 20
                width: 80
                height: 48
                y: settingScreenNavbarMenu.height/2 - settingDrawerButton.height / 2

                background: Rectangle {
                    opacity: 0
                }

                onClicked: {
                    settingScreenDrawer.open()
                }

                Image {
                    id: settingDrawerButton
                    anchors.fill: parent
                    source: "ui/drawerButton.png"
                    fillMode: Image.PreserveAspectFit
                }
            }
        }
    }
    //-------------------------------------------------------------------------------------------------------------
}
