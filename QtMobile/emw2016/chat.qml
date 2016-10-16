import QtQuick 2.7
import QtQuick.Layouts 1.0
import QtQuick.Controls 2.0
import "EmwStyle" as EmwStyle

Item {
    id: rootChat
    anchors.fill: parent

    EmwStyle.NavigateDrawer {
        id: chatScreenDrawer
    }

    ListView {
        width: parent.width
        y: facade.toPx(190)
        id: chatScreenChatList
        height: (chatScreenTextFieldPost.lineCount<5)? parent.height - facade.toPx(310) - (chatScreenTextFieldPost.lineCount - 1) * facade.toPx(29): parent.height - facade.toPx(310) - (5 - 1) * facade.toPx(29)

        model:ListModel{
            id: qwe
        }

        delegate: Item {
            height: (facade.toPx(44)-myheight>=0)?mySpacing+myheight+(facade.toPx(44)-myheight): mySpacing + facade.toPx(13) + myheight
            Image {
                source: image
                y: parentText.y + parentText.height-sourceSize.height
                x: (parentText.x == facade.toPx(30))? parentText.x - facade.toPx(11): parentText.x + parentText.width - facade.toPx(16)
            }
            TextArea {
                id: parentText
                text: someText
                x: HorizonPosition
                width: rootChat.width/2
                height: (facade.toPx(44)-myheight>=0)? myheight + (facade.toPx(44)-myheight): myheight + facade.toPx(13)

                background: Rectangle {
                    radius: facade.toPx(25)
                    color: backgroundColor
                }

                readOnly: true
                color: textColor
                font.pointSize: facade.toPx(18)

                wrapMode: TextEdit.Wrap
                font.family: museoSansLight.name
            }
        }
    }

    Rectangle {
        radius: facade.toPx(25)
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        anchors.top: flickableTextArea.top
        anchors.leftMargin: 0.02*parent.width
        anchors.rightMargin:0.02*parent.width
    }

    Rectangle {
        clip: true
        width: parent.width
        height: facade.toPx(140)
        id: chatScreenNavbarMenu
        Image {
            y: -(height-facade.toPx(280))
            x: rootChat.width/2 - width/2
            height:(rootChat.width<rootChat.height/2)? rootChat.height/2:sourceSize.height*(width/sourceSize.width)
            width: (rootChat.width<rootChat.height/2)? sourceSize.width*(rootChat.height/2/sourceSize.height):rootChat.width
            source: "ui/navbarMenu/navbarMenu.png"
        }

        Button {
            x: facade.toPx(20)
            y: facade.toPx(41)
            id: chatDrawerButton
            width: facade.toPx(60)
            height: facade.toPx(40)

            background: Rectangle {
                opacity: 0
            }

            onClicked: {
                chatScreenDrawer.open()
            }

            Image {
                width: sourceSize.width
                height: sourceSize.height - facade.toPx(6)
                source: "ui/buttons/hamButton.png"
                fillMode: Image.PreserveAspectFit
            }
        }

        Text {
            color: "#FFFFFF"
            font.pointSize: facade.toPx(24)
            font.family: museoSansMedium.name
            horizontalAlignment: Text.AlignHCenter

            anchors.topMargin: facade.toPx(34)
            anchors.top: parent.top
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.leftMargin: parent.width /2 - facade.toPx(50)
            anchors.rightMargin: parent.width/2 - facade.toPx(50)

            text: "EMW 2016"
        }

        Text {
            color: "#FFFFFF"
            font.pointSize: facade.toPx(18)
            font.family: museoSansMedium.name
            horizontalAlignment: Text.AlignHCenter

            anchors.topMargin: facade.toPx(94)
            anchors.top: parent.top
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.leftMargin: parent.width /2 - facade.toPx(50)
            anchors.rightMargin: parent.width/2 - facade.toPx(50)

            text: "Владимир Соколов"
        }
    }


    /*
    TextArea {
        visible: false
        id: chatScreenTextField
        font.family: museoSansLight.name
        font.pointSize: chatScreenTextFieldPost.font.pointSize
    }
    TextArea {
        visible: false
        width: parent.width/2
        id: chatScreenTextList
        wrapMode: TextEdit.WordWrap
        font.family: museoSansLight.name
        font.pointSize: chatScreenTextFieldPost.font.pointSize
        onTextChanged: {
            chatScreenTextField.text = text.substring(text.length - event_handler.charsTextArea(1), text.length)
            if (chatScreenTextField.contentWidth > width - 40)
            {
                event_handler.charsTextArea(0)
                text += "\n"
                cursorPosition = text.length
            }
        }
    }
    */
    Flickable {
        id: flickableTextArea
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        anchors.bottomMargin: facade.toPx(25)
        anchors.leftMargin: 0.02*parent.width
        flickableDirection: Flickable.VerticalFlick
        anchors.rightMargin:0.02*parent.width+chatScreenPostButton.width

        height: (chatScreenTextFieldPost.lineCount < 5)? facade.toPx(44) + (chatScreenTextFieldPost.lineCount - 1) * facade.toPx(29): facade.toPx(44) + 4 * facade.toPx(29)

        TextArea.flickable: TextArea {
            wrapMode: TextEdit.Wrap
            background: Rectangle {
                border.width: 2
                border.color:"#C8C8C8"
                radius:facade.toPx(25)
            }

            id:chatScreenTextFieldPost

            color: "#000000"
            font.pointSize: facade.toPx(18)

            font.family:museoSansLight.name
            placeholderText: qsTr("Написать...")

            onActiveFocusChanged: {
                if (activeFocus)
                    chatScreenNavbarMenu.y += rootChat.height * 0.3
                else
                    chatScreenNavbarMenu.y -= rootChat.height * 0.3
            }
            /*
            onTextChanged: {
                if (!event_handler.isRekursia() && text.length > 0)
                {
                    if(text.length == 1) {
                        event_handler.lineCount(1);
                        event_handler.charsTextArea(0)
                        event_handler.charsTextArea(1)
                        event_handler.setBackArea(false)
                        event_handler.setRekursia(false)
                        event_handler.charTextAreaLength(0)
                    }

                if(lineCount<event_handler.lineCount(0)&&!event_handler.isBackArea())
                    event_handler.setBackArea(true)
                if(text.length> event_handler.charTextAreaLength(0))
                {
                    chatScreenTextField.text = text.substring(text.length - event_handler.charsTextArea(1), text.length)
                    if((chatScreenTextField.contentWidth > width - chatScreenPostButton.width - 20 && lineCount == 1) ||
                    (chatScreenTextField.contentWidth > width - 30 && lineCount >= 2))
                    {
                        if (!event_handler.isBackArea()) {
                            event_handler.charsTextArea(0)
                            text += "\n"
                            cursorPosition= text.length
                        }
                        else {
                            var symbol = text.substring(text.length - 1, text.length)
                            event_handler.setRekursia(true);
                            text=text.substring(0,text.length-1)
                            event_handler.setBackArea(false)
                            event_handler.setRekursia(true);
                            event_handler.charsTextArea (0);
                            event_handler.charsTextArea (2);
                            text = text + "\n" + symbol
                            cursorPosition= text.length
                        }
                    }
                }
                else if(event_handler.charsTextArea(-1) < 0){
                    event_handler.charsTextArea(text.length)
                    event_handler.setBackArea(true)
                }
                event_handler.charTextAreaLength(text.length)
                event_handler.lineCount(lineCount);
                }
                event_handler.setRekursia(false);
            }
            */
        }
    }

    Button {
        y: flickableTextArea.y
        id: chatScreenPostButton
        anchors.right: parent.right
        anchors.rightMargin: 0.02* parent.width
        checked: false
        checkable: false
        autoRepeat: false
        highlighted: false
        autoExclusive: false
        height:buttonImage.height
        width:buttonImage.width+facade.toPx(10)

        background: Rectangle {
            opacity: 0
        }

        Image {
            id: buttonImage
            x: facade.toPx(10)
            height: facade.toPx(44)
            fillMode: Image.PreserveAspectFit
            source: "ui/buttons/sendButton.png"
        }

        onClicked: {
            if(chatScreenTextFieldPost.text.length > 0) {
                /*
                chatScreenTextList.text = ""
                chatScreenTextField.text = ""
                event_handler.lineCount(1);
                event_handler.charsTextArea(0)
                event_handler.charsTextArea(1)
                event_handler.setBackArea(false)
                event_handler.setRekursia(false)
                event_handler.charTextAreaLength(0)
                for(var i=0;i<chatScreenTextFieldPost.text.length;i++)
                    if(chatScreenTextFieldPost.text.charAt(i) != "\n")
                chatScreenTextList.text +=
                chatScreenTextFieldPost.text.charAt(i)
                */
                qwe.append({
                    backgroundColor:(qwe.count%2==0)?"#E5E5EA":"#51587F",
                    someText: chatScreenTextFieldPost.text,
                    myheight: chatScreenTextFieldPost.contentHeight,
                    mySpacing:(qwe.count%2==0)? 2 : facade.toPx(20),
                    textColor:(qwe.count%2==0)? "#000000":"#FFFFFF",
                    HorizonPosition: qwe.count % 2 * (parent.width - parent.width/2 - facade.toPx(60))+ facade.toPx(30),
                    image: (qwe.count%2==0)?"ui/screensIcons/chatMessageWhite.png":"ui/screensIcons/chatMessageBlue.png"
                });
                chatScreenTextFieldPost.text = ""
                chatScreenChatList.positionViewAtEnd()
            }
        }

        contentItem: Text {
                text: chatScreenPostButton.text
                font: chatScreenPostButton.font
                opacity: enabled ? 1.0 : 0.3
                color: chatScreenPostButton.down ? "#0f133d" : "#7680B1"
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                elide: Text.ElideRight
        }
    }
}
