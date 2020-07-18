import QtQuick 2.0
import QtQuick.Controls 2.0
import MemberModel 1.0

Rectangle {
    property string ip
    signal start()
    id: root
    anchors.fill: parent
    color: "grey"
    Item {
        anchors.fill: parent
        Text {
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.topMargin: 20
            id: ipText
            text: qsTr("The server is running on: ") + ip
        }
        ListView {
            anchors.horizontalCenter: parent.horizontalCenter
            id: view
            height: contentHeight
            width: parent.width
            anchors.top: ipText.bottom
            model: ServerHandler.model()
            delegate: MemberDelegate {}
            spacing: 10
        }
        Button {
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.bottomMargin: 20
            id: btn
            anchors.top: view.bottom
            text: qsTr("Start")
            onClicked: root.start()
        }
    }
}
