import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Controls.Material 2.0
import QtQuick.Controls 2.3
import QtQuick.Layouts 1.0

Window {
    id: window
    visible: true
    width: 600
    height: 600
    color: Material.theme == Material.Dark ? "#4c4e50" : "#eeeeee"
    title: qsTr("Mafia Server")
    Material.theme: Material.Dark
    Material.accent: Material.LightBlue

//    MainPage {
//                id: mainPage
//                anchors.fill: parent
//                onOpenRoom: {
//                    ServerHandler.startServer(roomName)
//    //                busy.visible = true
//                }
//            }

    Connections {
        target: ServerHandler
        onServerInitialized: {
//            busy.visible = false
            stack.push("qrc:/MemberSelection.qml", {"ip": ipAddress}, StackView.Immediate)
        }
    }

    Connections {
        target: modeSelection
        onSelected: {
            console.log(type)
            if (type === 0) {
                stack.push("qrc:/MainPage.qml", {}, StackView.Immediate)
            } else if (type == 1) {
                stack.push("qrc:/ClientPage.qml", {}, StackView.Immediate)
            } else
                console.log("should not end up here")
        }
    }
    Rectangle {
        id: header
        height: 50
        anchors.right: parent.right
        anchors.left: parent.left
        color: "darkgrey"
        Button {
            id: backButton
            text: "Back"
            visible: stack.depth > 1
            onClicked: stack.pop()
        }
    }

    StackView {
        id: stack
        anchors.top: header.bottom
        anchors.right: parent.right
        anchors.left: parent.left
        anchors.bottom: parent.bottom
        initialItem: ModeSelectionPage {id: modeSelection}
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
