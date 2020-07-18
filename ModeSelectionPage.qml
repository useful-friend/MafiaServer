import QtQuick 2.0
import QtQuick.Controls 2.0

Item {
    id: root
    anchors.centerIn: parent
    width: view.width
    height: view.height
    signal selected(int type)
    ListModel {
        id: model
        ListElement {
            name: qsTr("God")
        }
        ListElement {
            name: qsTr("Player")
        }
    }
    Rectangle {
        color: "cyan"
        border.color: "green"
        border.width: 1
        radius: 4
        width: view.width
        height: view.height
        anchors.margins: 20

        ListView {
            height: contentHeight
            width: contentWidth
            id: view
            model: model
            orientation: ListView.Horizontal
            spacing: 10
            delegate: Button {
                anchors.verticalCenter: parent.verticalCenter
                implicitWidth: 100
                text: name
                onClicked: {
                    ServerHandler.start(index);
                    root.selected(index)
                }
            }
        }
    }
}
