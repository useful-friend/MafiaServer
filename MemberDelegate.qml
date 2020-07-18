import QtQuick 2.0
import QtQuick.Controls 2.0

Item {
    width: item.width
    height: item.height
    anchors.horizontalCenter: parent.horizontalCenter
    anchors.margins: 5
    Rectangle {
        id: item
        width: row.width
        height: row.height
        border.width: 1
        border.color: "#7e57c2"
        color: "#0d47a1"
        radius: 4
        Row {
            id: row
            spacing: 20
            Rectangle {
                id: leftSpace
                width: 10
                height: item.height
                color: "transparent"
            }
            Column {
                id: col
                Text {
                    id: name
                    text: model.name
                    color: "white"
                }
                Text {
                    id: ip
                    text: model.ip
                    color: "white"
                }
                Text {
                    id: port
                    text: model.port
                    color: "white"
                }
            }
            Button {
                id: buttonDelete
                text: "Delete"
                onClicked: ServerHandler.model().remove(index)
            }
            Rectangle {
                id: rightSpace
                width: 10
                height: item.height
                color: "transparent"
            }
        }
    }

}
