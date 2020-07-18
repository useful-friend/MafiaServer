import QtQuick 2.0
import QtQuick.Controls 2.12
import QtQuick.Controls.Material 2.12

Item {
    id: root
    focus: true

    signal openRoom(string roomName)
    function openNewRoom() {
        if (textName.length !== 0)
            root.openRoom(textName.text)
        else
            dig.open()
    }
    Rectangle {
        anchors.centerIn: parent
        width: 200
        height: textName.height + btn.height + 30
        radius: 5
        color: "darkgrey"
        TextField {
            id: textName
            width: {
                var min = contentWidth < 120 ? 120 : contentWidth;
                return min < parent.width - 20 ? min : parent.width - 20
            }
            placeholderText: qsTr("Room name")
            text: qsTr("Room 1")
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: parent.top
            anchors.topMargin: 10
        }
        Dialog {
            id: dig
            Column{
                Text {
                    id: t
                    text: qsTr("Please enter a room name")
                }
                Button {
                    text: qsTr("OK")
                    onClicked: dig.close()
                }
            }
        }

        Button {
            id: btn
            anchors.top: textName.bottom
            anchors.topMargin: 10
            anchors.horizontalCenter: parent.horizontalCenter
            text: "start server"
            Material.foreground: Material.DeepOrange
            Material.background: Material.Grey
            onClicked: ServerHandler.startServer(textName.text)
        }
    }
    Keys.onPressed: {
        if (event.key === Qt.Key_Enter) {
            openNewRoom();
            event.accepted = true;
        }
    }
}
