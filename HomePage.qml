import QtQuick 2.0

Item {
    anchors.fill: parent
    Rectangle {
        anchors.fill: parent
        color: "lightgrey"
    }

    Text {
        id: t
        anchors.centerIn: parent
        text: qsTr("this is HomePage")
    }
}
