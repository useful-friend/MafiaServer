import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.VirtualKeyboard 2.4
import QtQuick.Controls.Material 2.0
import QtQuick.Controls 2.3

Window {
    id: window
    visible: true
    width: 600
    height: 600
//    color: "#4c4e50"
    title: qsTr("Hello World")

    Material.theme: Material.Dark
    Material.accent: Material.DeepOrange

    Connections {
        target: ServerHandler
        onServerInitialized: {
//            busy.visible = false
            stack.push("qrc:/MemberSelection.qml", {}, StackView.Immediate)
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
    InputPanel {
        id: inputPanel
        z: 99
        x: 0
        y: window.height
        width: window.width

        states: State {
            name: "visible"
            when: inputPanel.active
            PropertyChanges {
                target: inputPanel
                y: window.height - inputPanel.height
            }
        }
        transitions: Transition {
            from: ""
            to: "visible"
            reversible: true
            ParallelAnimation {
                NumberAnimation {
                    properties: "y"
                    duration: 250
                    easing.type: Easing.InOutQuad
                }
            }
        }
    }
}
