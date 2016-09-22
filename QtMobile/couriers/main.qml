import QtQuick 2.7
import QtQuick.Layouts 1.0
import QtQuick.Dialogs 1.2
import QtQuick.Controls 2.0
//import couriers.EventHandler 1.0

Item {
    id: rootmain
    visible: true
    /*
    EventHandler {
        id: event_handler
    }
    */

    //http://doc.qt.io/qt-5/qtquickcontrols2-customize.html

    //--------------------------------------------------dialogAndroid----------------------------------------------
    Dialog {
        id: dialogAndroid

        /* */
        width: rootmain.width-40 // Задаём ширину диалога, работает на десктопе, но не на Android
        height:rootmain.height/2 // Задаём высоту диалога, работает на декстопе, но не на Android
        /* */

        // Создаём содержимое диалогового окна
        contentItem: Rectangle {
            color: "#f7f7f7"     // Задаём цвет
            width: rootmain.width-40 // Устанавливаем ширину, необходимо для Android - устройства
            height:rootmain.height/2 // Устанавливаем высоту, необходимо для Android - устройства

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

                    onClicked: dialogAndroid.close()// По нажатию кнопки закрываем диалог
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
                source: "ui/background.png"
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


    //--------------------------------------------------mainScreen.qml---------------------------------------------
    Item {
        visible:false
        id: mainScreen
        anchors.fill: parent

        property alias textFieldPass: textFieldPass
        property alias textFieldLogin: textFieldLogin

        RowLayout {
            anchors.fill: parent
            id: mainScreenRowLayout

            Image {
                anchors.fill: parent
                source: "ui/background.png"
            }
        }

        Drawer {
            dragMargin: 20
            height: rootmain.height
            id: mainScreenDrawer
            width: 0.75 * rootmain.width

            background: Rectangle {
                color: "#337CFD"
            }

            Button {
                id: mainScreenDrawerButtonExit
                x: 0
                y: 80
                height: 80
                text: qsTr("Выйти")

                font.pointSize: 24

                anchors.left: parent.left
                anchors.right: parent.right

                background: Rectangle {
                        color: mainScreenDrawerButtonExit.down ? "#10387E" : "#337CFD"
                }
                contentItem: Text {
                        text: mainScreenDrawerButtonExit.text
                        font: mainScreenDrawerButtonExit.font
                        opacity: enabled ? 1.0 : 0.3
                        color: mainScreenDrawerButtonExit.down ? "#FFFFFF" : "#FFFFFF"
                        padding: 10
                        verticalAlignment: Text.AlignVCenter
                        elide: Text.ElideRight
                }
                onClicked: {
                    Qt.quit()
                }
            }

            Rectangle { // ебаное нижнее подчеркивание. Ага, оно делается вот блять так!
                x: 0
                y: mainScreenDrawerButtonExit.y + mainScreenDrawerButtonExit.height
                width: parent.width
                height: 1
                border.width: 1
            }
        }

        Button {
            id: mainScreenButtonLogin
            x: 236
            y: 303
            height: 48
            text: qsTr("Войти в систему")
            autoRepeat: false
            autoExclusive: false
            checked: false
            checkable: false
            highlighted: false

            font.pointSize: 20

            anchors.left: mainScreenRowLayout.left
            anchors.right: mainScreenRowLayout.right
            anchors.leftMargin: 0.09 * mainScreenRowLayout.width
            anchors.rightMargin: 0.09 * mainScreenRowLayout.width


            onClicked: {
                if(textFieldLogin.text.length<2) {
                    dialogAndroidTextLabel.text = "Логин короче 2 символов"
                    dialogAndroid.open();
                }
                else
                if(textFieldPass.text.length<5) {
                    dialogAndroidTextLabel.text = "Пароль короче 5 символов"
                    dialogAndroid.open();
                }
                else {
                    mainScreen.visible= false
                    busyIndicatorMainScreen.visible = true
                    if(event_handler.network_login(textFieldLogin.text,textFieldPass.text)) {
                        if(mainScreencheckBoxRememberMe.checked)
                            event_handler.savingToFile(textFieldLogin.text,textFieldPass.text);
                        firstScreen.visible= true
                    }
                    else {
                        dialogAndroidTextLabel.text= "Вы не зарегистрированы"
                        mainScreen.visible = true
                        dialogAndroid.open();
                    }
                    busyIndicatorMainScreen.visible = false
                }
            }

            background: Rectangle {
                    color: mainScreenButtonLogin.down ? "#10387E" : "#337CFD"
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
            id: textFieldLogin
            x: 69
            y: 134
            height: 44
            placeholderText: qsTr("8XXX-XXX-XXXX")

            font.pointSize: 24

            anchors.left: mainScreenRowLayout.left
            anchors.right: mainScreenRowLayout.right
            anchors.leftMargin: 0.09 * mainScreenRowLayout.width
            anchors.rightMargin: 0.09 * mainScreenRowLayout.width

            background: Rectangle {
                border.color: "#0066FF"
                color: "#80FFFFFF"
                border.width: 1
            }

            horizontalAlignment: Text.AlignHCenter
        }

        TextField {
            id: textFieldPass
            x: 69
            y: 191
            width: 250
            height: 44
            placeholderText: qsTr("Введите пароль")

            font.pointSize: 24

            echoMode: TextInput.Password
            anchors.left: mainScreenRowLayout.left
            anchors.right: mainScreenRowLayout.right
            anchors.leftMargin: 0.09 * mainScreenRowLayout.width
            anchors.rightMargin: 0.09 * mainScreenRowLayout.width

            background: Rectangle {
                border.color: "#0066FF"
                color: "#80FFFFFF"
                border.width: 1
            }

            horizontalAlignment: Text.AlignHCenter
        }

        CheckBox {
            id: mainScreencheckBoxRememberMe
            x: 69
            y: 241
            width: 250
            height: 48
            text: qsTr("Запомнить меня")

            font.pointSize: 24

            anchors.left: mainScreenRowLayout.left
            anchors.right: mainScreenRowLayout.right
            anchors.leftMargin: 0.09 * mainScreenRowLayout.width
            anchors.rightMargin: 0.09 * mainScreenRowLayout.width
            spacing: 8
            leftPadding: 0

            indicator: Rectangle {
                    implicitWidth: 26
                    implicitHeight: 26
                    x: mainScreencheckBoxRememberMe.leftPadding
                    y: parent.height / 2 - height / 2
                    radius: 3
                    border.color: mainScreencheckBoxRememberMe.down ? "#10387E" : "#337CFD"

                    Rectangle {
                        width: 18
                        height: 18
                        x: 4
                        y: 4
                        radius: 2
                        color: mainScreencheckBoxRememberMe.down ? "#10387E" : "#337CFD"
                        visible: mainScreencheckBoxRememberMe.checked
                    }
                }

            contentItem: Text {
                    text: mainScreencheckBoxRememberMe.text
                    font: mainScreencheckBoxRememberMe.font
                    opacity: enabled ? 1.0 : 0.3
                    color: mainScreencheckBoxRememberMe.down ? "#10387E" : "#337CFD"
                    verticalAlignment: Text.AlignVCenter
                    leftPadding: mainScreencheckBoxRememberMe.indicator.width + mainScreencheckBoxRememberMe.spacing
                }
        }

        Button {
            id: mainScreenLabelForgotPass
            x: 69
            y: 365
            text: qsTr("Забыли пароль?")

            font.pointSize: 20

            font.underline: true
            anchors.left: mainScreenRowLayout.left
            anchors.right: mainScreenRowLayout.right
            anchors.leftMargin: 0.09 * mainScreenRowLayout.width
            anchors.rightMargin: 0.09 * mainScreenRowLayout.width

            background: Rectangle {
                opacity: 0
            }
            contentItem: Text {
                text: mainScreenLabelForgotPass.text
                font: mainScreenLabelForgotPass.font
                opacity: enabled ? 1.0 : 0.3
                color: mainScreenLabelForgotPass.down ? "#0094FF" : "#26282A"
                padding: -8
                verticalAlignment: Text.AlignVCenter
                elide: Text.ElideRight
            }
        }

        Button {
            id: mainScreenLabelCreateAcc
            x: 69
            y: 409
            text: qsTr("Создать аккаунт?")

            font.pointSize: 20

            font.underline: true
            anchors.left: mainScreenRowLayout.left
            anchors.right: mainScreenRowLayout.right
            anchors.leftMargin: 0.09 * mainScreenRowLayout.width
            anchors.rightMargin: 0.09 * mainScreenRowLayout.width

            background: Rectangle {
                opacity: 0
            }
            contentItem: Text {
                text: mainScreenLabelCreateAcc.text
                font: mainScreenLabelCreateAcc.font
                opacity: enabled ? 1.0 : 0.3
                color: mainScreenLabelCreateAcc.down ? "#0094FF" : "#26282A"
                padding: -8
                verticalAlignment:Text.AlignVCenter
                elide: Text.ElideRight
            }
            onClicked: {
                mainScreen.visible=false
                registScreen.visible=true
            }
        }
    }
    //-------------------------------------------------------------------------------------------------------------


    //--------------------------------------------------firstScreen.qml--------------------------------------------
    Item {
        visible:true
        id: firstScreen
        anchors.fill: parent

        RowLayout {
            anchors.fill: parent
            id: firstScreenRowLayout

            Image {
                anchors.fill: parent
                source: "ui/background.png"
            }
        }

        Drawer {
            dragMargin: 20
            height: rootmain.height
            id: firstScreenDrawer
            width: 0.75 * rootmain.width

            background: Rectangle {
                color: "#337CFD"
            }

            Button {
                id: firstScreenDrawerButtonMySettings
                x: 0
                y: 80
                height: 80
                text: qsTr("Мои настройки")

                font.pointSize: 24

                anchors.left: parent.left
                anchors.right: parent.right

                background: Rectangle {
                        color: firstScreenDrawerButtonMySettings.down ? "#10387E" : "#337CFD"
                }
                contentItem: Text {
                        text: firstScreenDrawerButtonMySettings.text
                        font: firstScreenDrawerButtonMySettings.font
                        opacity: enabled ? 1.0 : 0.3
                        color: firstScreenDrawerButtonMySettings.down ? "#FFFFFF" : "#FFFFFF"
                        padding: 10
                        verticalAlignment: Text.AlignVCenter
                        elide: Text.ElideRight
                }
            }

            Button {
                id: firstScreenDrawerButtonMyAddverts
                x: 0
                y: 159
                height: 80
                text: qsTr("Мои объявления")

                font.pointSize: 24

                anchors.left: parent.left
                anchors.right: parent.right

                background: Rectangle {
                        color: firstScreenDrawerButtonMyAddverts.down ? "#10387E" : "#337CFD"
                }
                contentItem: Text {
                        text: firstScreenDrawerButtonMyAddverts.text
                        font: firstScreenDrawerButtonMyAddverts.font
                        opacity: enabled ? 1.0 : 0.3
                        color: firstScreenDrawerButtonMyAddverts.down ? "#FFFFFF" : "#FFFFFF"
                        padding: 10
                        verticalAlignment: Text.AlignVCenter
                        elide: Text.ElideRight
                }
            }

            Button {
                id: firstScreenDrawerButtonMyStatus
                x: 0
                y: 238
                height: 80
                text: qsTr("Мой статус")

                font.pointSize: 24

                anchors.left: parent.left
                anchors.right: parent.right

                background: Rectangle {
                        color: firstScreenDrawerButtonMyStatus.down ? "#10387E" : "#337CFD"
                }

                contentItem: Text {
                        text: firstScreenDrawerButtonMyStatus.text
                        font: firstScreenDrawerButtonMyStatus.font
                        opacity: enabled ? 1.0 : 0.3
                        color: firstScreenDrawerButtonMyStatus.down ? "#FFFFFF" : "#FFFFFF"
                        padding: 10
                        verticalAlignment: Text.AlignVCenter
                        elide: Text.ElideRight
                }

                onClicked: {
                    firstScreenDrawer.close()
                    firstScreen.visible=false
                    statusScreen.visible=true
                }
            }

            Button {
                id: firstScreenDrawerButtonFindAdverts
                x: 0
                y: 317
                height: 80
                text: qsTr("Найти объявление")

                font.pointSize: 24

                anchors.left: parent.left
                anchors.right: parent.right

                background: Rectangle {
                        color: firstScreenDrawerButtonFindAdverts.down ? "#10387E" : "#337CFD"
                }
                contentItem: Text {
                        text: firstScreenDrawerButtonFindAdverts.text
                        font: firstScreenDrawerButtonFindAdverts.font
                        opacity: enabled ? 1.0 : 0.3
                        color: firstScreenDrawerButtonFindAdverts.down ? "#FFFFFF" : "#FFFFFF"
                        padding: 10
                        verticalAlignment: Text.AlignVCenter
                        elide: Text.ElideRight
                }
            }

            Button {
                id: firstScreenDrawerButtonExit
                x: 0
                y: 396
                height: 80
                text: qsTr("Выйти")

                font.pointSize: 24

                anchors.left: parent.left
                anchors.right: parent.right

                background: Rectangle {
                        color: firstScreenDrawerButtonExit.down ? "#10387E" : "#337CFD"
                }
                contentItem: Text {
                        text: firstScreenDrawerButtonExit.text
                        font: firstScreenDrawerButtonExit.font
                        opacity: enabled ? 1.0 : 0.3
                        color: firstScreenDrawerButtonExit.down ? "#FFFFFF" : "#FFFFFF"
                        padding: 10
                        verticalAlignment: Text.AlignVCenter
                        elide: Text.ElideRight
                }
                onClicked: {
                    event_handler.exitMenu()
                    mainScreen.visible=true
                    firstScreen.visible=false
                    firstScreenDrawer.close()
                }
            }

            Rectangle { // ебаное нижнее подчеркивание. Ага, оно делается вот блять так!
                x: 0
                y: firstScreenDrawerButtonExit.y + firstScreenDrawerButtonExit.height
                width: parent.width
                height: 1
                border.width: 1
            }
            Rectangle { // ебаное нижнее подчеркивание. Ага, оно делается вот блять так!
                x: 0
                y: firstScreenDrawerButtonMyStatus.y + firstScreenDrawerButtonMyStatus.height
                width: parent.width
                height: 1
                border.width: 1
            }
            Rectangle { // ебаное нижнее подчеркивание. Ага, оно делается вот блять так!
                x: 0
                y: firstScreenDrawerButtonMyAddverts.y + firstScreenDrawerButtonMyAddverts.height
                width: parent.width
                height: 1
                border.width: 1
            }
            Rectangle { // ебаное нижнее подчеркивание. Ага, оно делается вот блять так!
                x: 0
                y: firstScreenDrawerButtonMySettings.y + firstScreenDrawerButtonMySettings.height
                width: parent.width
                height: 1
                border.width: 1
            }
            Rectangle { // ебаное нижнее подчеркивание. Ага, оно делается вот блять так!
                x: 0
                y: firstScreenDrawerButtonFindAdverts.y + firstScreenDrawerButtonFindAdverts.height
                width: parent.width
                height: 1
                border.width: 1
            }
        }

        Image {
            id: firstScreenNavbarMenu
            x: 0
            height: 59
            anchors.topMargin: 0
            anchors.top: parent.top
            source: "ui/navbarMenu.png"

            anchors.left: parent.left
            anchors.right: parent.right

            Button {
                id: firstScreenNavbarButton
                x: 20
                y: 11
                width: 53
                height: 40
                background: Rectangle {
                    opacity: 0
                }

                onClicked: {
                    firstScreenDrawer.open()
                }

                Image {
                    anchors.fill: parent
                    source: "ui/iselect.png"
                    fillMode: Image.Tile
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

        RowLayout {
            anchors.fill: parent
            id: statusScreenRowLayout

            Image {
                anchors.fill: parent
                source: "ui/background.png"
            }
        }

        Drawer {
            dragMargin: 20
            height: rootmain.height
            id: statusScreenDrawer
            width: 0.75 * rootmain.width

            background: Rectangle {
                color: "#337CFD"
            }

            Button {
                id: statusScreenDrawerButtonMySettings
                x: 0
                y: 80
                height: 80
                text: qsTr("Мои настройки")

                font.pointSize: 24

                anchors.left: parent.left
                anchors.right: parent.right

                background: Rectangle {
                        color: statusScreenDrawerButtonMySettings.down ? "#10387E" : "#337CFD"
                }
                contentItem: Text {
                        text: statusScreenDrawerButtonMySettings.text
                        font: statusScreenDrawerButtonMySettings.font
                        opacity: enabled ? 1.0 : 0.3
                        color: statusScreenDrawerButtonMySettings.down ? "#FFFFFF" : "#FFFFFF"
                        padding: 10
                        verticalAlignment: Text.AlignVCenter
                        elide: Text.ElideRight
                }
            }

            Button {
                id: statusScreenDrawerButtonMyAddverts
                x: 0
                y: 159
                height: 80
                text: qsTr("Мои объявления")

                font.pointSize: 24

                anchors.left: parent.left
                anchors.right: parent.right

                background: Rectangle {
                        color: statusScreenDrawerButtonMyAddverts.down ? "#10387E" : "#337CFD"
                }
                contentItem: Text {
                        text: statusScreenDrawerButtonMyAddverts.text
                        font: statusScreenDrawerButtonMyAddverts.font
                        opacity: enabled ? 1.0 : 0.3
                        color: statusScreenDrawerButtonMyAddverts.down ? "#FFFFFF" : "#FFFFFF"
                        padding: 10
                        verticalAlignment: Text.AlignVCenter
                        elide: Text.ElideRight
                }
            }

            Button {
                id: statusScreenDrawerButtonMyStatus
                x: 0
                y: 238
                height: 80
                text: qsTr("Мой статус")

                font.pointSize: 24

                anchors.left: parent.left
                anchors.right: parent.right

                background: Rectangle {
                        color: statusScreenDrawerButtonMyStatus.down ? "#10387E" : "#337CFD"
                }

                contentItem: Text {
                        text: statusScreenDrawerButtonMyStatus.text
                        font: statusScreenDrawerButtonMyStatus.font
                        opacity: enabled ? 1.0 : 0.3
                        color: statusScreenDrawerButtonMyStatus.down ? "#FFFFFF" : "#FFFFFF"
                        padding: 10
                        verticalAlignment: Text.AlignVCenter
                        elide: Text.ElideRight
                }

                onClicked: {
                    statusScreenDrawer.close()
                }
            }

            Button {
                id: statusScreenDrawerButtonFindAdverts
                x: 0
                y: 317
                height: 80
                text: qsTr("Найти объявление")

                font.pointSize: 24

                anchors.left: parent.left
                anchors.right: parent.right

                background: Rectangle {
                        color: statusScreenDrawerButtonFindAdverts.down ? "#10387E" : "#337CFD"
                }
                contentItem: Text {
                        text: statusScreenDrawerButtonFindAdverts.text
                        font: statusScreenDrawerButtonFindAdverts.font
                        opacity: enabled ? 1.0 : 0.3
                        color: statusScreenDrawerButtonFindAdverts.down ? "#FFFFFF" : "#FFFFFF"
                        padding: 10
                        verticalAlignment: Text.AlignVCenter
                        elide: Text.ElideRight
                }
            }

            Button {
                id: statusScreenDrawerButtonExit
                x: 0
                y: 396
                height: 80
                text: qsTr("Выйти")

                font.pointSize: 24

                anchors.left: parent.left
                anchors.right: parent.right

                background: Rectangle {
                        color: statusScreenDrawerButtonExit.down ? "#10387E" : "#337CFD"
                }
                contentItem: Text {
                        text: statusScreenDrawerButtonExit.text
                        font: statusScreenDrawerButtonExit.font
                        opacity: enabled ? 1.0 : 0.3
                        color: statusScreenDrawerButtonExit.down ? "#FFFFFF" : "#FFFFFF"
                        padding: 10
                        verticalAlignment: Text.AlignVCenter
                        elide: Text.ElideRight
                }
                onClicked: {
                    event_handler.exitMenu()
                    mainScreen.visible=true
                    statusScreen.visible=false
                    statusScreenDrawer.close()
                }
            }

            Rectangle { // ебаное нижнее подчеркивание. Ага, оно делается вот блять так!
                x: 0
                y: statusScreenDrawerButtonExit.y + statusScreenDrawerButtonExit.height
                width: parent.width
                height: 1
                border.width: 1
            }
            Rectangle { // ебаное нижнее подчеркивание. Ага, оно делается вот блять так!
                x: 0
                y: statusScreenDrawerButtonMyStatus.y + statusScreenDrawerButtonMyStatus.height
                width: parent.width
                height: 1
                border.width: 1
            }
            Rectangle { // ебаное нижнее подчеркивание. Ага, оно делается вот блять так!
                x: 0
                y: statusScreenDrawerButtonFindAdverts.y + statusScreenDrawerButtonFindAdverts.height
                width: parent.width
                height: 1
                border.width: 1
            }
            Rectangle { // ебаное нижнее подчеркивание. Ага, оно делается вот блять так!
                x: 0
                y: statusScreenDrawerButtonMyAddverts.y + statusScreenDrawerButtonMyAddverts.height
                width: parent.width
                height: 1
                border.width: 1
            }
            Rectangle { // ебаное нижнее подчеркивание. Ага, оно делается вот блять так!
                x: 0
                y: statusScreenDrawerButtonMySettings.y + statusScreenDrawerButtonMySettings.height
                width: parent.width
                height: 1
                border.width: 1
            }
        }

        Image {
            id: statusScreenNavbarManu
            x: 0
            height: 59
            anchors.topMargin: 0
            anchors.top: parent.top
            source: "ui/navbarMenu.png"

            anchors.left: parent.left
            anchors.right: parent.right

            Button {
                id: statusScreenNavbarButton
                x: 20
                y: 11
                width: 53
                height: 40
                background: Rectangle {
                    opacity: 0
                }

                onClicked: {
                    statusScreenDrawer.open()
                }

                Image {
                    anchors.fill: parent
                    source: "ui/iselect.png"
                    fillMode: Image.Tile
                }
            }
        }

        Switch {
            id: statusScreenSwitchBusy
            x: 221
            y: 111
            width: 200
            height: 59
            text: qsTr("Занят")

            font.pointSize: 20

            anchors.left: statusScreenRowLayout.left
            anchors.right: statusScreenRowLayout.right
            anchors.leftMargin: 0.09 * statusScreenRowLayout.width
            anchors.rightMargin: 0.09 * statusScreenRowLayout.width

            onClicked: {
                statusScreenSwitchFree.checked=false
                statusScreenSwitchDoOrder.checked=false
                statusScreenSwitchDeparted.checked=false
            }
        }

        Switch {
            id: statusScreenSwitchFree
            x: 221
            y: 211
            width: 200
            height: 59
            text: qsTr("Свободен")

            font.pointSize: 20

            anchors.left: statusScreenRowLayout.left
            anchors.right: statusScreenRowLayout.right
            anchors.leftMargin: 0.09 * statusScreenRowLayout.width
            anchors.rightMargin: 0.09 * statusScreenRowLayout.width

            onClicked: {
                statusScreenSwitchBusy.checked=false
                statusScreenSwitchDoOrder.checked=false
                statusScreenSwitchDeparted.checked=false
            }
        }

        Switch {
            id: statusScreenSwitchDeparted
            x: 221
            y: 311
            width: 200
            height: 59
            text: qsTr("Отошел")

            font.pointSize: 20

            anchors.left: statusScreenRowLayout.left
            anchors.right: statusScreenRowLayout.right
            anchors.leftMargin: 0.09 * statusScreenRowLayout.width
            anchors.rightMargin: 0.09 * statusScreenRowLayout.width

            onClicked: {
                statusScreenSwitchBusy.checked=false
                statusScreenSwitchFree.checked=false
                statusScreenSwitchDoOrder.checked=false
            }
        }

        Switch {
            id: statusScreenSwitchDoOrder
            x: 221
            y: 411
            width: 200
            height: 100
            text: qsTr("Выполняю заказ\nID = 54975")

            font.pointSize: 20

            anchors.left: statusScreenRowLayout.left
            anchors.right: statusScreenRowLayout.right
            anchors.leftMargin: 0.09 * statusScreenRowLayout.width
            anchors.rightMargin: 0.09 * statusScreenRowLayout.width

            onClicked: {
                statusScreenSwitchBusy.checked=false
                statusScreenSwitchFree.checked=false
                statusScreenSwitchDeparted.checked=false
            }
        }
    }
    //-------------------------------------------------------------------------------------------------------------


    //--------------------------------------------------registScreen.qml-------------------------------------------
    Item {
        visible:false
        id: registScreen
        anchors.fill: parent

        RowLayout {
            anchors.fill: parent
            id: registScreenRowLayout

            Image {
                anchors.fill: parent
                source: "ui/background.png"
            }
        }

        TextField {
            id: registScreentextFieldLogin
            x: 69
            y: 100
            width: 250
            height: 44
            placeholderText: qsTr("Придумай логин")

            font.pointSize: 24

            anchors.left: registScreenRowLayout.left
            anchors.right: registScreenRowLayout.right
            anchors.leftMargin: 0.09 * registScreenRowLayout.width
            anchors.rightMargin: 0.09 * registScreenRowLayout.width

            background: Rectangle {
                border.color: "#0066FF"
                color: "#80FFFFFF"
                border.width: 1
            }

            horizontalAlignment: Text.AlignHCenter
        }

        TextField {
            id: registScreentextFieldPass
            x: 69
            y: 170
            width: 250
            height: 44
            placeholderText: qsTr("Придумай пароль")

            font.pointSize: 24

            echoMode: TextInput.Password
            anchors.left: registScreenRowLayout.left
            anchors.right: registScreenRowLayout.right
            anchors.leftMargin: 0.09 * registScreenRowLayout.width
            anchors.rightMargin: 0.09 * registScreenRowLayout.width

            background: Rectangle {
                border.color: "#0066FF"
                color: "#80FFFFFF"
                border.width: 1
            }

            horizontalAlignment: Text.AlignHCenter
        }

        TextField {
            id: registScreentextFieldPassRepeat
            x: 69
            y: 220
            width: 250
            height: 44
            placeholderText: qsTr("Повторите пароль")

            font.pointSize: 24

            echoMode: TextInput.Password
            anchors.left: registScreenRowLayout.left
            anchors.right: registScreenRowLayout.right
            anchors.leftMargin: 0.09 * registScreenRowLayout.width
            anchors.rightMargin: 0.09 * registScreenRowLayout.width

            background: Rectangle {
                border.color: "#0066FF"
                color: "#80FFFFFF"
                border.width: 1
            }

            horizontalAlignment: Text.AlignHCenter
        }

        TextField {
            id: registScreentextFieldEmail
            x: 69
            y: 290
            width: 250
            height: 44
            placeholderText: qsTr("Введите свой EMail")

            font.pointSize: 24

            anchors.left: registScreenRowLayout.left
            anchors.right: registScreenRowLayout.right
            anchors.leftMargin: 0.09 * registScreenRowLayout.width
            anchors.rightMargin: 0.09 * registScreenRowLayout.width

            background: Rectangle {
                border.color: "#0066FF"
                color: "#80FFFFFF"
                border.width: 1
            }

            horizontalAlignment: Text.AlignHCenter
        }

        TextField {
            id: registScreentextFieldPhone
            x: 69
            y: 340
            width: 250
            height: 44
            placeholderText: qsTr("+7-XXX-XXX-XX-XX")

            font.pointSize: 24

            anchors.left: registScreenRowLayout.left
            anchors.right: registScreenRowLayout.right
            anchors.leftMargin: 0.09 * registScreenRowLayout.width
            anchors.rightMargin: 0.09 * registScreenRowLayout.width

            background: Rectangle {
                border.color: "#0066FF"
                color: "#80FFFFFF"
                border.width: 1
            }

            horizontalAlignment: Text.AlignHCenter
        }

        ComboBox {
            id: registScreencomboBoxCitys
            y: 410
            width: 250
            height: 44
            font.pointSize: 24

            model: [ "Нигда", "Питер", "Москва" ]

            anchors.left: registScreenRowLayout.left
            anchors.right: registScreenRowLayout.right
            anchors.leftMargin: 0.09 * registScreenRowLayout.width
            anchors.rightMargin: 0.09 * registScreenRowLayout.width
        }

        Button {
            id: registScreenButtonRegister
            x: 236
            y: 500
            height: 60
            text: qsTr("Зарегистрироваться")
            autoRepeat: false
            autoExclusive: false
            checked: false
            checkable: false
            highlighted: false

            font.pointSize: 30

            anchors.left: registScreenRowLayout.left
            anchors.right: registScreenRowLayout.right
            anchors.leftMargin: 0.09 * registScreenRowLayout.width
            anchors.rightMargin: 0.09 * registScreenRowLayout.width


            onClicked: {
                if(registScreentextFieldLogin.text.length<2) {
                    dialogAndroidTextLabel.text = "Логин короче 2 символов"
                    dialogAndroid.open();
                }
                else
                if(registScreentextFieldPass.text.length<5) {
                    dialogAndroidTextLabel.text = "Пароль короче 5 символов"
                    dialogAndroid.open();
                }
                else
                if(registScreentextFieldPassRepeat.text!=registScreentextFieldPass.text) {
                    dialogAndroidTextLabel.text = "Пароли не совпадают"
                    dialogAndroid.open();
                }
                else
                if(registScreentextFieldPhone.text.length<11) {
                    dialogAndroidTextLabel.text = "Укажите верный номер телефона"
                    dialogAndroid.open();
                }
                else {
                    if(event_handler.registration(registScreentextFieldLogin.text,registScreentextFieldPass.text,registScreentextFieldPassRepeat.text,registScreentextFieldEmail.text,registScreentextFieldPhone.text,registScreencomboBoxCitys.currentText)) {
                        registScreen.visible=false
                        dialogAndroidTextLabel.text="Вы успешно зарегистрированы"
                        dialogAndroid.open();
                        firstScreen.visible = true
                    }
                    else {
                        dialogAndroidTextLabel.text="Вы уже зарегистрированы"
                        dialogAndroid.open();
                    }
                }
            }

            background: Rectangle {
                    color: registScreenButtonRegister.down ? "#10387E" : "#337CFD"
            }

            contentItem: Text {
                    text: registScreenButtonRegister.text
                    font: registScreenButtonRegister.font
                    opacity: enabled ? 1.0 : 0.3
                    color: registScreenButtonRegister.down ? "#FFFFFF" : "#FFFFFF"
                    horizontalAlignment:Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    elide: Text.ElideRight
            }
        }

        Drawer {
            dragMargin: 20
            height: rootmain.height
            id: registScreenDrawer
            width: 0.75 * rootmain.width

            background: Rectangle {
                color: "#337CFD"
            }

            Button {
                id: registScreenDrawerButtonMySettings
                x: 0
                y: 80
                height: 80
                text: qsTr("Мои настройки")

                font.pointSize: 24

                anchors.left: parent.left
                anchors.right: parent.right

                background: Rectangle {
                        color: registScreenDrawerButtonMySettings.down ? "#10387E" : "#337CFD"
                }
                contentItem: Text {
                        text: registScreenDrawerButtonMySettings.text
                        font: registScreenDrawerButtonMySettings.font
                        opacity: enabled ? 1.0 : 0.3
                        color: registScreenDrawerButtonMySettings.down ? "#FFFFFF" : "#FFFFFF"
                        padding: 10
                        verticalAlignment: Text.AlignVCenter
                        elide: Text.ElideRight
                }
            }

            Button {
                id: registScreenDrawerButtonExit
                x: 0
                y: 159
                height: 80
                text: qsTr("Назад")

                font.pointSize: 24

                anchors.left: parent.left
                anchors.right: parent.right

                background: Rectangle {
                        color: registScreenDrawerButtonExit.down ? "#10387E" : "#337CFD"
                }
                contentItem: Text {
                        text: registScreenDrawerButtonExit.text
                        font: registScreenDrawerButtonExit.font
                        opacity: enabled ? 1.0 : 0.3
                        color: registScreenDrawerButtonExit.down ? "#FFFFFF" : "#FFFFFF"
                        padding: 10
                        verticalAlignment: Text.AlignVCenter
                        elide: Text.ElideRight
                }
                onClicked: {
                    mainScreen.visible=true
                    registScreen.visible=false
                    registScreenDrawer.close()
                }
            }

            Rectangle { // ебаное нижнее подчеркивание. Ага, оно делается вот блять так!
                x: 0
                y: registScreenDrawerButtonExit.y + registScreenDrawerButtonExit.height
                width: parent.width
                height: 1
                border.width: 1
            }
            Rectangle { // ебаное нижнее подчеркивание. Ага, оно делается вот блять так!
                x: 0
                y: registScreenDrawerButtonMySettings.y + registScreenDrawerButtonMySettings.height
                width: parent.width
                height: 1
                border.width: 1
            }
        }

        Image {
            id: registScreenNavbarMenu
            x: 0
            height: 59
            anchors.topMargin: 0
            anchors.top: parent.top
            source: "ui/navbarMenu.png"

            anchors.left: parent.left
            anchors.right: parent.right

            Button {
                id: registScreenNavbarButton
                x: 20
                y: 11
                width: 53
                height: 40
                background: Rectangle {
                    opacity: 0
                }

                onClicked: {
                    registScreenDrawer.open()
                }

                Image {
                    anchors.fill: parent
                    source: "ui/iselect.png"
                    fillMode: Image.Tile
                }
            }
        }
    }
    //-------------------------------------------------------------------------------------------------------------
}
