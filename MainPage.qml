import QtQuick 2.0
import QtQuick.Controls 2.12

Item {
    id: it
    anchors.fill: parent
    StackView {
        width: parent.width
        anchors.bottom: myItem.top
        anchors.top: parent.top
        anchors.bottomMargin: 5
        id: stack
        initialItem: home
        HomePage {
            id: home
            anchors.fill: parent
        }
    }
    Item {
        id: myItem
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 5
        width: backButton.width +  nextButton.width + 10
        height: backButton.height
        anchors.horizontalCenter: parent.horizontalCenter
        Button {
            id: backButton
            width: 100
            height: 50
            anchors.right: nextButton.left
            anchors.rightMargin: 5
            text: "back"
            onClicked: {stack.pop(StackView.Immediate)}
        }
        Button {
            id: nextButton
            width: 100
            height: 50
            anchors.left: backButton.right
            anchors.leftMargin: 5
            text: "next"
            onClicked: {stack.push("qrc:/Settings.qml", {}, StackView.Immediate)}
        }
    }
}
