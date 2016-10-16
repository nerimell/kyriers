import QtQuick 2.7
import QtQuick.Controls 2.0
import "."
import ".."

//--------------------------------------------------busyIndicator----------------------------------------------
Rectangle {
    visible: false
    anchors.fill: parent
    id: busyIndicatorLoginScreen

    opacity: 0.8
    color: "#404040"

    BusyIndicator {
        width: parent.width / 2
        height: parent.height/2
        x: parent.width/2 -width /2
        y: parent.height/2-height/2
    }
}
//-------------------------------------------------------------------------------------------------------------
