import QtQuick 2.0
import QtQuick.Controls 2.0
import MemberModel 1.0

Rectangle {
    property string ip
    signal start()
    id: root
    anchors.fill: parent
    color: "grey"
    Column {
        anchors.horizontalCenter: parent.horizontalCenter
        Text {
            id: ipText
            text: qsTr("The server is running on: ") + ip
        }
        ListView {
            id: view
            height: contentHeight
            model: ServerHandler.model()
            delegate: MemberDelegate {}
        }
        Button {
            id: btn
            anchors.top: view.bottom
            text: qsTr("Start")
            onClicked: root.start()
        }
    }
}
