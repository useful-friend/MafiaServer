import QtQuick 2.0
import QtQuick.Controls 2.0
import MemberModel 1.0

Rectangle {
    signal start()
    id: root
    anchors.fill: parent
    color: "grey"
    ListView {
        id: view
        anchors.fill: parent
        model: ServerHandler.model()
        delegate: MemberDelegate {}
    }
    Button {
        text: qsTr("Start")
        onClicked: root.start()
    }
}
