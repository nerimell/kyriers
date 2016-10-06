import QtQuick 2.7
import QtQuick.Controls 2.0

ApplicationWindow {
    id: root
    width: 500
    height: 900
    visible: true
    title: qsTr("Доставка 328")

    Loader {
        anchors.fill: parent
        id: loader
        source: event_handler.isPined()? "qrc:/piner.qml":"qrc:/basic.qml"
    }

    FontLoader {
        id: sfuiFont
        source: "qrc:/fonts/SFUIText-Regular.otf"
    }
    FontLoader {
        id: sfuiFontLight
        source: "qrc:/fonts/SF_UI_TEXt_Light.ttf"
    }
    FontLoader {
        id: comfortFont
        source: "qrc:/fonts/Comfortaa-Light.ttf"
    }
}
