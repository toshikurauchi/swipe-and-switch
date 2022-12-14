import QtQuick 2.3
import QtQuick.Controls 1.2
import QtQuick.Dialogs 1.2
import QtQuick.Layouts 1.1
import Qt.labs.settings 1.0

ApplicationWindow {
    id: win
    visible: true
    width: 300
    height: 100
    title: qsTr("KeyEye")

    signal closed(string dataFolder, int sessions, string participantID, bool useGestures, bool showTutorial, bool showCandidate)

    Action {
        shortcut: "Ctrl+Q"
        onTriggered: Qt.quit();
    }

    Settings {
        id: settings
        property string dataFolder: ""
        property int sessions: 3
        property string lastPID: ""
        property bool useGesture: false
        property bool showCandidates: true
    }

    Component.onDestruction: {
        settings.dataFolder = dataFolder.text
        settings.sessions = sessions.value
        settings.lastPID = pID.text
        settings.useGesture = gestureCheckbox.checked
        settings.showCandidates = candidateCheckbox.checked
    }

    FileDialog {
        id: dataFolderDialog
        title: "Please choose the data folder"
        folder: settings.dataFolder
        selectFolder: true
        onAccepted: {
            var path = dataFolderDialog.fileUrl.toString();
            path = path.replace(/^(file:\/{3})/,"");
            path = decodeURIComponent(path);
            dataFolder.text = path;
            visible = false;
        }
        onRejected: {
            visible = false;
        }
    }

    GridLayout {
        columns: 3
        anchors.fill: parent
        anchors.margins: 10

        Label {
            text: "Data folder"
        }
        TextField {
            id: dataFolder
            Layout.fillWidth: true
            text: settings.dataFolder
        }
        Button {
            text: "Choose"
            onClicked: dataFolderDialog.visible = true
        }

        Label {
            text: "Sessions"
            Layout.row: 1
            Layout.column: 0
        }
        SpinBox {
            id: sessions
            minimumValue: 1
            maximumValue: 20
            value: settings.sessions
            Layout.row: 1
            Layout.column: 1
        }

        Label {
            text: "Show candidate"
            Layout.row: 2
            Layout.column: 0
        }
        CheckBox {
            id: candidateCheckbox
            checked: settings.showCandidates
            Layout.row: 2
            Layout.column: 1
        }

        Label {
            text: "Participant ID"
            Layout.row: 3
            Layout.column: 0
        }
        TextField {
            id: pID
            Layout.fillWidth: true
            text: settings.lastPID
            Layout.row: 3
            Layout.column: 1
        }

        Label {
            text: "Gesture"
            Layout.row: 4
            Layout.column: 0
        }
        CheckBox {
            id: gestureCheckbox
            checked: settings.useGesture
            Layout.row: 4
            Layout.column: 1
        }

        Label {
            text: "Show tutorial"
            Layout.row: 5
            Layout.column: 0
        }
        CheckBox {
            id: tutorialCheckbox
            checked: false
            Layout.row: 5
            Layout.column: 1
        }

        Button {
            Layout.row: 6
            Layout.column: 2
            text: "OK"

            onClicked: {
                closed(dataFolder.text, sessions.value, pID.text, gestureCheckbox.checked, tutorialCheckbox.checked, candidateCheckbox.checked);
                Qt.quit();
            }
        }
    }
}
