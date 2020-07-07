import QtQuick 2.0
import MemberModel 1.0

Item {
    ListView {
        id: view
        model: ServerHandler.model()
        delegate: Text {
            text: display
        }
    }
}
