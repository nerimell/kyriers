import QtQuick 2.7
import QtQuick.Layouts 1.0
import QtQuick.Dialogs 1.2
import QtQuick.Controls 2.0
import "CourierStyle" as CourierStyle

Item {
    id: rootPin
    anchors.fill: parent

    Timer {
        id: pinerScreenTimer
        interval:2000;
        onTriggered:checkWiFiConnection()
    }

    Component.onCompleted: {
        if(event_handler.isPined())
        if(!event_handler.pinConnected())
            pinerScreenTimer.start()
    }

    function checkWiFiConnection(){
        if(!event_handler.pinConnected())
        {
            dialogAndroid.text = "Нет доступа к интернету"
            dialogAndroid.visible=true;
        }
    }

    Item {
        visible: true
        id: pinScreen
        anchors.fill: parent

        Rectangle {
            color: "#5DA7EF"
            anchors.fill: parent
        }

        Image {
            id: imagelogo
            x: parent.width/2-imagelogo.width/2
            y: 0.1*pinScreen.height
            width: (parent.width<500)?sourceSize.width/1.5 * parent.width/500: sourceSize.width/1.5
            height: (parent.width<500)?sourceSize.height/1.5 * parent.width/500: sourceSize.height/1.5
            source: "ui/mainlogo.png"
        }

        Text {
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.leftMargin: parent.width / 2 - facade.toPx(100)
            anchors.rightMargin: parent.width/ 2 - facade.toPx(100)

            font.pointSize: facade.toPx(14)
            font.family: sfuiFont.name
            color: "#FFFFFF"
            y: 0.4*parent.height
            horizontalAlignment: Text.AlignHCenter

            text: "Введите код"
        }

        RowLayout {
            id: rowLayout0
            spacing: 80

            anchors.top: parent.top
            anchors.topMargin: 0.48 * parent.height
            x: parent.width / 2 - (pinSquare1.width + spacing) - spacing + pinSquare1.width

            Rectangle {
                id: pinSquare1
                border.width: 1
                color: "#40FFFFFF"
                border.color: "#FFFFFF"
                width: 20
                height: 20
                radius: 20
                Rectangle { // ебаное нижнее подчеркивание. Ага, оно делается вот блять так!
                    id: underlineCircle
                    x: pinSquare1.x - 25
                    y: pinSquare1.y + pinSquare1.height + 20
                    width: pinSquare1.width + 50
                    height: 1
                    border.color: "#FFFFFF"
                    border.width: 1
                }
            }

            Rectangle {
                id: pinSquare2
                border.width: 1
                color: "#40FFFFFF"
                border.color: "#FFFFFF"
                width: 20
                height: 20
                radius: 20
                Rectangle { // ебаное нижнее подчеркивание. Ага, оно делается вот блять так!
                    x: pinSquare2.x - (pinSquare1.width + rowLayout0.spacing) - 25
                    y: pinSquare2.y + pinSquare2.height + 20
                    width: underlineCircle.width
                    height: 1
                    border.color: "#FFFFFF"
                    border.width: 1
                }
            }

            Rectangle {
                id: pinSquare3
                border.width: 1
                color: "#40FFFFFF"
                border.color: "#FFFFFF"
                width: 20
                height: 20
                radius: 20
                Rectangle { // ебаное нижнее подчеркивание. Ага, оно делается вот блять так!
                    x: pinSquare3.x - 2*(pinSquare1.width + rowLayout0.spacing) - 25
                    y: pinSquare3.y + pinSquare3.height + 20
                    width: underlineCircle.width
                    height: 1
                    border.color: "#FFFFFF"
                    border.width: 1
                }
            }

            Rectangle {
                id: pinSquare4
                border.width: 1
                color: "#40FFFFFF"
                border.color: "#FFFFFF"
                width: 20
                height: 20
                radius: 20
                Rectangle { // ебаное нижнее подчеркивание. Ага, оно делается вот блять так!
                    x: pinSquare4.x - 3*(pinSquare1.width + rowLayout0.spacing) - 25
                    y: pinSquare4.y + pinSquare4.height + 20
                    width: underlineCircle.width
                    height: 1
                    border.color: "#FFFFFF"
                    border.width: 1
                }
            }
        }

        Grid {
            id: gridLayout1
            columns: 3
            rowSpacing: 0
            columnSpacing: 0
            height: parent.height/2.5

            width: facade.toPx(500)
            x: parent.width/2-gridLayout1.width/2

            anchors.bottom: parent.bottom

            Button {
                id: button1
                text: qsTr("1")
                font.pointSize: facade.toPx(34)
                font.family: comfortFont.name

                height: gridLayout1.height/4-gridLayout1.rowSpacing
                width: gridLayout1.width/3-gridLayout1.columnSpacing

                background: Rectangle {
                    color: button1.down ? "#10387E" : "#5DA7EF"
                }
                contentItem: Text {
                    text: button1.text
                    font: button1.font
                    verticalAlignment: Text.AlignVCenter
                    horizontalAlignment: Text.AlignHCenter
                    color: button1.down ? "#FFFFFF" : "#FFFFFF"
                }
                onClicked: {
                    if(!pinerScreenTimer.running) {
                        event_handler.setMyPin(text)
                        switch(event_handler.pinLength()) {
                        case -1:
                            pinSquare4.color="#FFFFFF"
                            pinScreen.visible = false
                            busyIndicatorScreen.visible = true
                            if(event_handler.networkLogin()) {
                                if(!event_handler.isPined())
                                event_handler.registrationPin(event_handler.getMyPin(),event_handler.getPhone(),event_handler.getPass())
                                loader.source = "qrc:/main.qml"
                            }
                            else {
                                dialogAndroid.text="Аккаунта более нет в базе"
                                pinScreen.visible = true
                                dialogAndroid.visible=true;
                            }
                            busyIndicatorScreen.visible = false
                            break
                        case 1:
                            pinSquare1.color="#FFFFFF"
                            break
                        case 2:
                            pinSquare2.color="#FFFFFF"
                            break
                        case 3:
                            pinSquare3.color="#FFFFFF"
                            break
                        case 4:
                            pinSquare4.color="#FFFFFF"
                            if(event_handler.isPined()) {
                                event_handler.pinIncrement()
                                if(event_handler.getPinInput()<5)
                                    dialogAndroid.text = "Введен не верный пин"
                                else
                                    dialogAndroid.text = "Вы исчерпали лимит попыток"
                                dialogAndroid.visible=true;
                            }
                            else {
                                if(event_handler.getMePins()=="") {
                                    event_handler.setPin(event_handler.getMyPin())
                                    dialogAndroid.text = "Введите пин повторно"
                                }
                                else
                                    dialogAndroid.text = "Пин-коды не совпали!"
                                dialogAndroid.visible=true;
                            }
                            break
                        }
                    }
                }
            }

            Button {
                id: button2
                text: qsTr("2")
                font.pointSize: facade.toPx(34)
                font.family: comfortFont.name

                height: gridLayout1.height/4-gridLayout1.rowSpacing
                width: gridLayout1.width/3-gridLayout1.columnSpacing

                background: Rectangle {
                    color: button2.down ? "#10387E" : "#5DA7EF"
                }
                contentItem: Text {
                    text: button2.text
                    font: button2.font
                    verticalAlignment: Text.AlignVCenter
                    horizontalAlignment: Text.AlignHCenter
                    color: button2.down ? "#FFFFFF" : "#FFFFFF"
                }
                onClicked: {
                    if(!pinerScreenTimer.running) {
                        event_handler.setMyPin(text)
                        switch(event_handler.pinLength()) {
                        case -1:
                            pinSquare4.color="#FFFFFF"
                            pinScreen.visible = false
                            busyIndicatorScreen.visible = true
                            if(event_handler.networkLogin()) {
                                if(!event_handler.isPined())
                                event_handler.registrationPin(event_handler.getMyPin(),event_handler.getPhone(),event_handler.getPass())
                                loader.source = "qrc:/main.qml"
                            }
                            else {
                                dialogAndroid.text="Аккаунта более нет в базе"
                                pinScreen.visible = true
                                dialogAndroid.visible=true;
                            }
                            busyIndicatorScreen.visible = false
                            break
                        case 1:
                            pinSquare1.color="#FFFFFF"
                            break
                        case 2:
                            pinSquare2.color="#FFFFFF"
                            break
                        case 3:
                            pinSquare3.color="#FFFFFF"
                            break
                        case 4:
                            pinSquare4.color="#FFFFFF"
                            if(event_handler.isPined()) {
                                event_handler.pinIncrement()
                                if(event_handler.getPinInput()<5)
                                    dialogAndroid.text = "Введен не верный пин"
                                else
                                    dialogAndroid.text = "Вы исчерпали лимит попыток"
                                dialogAndroid.visible=true;
                            }
                            else {
                                if(event_handler.getMePins()=="") {
                                    event_handler.setPin(event_handler.getMyPin())
                                    dialogAndroid.text = "Введите пин повторно"
                                }
                                else
                                    dialogAndroid.text = "Пин-коды не совпали!"
                                dialogAndroid.visible=true;
                            }
                            break
                        }
                    }
                }
            }

            Button {
                id: button3
                text: qsTr("3")
                font.pointSize: facade.toPx(34)
                font.family: comfortFont.name

                height: gridLayout1.height/4-gridLayout1.rowSpacing
                width: gridLayout1.width/3-gridLayout1.columnSpacing

                background: Rectangle {
                    color: button3.down ? "#10387E" : "#5DA7EF"
                }
                contentItem: Text {
                    text: button3.text
                    font: button3.font
                    verticalAlignment: Text.AlignVCenter
                    horizontalAlignment: Text.AlignHCenter
                    color: button3.down ? "#FFFFFF" : "#FFFFFF"
                }
                onClicked: {
                    if(!pinerScreenTimer.running) {
                        event_handler.setMyPin(text)
                        switch(event_handler.pinLength()) {
                        case -1:
                            pinSquare4.color="#FFFFFF"
                            pinScreen.visible = false
                            busyIndicatorScreen.visible = true
                            if(event_handler.networkLogin()) {
                                if(!event_handler.isPined())
                                event_handler.registrationPin(event_handler.getMyPin(),event_handler.getPhone(),event_handler.getPass())
                                loader.source = "qrc:/main.qml"
                            }
                            else {
                                dialogAndroid.text="Аккаунта более нет в базе"
                                pinScreen.visible = true
                                dialogAndroid.visible=true;
                            }
                            busyIndicatorScreen.visible = false
                            break
                        case 1:
                            pinSquare1.color="#FFFFFF"
                            break
                        case 2:
                            pinSquare2.color="#FFFFFF"
                            break
                        case 3:
                            pinSquare3.color="#FFFFFF"
                            break
                        case 4:
                            pinSquare4.color="#FFFFFF"
                            if(event_handler.isPined()) {
                                event_handler.pinIncrement()
                                if(event_handler.getPinInput()<5)
                                    dialogAndroid.text = "Введен не верный пин"
                                else
                                    dialogAndroid.text = "Вы исчерпали лимит попыток"
                                dialogAndroid.visible=true;
                            }
                            else {
                                if(event_handler.getMePins()=="") {
                                    event_handler.setPin(event_handler.getMyPin())
                                    dialogAndroid.text = "Введите пин повторно"
                                }
                                else
                                    dialogAndroid.text = "Пин-коды не совпали!"
                                dialogAndroid.visible=true;
                            }
                            break
                        }
                    }
                }
            }

            Button {
                id: button4
                text: qsTr("4")
                font.pointSize: facade.toPx(34)
                font.family: comfortFont.name

                height: gridLayout1.height/4-gridLayout1.rowSpacing
                width: gridLayout1.width/3-gridLayout1.columnSpacing

                background: Rectangle {
                    color: button4.down ? "#10387E" : "#5DA7EF"
                }
                contentItem: Text {
                    text: button4.text
                    font: button4.font
                    verticalAlignment: Text.AlignVCenter
                    horizontalAlignment: Text.AlignHCenter
                    color: button4.down ? "#FFFFFF" : "#FFFFFF"
                }
                onClicked: {
                    if(!pinerScreenTimer.running) {
                        event_handler.setMyPin(text)
                        switch(event_handler.pinLength()) {
                        case -1:
                            pinSquare4.color="#FFFFFF"
                            pinScreen.visible = false
                            busyIndicatorScreen.visible = true
                            if(event_handler.networkLogin()) {
                                if(!event_handler.isPined())
                                event_handler.registrationPin(event_handler.getMyPin(),event_handler.getPhone(),event_handler.getPass())
                                loader.source = "qrc:/main.qml"
                            }
                            else {
                                dialogAndroid.text="Аккаунта более нет в базе"
                                pinScreen.visible = true
                                dialogAndroid.visible=true;
                            }
                            busyIndicatorScreen.visible = false
                            break
                        case 1:
                            pinSquare1.color="#FFFFFF"
                            break
                        case 2:
                            pinSquare2.color="#FFFFFF"
                            break
                        case 3:
                            pinSquare3.color="#FFFFFF"
                            break
                        case 4:
                            pinSquare4.color="#FFFFFF"
                            if(event_handler.isPined()) {
                                event_handler.pinIncrement()
                                if(event_handler.getPinInput()<5)
                                    dialogAndroid.text = "Введен не верный пин"
                                else
                                    dialogAndroid.text = "Вы исчерпали лимит попыток"
                                dialogAndroid.visible=true;
                            }
                            else {
                                if(event_handler.getMePins()=="") {
                                    event_handler.setPin(event_handler.getMyPin())
                                    dialogAndroid.text = "Введите пин повторно"
                                }
                                else
                                    dialogAndroid.text = "Пин-коды не совпали!"
                                dialogAndroid.visible=true;
                            }
                            break
                        }
                    }
                }
            }

            Button {
                id: button5
                text: qsTr("5")
                font.pointSize: facade.toPx(34)
                font.family: comfortFont.name

                height: gridLayout1.height/4-gridLayout1.rowSpacing
                width: gridLayout1.width/3-gridLayout1.columnSpacing

                background: Rectangle {
                    color: button5.down ? "#10387E" : "#5DA7EF"
                }
                contentItem: Text {
                    text: button5.text
                    font: button5.font
                    verticalAlignment: Text.AlignVCenter
                    horizontalAlignment: Text.AlignHCenter
                    color: button5.down ? "#FFFFFF" : "#FFFFFF"
                }
                onClicked: {
                    if(!pinerScreenTimer.running) {
                        event_handler.setMyPin(text)
                        switch(event_handler.pinLength()) {
                        case -1:
                            pinSquare4.color="#FFFFFF"
                            pinScreen.visible = false
                            busyIndicatorScreen.visible = true
                            if(event_handler.networkLogin()) {
                                if(!event_handler.isPined())
                                event_handler.registrationPin(event_handler.getMyPin(),event_handler.getPhone(),event_handler.getPass())
                                loader.source = "qrc:/main.qml"
                            }
                            else {
                                dialogAndroid.text="Аккаунта более нет в базе"
                                pinScreen.visible = true
                                dialogAndroid.visible=true;
                            }
                            busyIndicatorScreen.visible = false
                            break
                        case 1:
                            pinSquare1.color="#FFFFFF"
                            break
                        case 2:
                            pinSquare2.color="#FFFFFF"
                            break
                        case 3:
                            pinSquare3.color="#FFFFFF"
                            break
                        case 4:
                            pinSquare4.color="#FFFFFF"
                            if(event_handler.isPined()) {
                                event_handler.pinIncrement()
                                if(event_handler.getPinInput()<5)
                                    dialogAndroid.text = "Введен не верный пин"
                                else
                                    dialogAndroid.text = "Вы исчерпали лимит попыток"
                                dialogAndroid.visible=true;
                            }
                            else {
                                if(event_handler.getMePins()=="") {
                                    event_handler.setPin(event_handler.getMyPin())
                                    dialogAndroid.text = "Введите пин повторно"
                                }
                                else
                                    dialogAndroid.text = "Пин-коды не совпали!"
                                dialogAndroid.visible=true;
                            }
                            break
                        }
                    }
                }
            }

            Button {
                id: button6
                text: qsTr("6")
                font.pointSize: facade.toPx(34)
                font.family: comfortFont.name

                height: gridLayout1.height/4-gridLayout1.rowSpacing
                width: gridLayout1.width/3-gridLayout1.columnSpacing

                background: Rectangle {
                    color: button6.down ? "#10387E" : "#5DA7EF"
                }
                contentItem: Text {
                    text: button6.text
                    font: button6.font
                    verticalAlignment: Text.AlignVCenter
                    horizontalAlignment: Text.AlignHCenter
                    color: button6.down ? "#FFFFFF" : "#FFFFFF"
                }
                onClicked: {
                    if(!pinerScreenTimer.running) {
                        event_handler.setMyPin(text)
                        switch(event_handler.pinLength()) {
                        case -1:
                            pinSquare4.color="#FFFFFF"
                            pinScreen.visible = false
                            busyIndicatorScreen.visible = true
                            if(event_handler.networkLogin()) {
                                if(!event_handler.isPined())
                                event_handler.registrationPin(event_handler.getMyPin(),event_handler.getPhone(),event_handler.getPass())
                                loader.source = "qrc:/main.qml"
                            }
                            else {
                                dialogAndroid.text="Аккаунта более нет в базе"
                                pinScreen.visible = true
                                dialogAndroid.visible=true;
                            }
                            busyIndicatorScreen.visible = false
                            break
                        case 1:
                            pinSquare1.color="#FFFFFF"
                            break
                        case 2:
                            pinSquare2.color="#FFFFFF"
                            break
                        case 3:
                            pinSquare3.color="#FFFFFF"
                            break
                        case 4:
                            pinSquare4.color="#FFFFFF"
                            if(event_handler.isPined()) {
                                event_handler.pinIncrement()
                                if(event_handler.getPinInput()<5)
                                    dialogAndroid.text = "Введен не верный пин"
                                else
                                    dialogAndroid.text = "Вы исчерпали лимит попыток"
                                dialogAndroid.visible=true;
                            }
                            else {
                                if(event_handler.getMePins()=="") {
                                    event_handler.setPin(event_handler.getMyPin())
                                    dialogAndroid.text = "Введите пин повторно"
                                }
                                else
                                    dialogAndroid.text = "Пин-коды не совпали!"
                                dialogAndroid.visible=true;
                            }
                            break
                        }
                    }
                }
            }

            Button {
                id: button7
                text: qsTr("7")
                font.pointSize: facade.toPx(34)
                font.family: comfortFont.name

                height: gridLayout1.height/4-gridLayout1.rowSpacing
                width: gridLayout1.width/3-gridLayout1.columnSpacing

                background: Rectangle {
                    color: button7.down ? "#10387E" : "#5DA7EF"
                }
                contentItem: Text {
                    text: button7.text
                    font: button7.font
                    verticalAlignment: Text.AlignVCenter
                    horizontalAlignment: Text.AlignHCenter
                    color: button7.down ? "#FFFFFF" : "#FFFFFF"
                }
                onClicked: {
                    if(!pinerScreenTimer.running) {
                        event_handler.setMyPin(text)
                        switch(event_handler.pinLength()) {
                        case -1:
                            pinSquare4.color="#FFFFFF"
                            pinScreen.visible = false
                            busyIndicatorScreen.visible = true
                            if(event_handler.networkLogin()) {
                                if(!event_handler.isPined())
                                event_handler.registrationPin(event_handler.getMyPin(),event_handler.getPhone(),event_handler.getPass())
                                loader.source = "qrc:/main.qml"
                            }
                            else {
                                dialogAndroid.text="Аккаунта более нет в базе"
                                pinScreen.visible = true
                                dialogAndroid.visible=true;
                            }
                            busyIndicatorScreen.visible = false
                            break
                        case 1:
                            pinSquare1.color="#FFFFFF"
                            break
                        case 2:
                            pinSquare2.color="#FFFFFF"
                            break
                        case 3:
                            pinSquare3.color="#FFFFFF"
                            break
                        case 4:
                            pinSquare4.color="#FFFFFF"
                            if(event_handler.isPined()) {
                                event_handler.pinIncrement()
                                if(event_handler.getPinInput()<5)
                                    dialogAndroid.text = "Введен не верный пин"
                                else
                                    dialogAndroid.text = "Вы исчерпали лимит попыток"
                                dialogAndroid.visible=true;
                            }
                            else {
                                if(event_handler.getMePins()=="") {
                                    event_handler.setPin(event_handler.getMyPin())
                                    dialogAndroid.text = "Введите пин повторно"
                                }
                                else
                                    dialogAndroid.text = "Пин-коды не совпали!"
                                dialogAndroid.visible=true;
                            }
                            break
                        }
                    }
                }
            }

            Button {
                id: button8
                text: qsTr("8")
                font.pointSize: facade.toPx(34)
                font.family: comfortFont.name

                height: gridLayout1.height/4-gridLayout1.rowSpacing
                width: gridLayout1.width/3-gridLayout1.columnSpacing

                background: Rectangle {
                    color: button8.down ? "#10387E" : "#5DA7EF"
                }
                contentItem: Text {
                    text: button8.text
                    font: button8.font
                    verticalAlignment: Text.AlignVCenter
                    horizontalAlignment: Text.AlignHCenter
                    color: button8.down ? "#FFFFFF" : "#FFFFFF"
                }
                onClicked: {
                    if(!pinerScreenTimer.running) {
                        event_handler.setMyPin(text)
                        switch(event_handler.pinLength()) {
                        case -1:
                            pinSquare4.color="#FFFFFF"
                            pinScreen.visible = false
                            busyIndicatorScreen.visible = true
                            if(event_handler.networkLogin()) {
                                if(!event_handler.isPined())
                                event_handler.registrationPin(event_handler.getMyPin(),event_handler.getPhone(),event_handler.getPass())
                                loader.source = "qrc:/main.qml"
                            }
                            else {
                                dialogAndroid.text="Аккаунта более нет в базе"
                                pinScreen.visible = true
                                dialogAndroid.visible=true;
                            }
                            busyIndicatorScreen.visible = false
                            break
                        case 1:
                            pinSquare1.color="#FFFFFF"
                            break
                        case 2:
                            pinSquare2.color="#FFFFFF"
                            break
                        case 3:
                            pinSquare3.color="#FFFFFF"
                            break
                        case 4:
                            pinSquare4.color="#FFFFFF"
                            if(event_handler.isPined()) {
                                event_handler.pinIncrement()
                                if(event_handler.getPinInput()<5)
                                    dialogAndroid.text = "Введен не верный пин"
                                else
                                    dialogAndroid.text = "Вы исчерпали лимит попыток"
                                dialogAndroid.visible=true;
                            }
                            else {
                                if(event_handler.getMePins()=="") {
                                    event_handler.setPin(event_handler.getMyPin())
                                    dialogAndroid.text = "Введите пин повторно"
                                }
                                else
                                    dialogAndroid.text = "Пин-коды не совпали!"
                                dialogAndroid.visible=true;
                            }
                            break
                        }
                    }
                }
            }

            Button {
                id: button9
                text: qsTr("9")
                font.pointSize: facade.toPx(34)
                font.family: comfortFont.name

                height: gridLayout1.height/4-gridLayout1.rowSpacing
                width: gridLayout1.width/3-gridLayout1.columnSpacing

                background: Rectangle {
                    color: button9.down ? "#10387E" : "#5DA7EF"
                }
                contentItem: Text {
                    text: button9.text
                    font: button9.font
                    verticalAlignment: Text.AlignVCenter
                    horizontalAlignment: Text.AlignHCenter
                    color: button9.down ? "#FFFFFF" : "#FFFFFF"
                }
                onClicked: {
                    if(!pinerScreenTimer.running) {
                        event_handler.setMyPin(text)
                        switch(event_handler.pinLength()) {
                        case -1:
                            pinSquare4.color="#FFFFFF"
                            pinScreen.visible = false
                            busyIndicatorScreen.visible = true
                            if(event_handler.networkLogin()) {
                                if(!event_handler.isPined())
                                event_handler.registrationPin(event_handler.getMyPin(),event_handler.getPhone(),event_handler.getPass())
                                loader.source = "qrc:/main.qml"
                            }
                            else {
                                dialogAndroid.text="Аккаунта более нет в базе"
                                pinScreen.visible = true
                                dialogAndroid.visible=true;
                            }
                            busyIndicatorScreen.visible = false
                            break
                        case 1:
                            pinSquare1.color="#FFFFFF"
                            break
                        case 2:
                            pinSquare2.color="#FFFFFF"
                            break
                        case 3:
                            pinSquare3.color="#FFFFFF"
                            break
                        case 4:
                            pinSquare4.color="#FFFFFF"
                            if(event_handler.isPined()) {
                                event_handler.pinIncrement()
                                if(event_handler.getPinInput()<5)
                                    dialogAndroid.text = "Введен не верный пин"
                                else
                                    dialogAndroid.text = "Вы исчерпали лимит попыток"
                                dialogAndroid.visible=true;
                            }
                            else {
                                if(event_handler.getMePins()=="") {
                                    event_handler.setPin(event_handler.getMyPin())
                                    dialogAndroid.text = "Введите пин повторно"
                                }
                                else
                                    dialogAndroid.text = "Пин-коды не совпали!"
                                dialogAndroid.visible=true;
                            }
                            break
                        }
                    }
                }
            }

            Button {
                id: button10

                background: Rectangle {color: "#5DA7EF"}

                height: gridLayout1.height/4-gridLayout1.rowSpacing
                width: gridLayout1.width/3-gridLayout1.columnSpacing
            }

            Button {
                id: button11
                text: qsTr("0")
                font.pointSize: facade.toPx(34)
                font.family: comfortFont.name

                height: gridLayout1.height/4-gridLayout1.rowSpacing
                width: gridLayout1.width/3-gridLayout1.columnSpacing

                background: Rectangle {
                    color: button11.down ? "#10387E" : "#5DA7EF"
                }
                contentItem: Text {
                    text: button11.text
                    font: button11.font
                    verticalAlignment: Text.AlignVCenter
                    horizontalAlignment: Text.AlignHCenter
                    color: button11.down ? "#FFFFFF" : "#FFFFFF"
                }
                onClicked: {
                    if(!pinerScreenTimer.running) {
                        event_handler.setMyPin(text)
                        switch(event_handler.pinLength()) {
                        case -1:
                            pinSquare4.color="#FFFFFF"
                            pinScreen.visible = false
                            busyIndicatorScreen.visible = true
                            if(event_handler.networkLogin()) {
                                if(!event_handler.isPined())
                                event_handler.registrationPin(event_handler.getMyPin(),event_handler.getPhone(),event_handler.getPass())
                                loader.source = "qrc:/main.qml"
                            }
                            else {
                                dialogAndroid.text="Аккаунта более нет в базе"
                                pinScreen.visible = true
                                dialogAndroid.visible=true;
                            }
                            busyIndicatorScreen.visible = false
                            break
                        case 1:
                            pinSquare1.color="#FFFFFF"
                            break
                        case 2:
                            pinSquare2.color="#FFFFFF"
                            break
                        case 3:
                            pinSquare3.color="#FFFFFF"
                            break
                        case 4:
                            pinSquare4.color="#FFFFFF"
                            if(event_handler.isPined()) {
                                event_handler.pinIncrement()
                                if(event_handler.getPinInput()<5)
                                    dialogAndroid.text = "Введен не верный пин"
                                else
                                    dialogAndroid.text = "Вы исчерпали лимит попыток"
                                dialogAndroid.visible=true;
                            }
                            else {
                                if(event_handler.getMePins()=="") {
                                    event_handler.setPin(event_handler.getMyPin())
                                    dialogAndroid.text = "Введите пин повторно"
                                }
                                else
                                    dialogAndroid.text = "Пин-коды не совпали!"
                                dialogAndroid.visible=true;
                            }
                            break
                        }
                    }
                }
            }

            Button {
                id: button12

                height: gridLayout1.height/4-gridLayout1.rowSpacing
                width: gridLayout1.width/3-gridLayout1.columnSpacing

                background: Rectangle {
                    color: button12.down ? "#10387E" : "#5DA7EF"
                }
                Image {
                    width: facade.toPx(46)
                    height: facade.toPx(32)
                    x: parent.width/2-width/2
                    y: parent.height/2-height/2
                    source: "ui/buttons/clearButton.png"
                }
                onClicked: {
                    event_handler.clearPin()
                    pinSquare1.color="#40FFFFFF"
                    pinSquare2.color="#40FFFFFF"
                    pinSquare3.color="#40FFFFFF"
                    pinSquare4.color="#40FFFFFF"
                }
            }
        }

        //---------------------------------Горизонтальные полосы---------------------------------
        Rectangle { // ебаное нижнее подчеркивание. Ага, оно делается вот блять так!
            x: 0
            y: parent.height - gridLayout1.height
            width: parent.width
            height: 1
            border.color: "#FFFFFF"
            border.width: 1
        }
        Rectangle { // ебаное нижнее подчеркивание. Ага, оно делается вот блять так!
            x: parent.width/2- gridLayout1.width/2
            y: parent.height - gridLayout1.height + button1.height
            width: facade.toPx(500)
            height: 1
            border.color: "#FFFFFF"
            border.width: 1
        }
        Rectangle { // ебаное нижнее подчеркивание. Ага, оно делается вот блять так!
            x: parent.width/2- gridLayout1.width/2
            y: parent.height - gridLayout1.height + 2*button1.height
            width: facade.toPx(500)
            height: 1
            border.color: "#FFFFFF"
            border.width: 1
        }
        Rectangle { // ебаное нижнее подчеркивание. Ага, оно делается вот блять так!
            x: parent.width/2- gridLayout1.width/2
            y: parent.height - gridLayout1.height + 3*button1.height
            width: facade.toPx(500)
            height: 1
            border.color: "#FFFFFF"
            border.width: 1
        }
        //--------------------------------------------------------------------------------------/


        //---------------------------------Вертикальные полосы-----------------------------------
        Rectangle { // ебаное нижнее подчеркивание. Ага, оно делается вот блять так!
            x: parent.width/2- gridLayout1.width/2 + button1.width
            y: parent.height - gridLayout1.height
            width: 1
            height: gridLayout1.height
            border.color: "#FFFFFF"
            border.width: 1
        }
        Rectangle { // ебаное нижнее подчеркивание. Ага, оно делается вот блять так!
            x: parent.width/2- gridLayout1.width/2 + 2*button1.width
            y: parent.height - gridLayout1.height
            width: 1
            height: gridLayout1.height
            border.color: "#FFFFFF"
            border.width: 1
        }
        //--------------------------------------------------------------------------------------/

        Button {
            id: pinerScreenBackButton
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
                if(event_handler.isPined())
                    loader.source = "qrc:/basic.qml"
                else {
                    if(event_handler.getMePins()=="")
                        dialogAndroid.text = "Придумайте свой пин-код"
                    else {
                        event_handler.clearPin()
                        event_handler.cleanMePin()
                        pinSquare1.color="#FFFFFF"
                        pinSquare2.color="#FFFFFF"
                        pinSquare3.color="#FFFFFF"
                        pinSquare4.color="#FFFFFF"
                        dialogAndroid.text = "Первый пин-код сброшен!"
                    }
                    dialogAndroid.visible=true;
                }
            }
        }
    }

    CourierStyle.BusyIndicator {
        id: busyIndicatorScreen
    }

    CourierStyle.DialogWindow {
        id: dialogAndroid
    }
}
