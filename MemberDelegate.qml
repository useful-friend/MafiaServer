import QtQuick 2.0

Column {
    Text {
        id: name
        text: model.name
    }
    Text {
        id: ip
        text: model.ip
    }
    Text {
        id: port
        text: model.port
    }
}
