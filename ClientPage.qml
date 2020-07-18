import QtQuick 2.0
import QtQuick.Controls 2.0

Item {
    anchors.fill: parent
    ListView {
        height: contentHeight
        id: view
        model: [1, 4, 5, 10]
    }
    Button {
        text: qsTr("Search")
        anchors.top: view.bottom
        onClicked: ServerHandler.search()
    }
}
