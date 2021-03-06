import QtQuick 2.7
import QtQuick.Controls 2.0

ApplicationWindow {
    id: root
    width: 500
    height: 900
    visible: true
    title: qsTr("Доставка 328")

    QtObject {
        id: facade
        function toPx(dp) {
            return dp*(loader.dpi/160)* 1.3;
        }
    }

    Loader {
        id: loader
        property real dpi
        objectName: "loader"
        anchors.fill: parent
        property int drawerCurrentIndex: -1

        QtObject {
            id: privated
            property var openMenu: null
            property var visitedPagesList:[]
        }
        source: event_handler.isPined()? "qrc:/main.qml":"qrc:/basic.qml"
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
