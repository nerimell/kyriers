import QtQuick 2.7
import QtQuick.Controls 2.0
import "."
import ".."

//--------------------------------------------------dialogAndroid----------------------------------------------
Button {
    visible: false
    id: dialogAndroid
    anchors.fill: parent

    contentItem: Text {
        opacity: 0
    }

    background: Rectangle {
        opacity: 0.8
        color: "#404040"
    }

    // Создаём содержимое диалогового окна
    Rectangle {
        radius: facade.toPx(25)
        color: "#f7f7f7"
        x: parent.width/2-width/2
        width: dialogAndroid.width-80
        y: parent.height/2- height/2
        height: dialogAndroid.height/2.5

        // Область для сообщения диалогового окна
        Rectangle {
            radius: facade.toPx(25)
            color: "#f7f7f7"
            anchors.top: parent.top
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.bottom: dialogAndroidDividerHorizontal.top

            Label {
                id: dialogAndroidTextLabel

                color: "#000000"
                font.bold: true
                text: dialogAndroid.text
                font.pointSize: facade.toPx(20)
                font.family: sfuiFontLight.name
                horizontalAlignment: Text.AlignHCenter
                anchors.centerIn: parent// put сообщение в центр области отобраэжения
            }
        }

        // Создаём горизонтальный разделитель с Rectangle
        Rectangle {
            id: dialogAndroidDividerHorizontal
            color: "#808080"
            height: facade.toPx(1)
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.bottom:dialogAndroidrow.top
        }

        Rectangle {
            height: facade.toPx(25)
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.top: dialogAndroidDividerHorizontal.bottom
            color: dialogAndroidDialogButtonOk.pressed?"#d7d7d7":"#f7f7f7"
        }

        /* Создаём подложку для кнопок в виде объекта Строки
         * В данном объекте для child не работают нек-е параметры
         * anchors, кроме параметров anchors.top и anchors.bottom
         */
        Row {
            id: dialogAndroidrow
            height: (dialogAndroid.height<900)?facade.toPx(100): 100
            // А также прибиваем строку к низу у диалогового окна
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.bottom: parent.bottom

            /*
            Button {
                id: dialogAndroiddialogButtonCancel

                // Растянем кнопку по высоте строки
                anchors.top: parent.top
                anchors.bottom: parent.bottom

                width: parent.width / 2 - facade.toPx(1)

                contentItem: Text {
                    font.pointSize: facade.toPx(24)

                    color: "#34aadc"
                    text: qsTr("Отмена")
                    verticalAlignment: Text.AlignVCenter
                    horizontalAlignment: Text.AlignHCenter
                }

                background: Rectangle {
                    radius: facade.toPx(25)
                    color:dialogAndroiddialogButtonCancel.pressed? "#d7d7d7":"#f7f7f7"
                }

                //onClicked: dialogAndroid.visible = false
            }

            //Создаю разделитель между кнопками шириной в 2 пикселя
            Rectangle {
                id: dialogAndroidDividerVertical
                color: "#808080"
                width: facade.toPx(2)
                // Растягиваем разделитель по высоте объекта строки
                anchors.top: parent.top
                anchors.bottom: parent.bottom
            }
            */

            Button {
                id: dialogAndroidDialogButtonOk

                anchors.top: parent.top
                anchors.bottom: parent.bottom
                //width: parent.width / 2 - facade.toPx(1)
                width: parent.width // если необходима только одна кнопочка на экран

                contentItem: Text {
                    font.bold: true
                    font.pointSize: facade.toPx(24)

                    color: "#34aadc"
                    text: qsTr("Хорошо")
                    verticalAlignment: Text.AlignVCenter
                    horizontalAlignment: Text.AlignHCenter
                }

                background: Rectangle {
                    radius: facade.toPx(25)
                    color: dialogAndroidDialogButtonOk.pressed? "#d7d7d7": "#f7f7f7"
                }

                onClicked: {
                    dialogAndroid.visible=false
                }
            }
        }
    }
}
//-------------------------------------------------------------------------------------------------------------
