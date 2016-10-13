import QtQuick 2.7
import QtQuick.Layouts 1.0
import QtQuick.Controls 2.0

Item {
    id: rootChat
    visible: true
    anchors.fill: parent

    ListView {
        width: parent.width
        id: chatScreenChatList
        height: (chatScreenTextFieldPost.lineCount<5)? parent.height - 220 - (chatScreenTextFieldPost.lineCount - 1) * 29: parent.height - 220 - (5 - 1) * 29
        y: 100

        model:ListModel {
            id: qwe
            ListElement {
                myheight: 44
                HorizonPosition: 60
                someText: "Задайте ваш вопрос"
                image: "ui/navbarIcons/config_blue.png"
            }
        }

        delegate: Item {
            height: (44-myheight>=0)? 10+ myheight + (44-myheight): 23 + myheight
            Image {
                source: image
                y: parentText.y + 5
                x: parentText.x - 47
            }
            TextArea {
                id: parentText
                text: someText
                x: HorizonPosition
                width: rootChat.width/2
                height: (44-myheight>=0)? myheight + (44-myheight): myheight + 13

                readOnly: true
                color: "#FFFFFF"
                font.pointSize: 18

                background: Rectangle {
                    color: "#960f133d"
                }

                wrapMode: TextEdit.WordWrap
            }
        }
    }

    TextArea {
        visible: false
        id: chatScreenTextField
        font.pointSize: chatScreenTextFieldPost.font.pointSize
    }
    TextArea {
        visible: false
        width: parent.width/2
        id: chatScreenTextList
        font.pointSize: chatScreenTextFieldPost.font.pointSize
        onTextChanged: {
            chatScreenTextField.text = text.substring(text.length - event_handler.charsTextArea(1), text.length)
            if (chatScreenTextField.contentWidth > width - 40)
            {
                event_handler.charsTextArea(0)
                if (text.substring(text.length-1,text.length)!=" ")
                    text +="-\n"
                else
                    text += "\n"
                cursorPosition = text.length
            }
        }
    }
    TextArea {
        id: chatScreenTextFieldPost
        x: parent.width/2 - width/2
        y: (parent.height>900)? chatScreenChatList.y + chatScreenChatList.height + 50 *parent.height/900: chatScreenChatList.y + chatScreenChatList.height + 50
        height: (chatScreenTextFieldPost.lineCount<5)? (parent.height > 900)? 44 * parent.height/900 + (chatScreenTextFieldPost.lineCount - 1) * 29: 44 + (chatScreenTextFieldPost.lineCount - 1) * 29: (parent.height > 900)? 44 * parent.height/900 + (5 - 1) * 29: 44 + (5 - 1) * 29
        width:parent.width-0.04*parent.width
        placeholderText: qsTr("Написать...")

        color: "#000000"
        font.pointSize: 18

        background: Rectangle {
            radius: 25
            border.color:"#960f133d"
        }

        wrapMode: TextEdit.WordWrap

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
                if((chatScreenTextField.contentWidth > width - chatScreenPostButton.width - 20 && lineCount == 1) || (chatScreenTextField.contentWidth > width - 30 && lineCount >= 2))
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
                        event_handler.charsTextArea(0)
                        event_handler.charsTextArea(2)
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
    }

    Button {
        id: chatScreenPostButton
        y:chatScreenTextFieldPost.y
        anchors.right: parent.right
        anchors.rightMargin: 0.02* parent.width
        height: (parent.height>900)?44 * parent.height / 900: 44
        checked: false
        checkable: false
        autoRepeat: false
        highlighted: false
        autoExclusive: false
        text: qsTr("Отправить")

        font.pointSize: 14

        onClicked: {
            if(chatScreenTextFieldPost.text.length > 0) {
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
                    chatScreenTextList.text += chatScreenTextFieldPost.text.charAt(i)
                qwe.append({
                    HorizonPosition: qwe.count%2*(parent.width-parent.width/2-80)+60,
                    someText: chatScreenTextList.text,
                    image:"ui/navbarIcons/config_blue.png",
                    myheight: chatScreenTextList.contentHeight
                });
                chatScreenTextFieldPost.text = ""
                chatScreenChatList.positionViewAtEnd()
            }
        }

        background: Rectangle {
            opacity: 0
        }

        contentItem: Text {
                text: chatScreenPostButton.text
                font: chatScreenPostButton.font
                opacity: enabled ? 1.0 : 0.3
                color: chatScreenPostButton.down ? "#960f133d" : "#960f133d"
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                elide: Text.ElideRight
        }
    }
}
