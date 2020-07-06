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
    color: "#4c4e50"
    title: qsTr("Hello World")
    Connections {
        target: ServerHandler
        onServerInitialized: {
            loader.setSource("qrc:/Settings.qml")
            busy.visible = false
        }
    }

    Loader {
        id: loader
        anchors.fill: parent
        sourceComponent: MainPage {
            id: mainPage
            anchors.fill: parent
            onStartRequested: {
                ServerHandler.startServer()
                busy.visible = true
            }
        }
    }
    Menu {

    }
    Rectangle {
        id: busy
        visible: false
        width: 64
        height: 64
        anchors.centerIn: parent
        color: "cyan"
        BusyIndicator {
            anchors.fill: parent
        }
    }
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
