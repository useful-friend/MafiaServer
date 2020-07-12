import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Controls.Material 2.0
import QtQuick.Controls 2.3

Window {
    id: window
    visible: true
    width: 600
    height: 600
//    color: "#4c4e50"
    title: qsTr("Mafia Server")

    Material.theme: Material.Dark
    Material.accent: Material.DeepOrange

    Connections {
        target: ServerHandler
        onServerInitialized: {
//            busy.visible = false
            stack.push("qrc:/MemberSelection.qml", {"ip": ipAddress}, StackView.Immediate)
        }
    }

    StackView {
        id: stack
        anchors.fill: parent
        initialItem: MainPage {
            id: mainPage
            anchors.fill: parent
            onOpenRoom: {
                ServerHandler.startServer(roomName)
//                busy.visible = true
            }
        }
    }
    Drawer {
        id: drawer
        width: 0.33 * window.width
        height: window.height

        Label {
            text: "Content goes here!"
        }
    }
//    BusyIndicator {
//        visible: false
//        width: 64
//        height: 64
//        anchors.centerIn: parent
//        id: busy
//    }
}
