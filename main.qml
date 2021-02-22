import QtQuick 2.5
import QtQuick.Controls 1.4
import QtQuick.Layouts 1.1
import QtQuick.Dialogs 1.2
import QtQuick.Controls.Styles 1.4


ApplicationWindow {
    visible: true
    width: 640
    height: 480
    title: qsTr("Hello World")

    RowLayout {
        id: rowLayout
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.margins: 5

        spacing: 10



        Button {
            id: newL
           //text: qsTr("Create a new list")
           Text {
                anchors.centerIn: parent
                text: "Create a new list"
                color: "red"

               }
           style: ButtonStyle {
                   background: Rectangle {
                       implicitWidth: 100
                       implicitHeight: 25
                       border.width: control.activeFocus ? 2 : 1
                       border.color: "white"
                       radius: 4
                       gradient: Gradient {
                           GradientStop { position: 0 ; color: control.pressed ? "#ccc" : "#eee" }
                           GradientStop { position: 1 ; color: control.pressed ? "#aaa" : "#ccc" }
                       }
                   }
               }
            visible: true

            onClicked: {
                tableView.visible = !tableView.visible
                tableView2.visible = !tableView2.visible
                newL.visible = !newL.visible
                rowLayout2.visible = !rowLayout2.visible
            }
        }
    }

    RowLayout {
        id: rowLayout2
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.margins: 5
        visible: false

        spacing: 10

        Text {
            text: qsTr("Name the list")
        }


        Text {text: qsTr("id")}
        TextField {id: idField}
        Text {text: qsTr("name")}
        TextField { id: nameField}

        Button {
            Text {
                 anchors.centerIn: parent
                 text: "Create this list"
                 color: "black"

            }
            style: ButtonStyle {
                    background: Rectangle {
                        implicitWidth: 100
                        implicitHeight: 25
                        border.width: control.activeFocus ? 2 : 1
                        border.color: "blue"
                        color: "white"
                        radius: 4
                        gradient: Gradient {
                            GradientStop { position: 0 ; color: control.pressed ? "#ccc" : "#eee" }
                            GradientStop { position: 1 ; color: control.pressed ? "#aaa" : "#ccc" }
                        }
                    }
                }
            onClicked: {
                database.insertIntoTable1(idField.text, nameField.text, "0")
                myModel1.updateModel()
                myModel3.updateModel()

                tableView.visible = !tableView.visible
                tableView2.visible = !tableView2.visible
                newL.visible = !newL.visible
                rowLayout2.visible = !rowLayout2.visible

            }
        }

        Button {
            text: qsTr("Cancel")


            onClicked: {
                myModel1.updateModel()
                myModel3.updateModel()

                idField.text = ""
                nameField.text = ""
                tableView.visible = !tableView.visible
                tableView2.visible = !tableView2.visible
                newL.visible = !newL.visible
                rowLayout2.visible = !rowLayout2.visible
                           }
        }

    }

    TableView {
        id: tableView
        anchors.top: rowLayout.bottom
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.margins: 5
        visible: true

        TableViewColumn {
            role: "id"
            title: "ID"
        }
        TableViewColumn {
            role: "name"
            title: "Name"
        }
        TableViewColumn {
            role: "left"
            title: "Left"
        }

        model: myModel1


        rowDelegate: Rectangle {
            anchors.fill: parent
            color: styleData.selected ? 'skyblue' : (styleData.alternate ? 'whitesmoke' : 'white');
            MouseArea {
                anchors.fill: parent
                acceptedButtons: Qt.RightButton | Qt.LeftButton
                onClicked: {
                    tableView.selection.clear()
                    tableView2.selection.clear()
                    tableView.selection.select(styleData.row)
                    tableView.currentRow = styleData.row
                    tableView.focus = true
                    database.updateTable3(myModel1.getId(tableView.currentRow))
                    switch(mouse.button) {
                    case Qt.RightButton:
                        contextMenu.popup()
                        break
                    default:
                        break
                    }
                }
                onDoubleClicked: {
                    tmp.text=myModel1.getId(tableView.currentRow)
                    myModel2.updateModel()
                    myModel4.updateModel()
                    tableView.visible = !tableView.visible
                    tableView2.visible = !tableView2.visible
                    newL.visible = !newL.visible
                    tableView3.visible = !tableView3.visible
                    tableView4.visible = !tableView4.visible
                    rowLayout3.visible = !rowLayout3.visible
                    index.visible = !index.visible
//                    edit.visible = !edit.visible
                }
            }
        }
    }

    Menu {
        id: contextMenu

        MenuItem {
            text: qsTr("Remove")
            onTriggered: {

                dialogDelete.open()
            }
        }
    }


    MessageDialog {
        id: dialogDelete
        title: qsTr("Remove list")
        text: qsTr("Confirm the deletion of this list")
        icon: StandardIcon.Warning
        standardButtons: StandardButton.Ok | StandardButton.Cancel


        onAccepted: {
            database.removeRecord1(myModel1.getId(tableView.currentRow))
            myModel1.updateModel();
        }
    }

    TableView {
        id: tableView2
        anchors.top: tableView.bottom
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        anchors.margins: 5
        visible: true

        TableViewColumn {
            role: "name"
            title: "Name"
        }

        model: myModel3

        rowDelegate: Rectangle {
            anchors.fill: parent
            color: styleData.selected ? 'skyblue' : (styleData.alternate ? 'whitesmoke' : 'white');
            MouseArea {
                anchors.fill: parent
                acceptedButtons: Qt.RightButton | Qt.LeftButton
                onClicked: {
                    tableView2.selection.clear()
                    tableView.selection.clear()
                    tableView2.selection.select(styleData.row)
                    tableView2.currentRow = styleData.row
                    tableView2.focus = true
                    database.updateTable3(myModel3.getId(tableView2.currentRow))
                    switch(mouse.button) {
                    case Qt.RightButton:
                        contextMenu2.popup()
                        break
                    default:
                        break
                    }
                }

                onDoubleClicked: {
                    tmp.text=myModel3.getId(tableView2.currentRow)
                    myModel2.updateModel()
                    myModel4.updateModel()
                    tableView.selection.clear()
                    tableView2.selection.clear()
                    tableView3.selection.clear()
                    tableView4.selection.clear()
                    tableView.visible = !tableView.visible
                    tableView2.visible = !tableView2.visible
                    newL.visible = !newL.visible
                    tableView3.visible = !tableView3.visible
                    tableView4.visible = !tableView4.visible
                    rowLayout3.visible = !rowLayout3.visible
                    index.visible = !index.visible
//                  edit.visible = !edit.visible
                }
            }
        }
    }


    Menu {
        id: contextMenu2

        MenuItem {
            text: qsTr("Remove")
            onTriggered: {

                dialogDelete2.open()
            }
        }
    }


    MessageDialog {
        id: dialogDelete2
        title: qsTr("Remove list")
        text: qsTr("Confirm the deletion of this list")
        icon: StandardIcon.Warning
        standardButtons: StandardButton.Ok | StandardButton.Cancel


        onAccepted: {

            database.removeRecord1(myModel3.getId(tableView2.currentRow))
            myModel3.updateModel();
        }
    }

    Text {
         text: qsTr("")
         id: tmp
         visible: false
    }
    Button {
        id: index
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.margins: 5

        text: qsTr("My lists")
        visible: false

        onClicked: {
            index.visible = !index.visible
            tableView.visible = !tableView.visible
            tableView2.visible = !tableView2.visible
            newL.visible = !newL.visible
            tableView3.visible = !tableView3.visible
            tableView4.visible = !tableView4.visible
            rowLayout3.visible = !rowLayout3.visible
        }

    }
//    Button {
//        id: edit
//        anchors.top: parent.top
//        anchors.left: index.right
//        anchors.right: parent.right
//        anchors.margins: 5

//        text: qsTr("Edit")
//        visible: false

//        onClicked: {
//            index.visible = !index.visible
//            edit.visible = !edit.visible
//            tableView3.visible = !tableView3.visible
//            tableView4.visible = !tableView4.visible
//            rowLayout3.visible = !rowLayout3.visible
////            tableview5.visible != tableview5.visible
//        }

//    }
    TableView {
        id: tableView3
        anchors.top: index.bottom
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.margins: 5
        visible: false
        TableViewColumn {
            role: "checked"

            delegate: CheckBox{
                    id: checkbox1
                    checked:false
                    onClicked: {
                        tableView3.selection.clear()
                        tableView4.selection.clear()
                        tableView3.selection.select(styleData.row)
                        tableView3.currentRow = styleData.row
                        tableView3.focus = true
                        database.updateTable2c(tmp.text)
                        database.updateTable2(myModel2.getId(tableView3.currentRow))
                        tableView3.selection.clear()
                        checkbox1.checked = false

                        tableView4.selection.clear()
                        myModel1.updateModel();
                        myModel3.updateModel();
                        myModel2.updateModel();
                        myModel4.updateModel();
                    }
                }
        }
        TableViewColumn {
            role: "id"
            title: "ID"
        }
        TableViewColumn {
            role: "name"
            title: "Name"
        }
        model: myModel2


        rowDelegate: Rectangle {
            anchors.fill: parent
            color: styleData.selected ? 'skyblue' : (styleData.alternate ? 'whitesmoke' : 'white');
            MouseArea {
                anchors.fill: parent
                acceptedButtons: Qt.RightButton | Qt.LeftButton
                onClicked: {
                    switch(mouse.button) {
                    case Qt.RightButton:
                        contextMenu3.popup()
                        break
                    default:
                        break
                    }
                }
            }
        }
    }

    Menu {
        id: contextMenu3

        MenuItem {
            text: qsTr("Remove")
            onTriggered: {

                dialogDelete3.open()
            }
        }
    }

    MessageDialog {
        id: dialogDelete3
        title: qsTr("Remove list")
        text: qsTr("Confirm the deletion of this list")
        icon: StandardIcon.Warning
        standardButtons: StandardButton.Ok | StandardButton.Cancel

        onAccepted: {

            database.removeRecord2(myModel2.getId(tableView3.currentRow))
            myModel2.updateModel();
        }
    }

    RowLayout {
            id: rowLayout3
            anchors.top: tableView3.bottom
            anchors.left: parent.left

            anchors.margins: 5
            visible: false

            spacing: 10


            Text {text: qsTr("Id")}
            TextField {id: idFieldE}
            Text {text: qsTr("Name")}
            TextField { id: nameFieldE}
            Text {text: qsTr("Checked")}
            TextField {id: checkedFieldE}

            Button {
                text: qsTr("Add new element")

                onClicked: {
                    database.updateTable2d(checkedFieldE.text,tmp.text)
                    database.insertIntoTable2(idFieldE.text, nameFieldE.text , checkedFieldE.text, tmp.text)
                    myModel1.updateModel()
                    myModel3.updateModel()
                    myModel2.updateModel()
                    myModel4.updateModel()
                    idFieldE.text = ""
                    nameFieldE.text = ""
                    checkedFieldE.text = ""
                }
            }
        }

    TableView {
        id: tableView4
        anchors.top: rowLayout3.bottom
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        anchors.margins: 5
        visible: false

        TableViewColumn {
            role: "checked"

            delegate: CheckBox{
                    id: checkbox2
                    checked:true
                    onClicked: {
                        tableView4.selection.clear()
                        tableView3.selection.clear()

                        tableView4.selection.select(styleData.row)
                        tableView4.currentRow = styleData.row
                        tableView4.focus = true
                        database.updateTable2b(tmp.text)
                        database.updateTable2a(myModel4.getId(tableView4.currentRow))
                        tableView3.selection.clear()
                        checkbox2.checked = true
                        tableView4.selection.clear()
                        myModel1.updateModel();
                        myModel3.updateModel();
                        myModel2.updateModel();
                        myModel4.updateModel();
                    }
                }
        }

        TableViewColumn {
            role: "id"
            title: "ID"
        }
        TableViewColumn {
            role: "name"
            title: "Name"
        }

        model: myModel4

        rowDelegate: Rectangle {
            anchors.fill: parent
            color: styleData.selected ? 'skyblue' : (styleData.alternate ? 'whitesmoke' : 'white');
            MouseArea {
                anchors.fill: parent
                acceptedButtons: Qt.RightButton | Qt.LeftButton
                onClicked: {
                    switch(mouse.button) {
                    case Qt.RightButton:
                        contextMenu4.popup()
                        break
                    default:
                        break
                    }
                }
            }
        }
    }

    Menu {
        id: contextMenu4

        MenuItem {
            text: qsTr("Remove")
            onTriggered: {
                dialogDelete4.open()
            }
        }
    }

    MessageDialog {
        id: dialogDelete4
        title: qsTr("Remove list")
        text: qsTr("Confirm the deletion of this list")
        icon: StandardIcon.Warning
        standardButtons: StandardButton.Ok | StandardButton.Cancel

        onAccepted: {

            database.removeRecord2(myModel4.getId(tableView4.currentRow))
            myModel4.updateModel();
        }
    }
//    TableView{
//        id: tableview5
//        anchors.top: parent.top
//        anchors.left: parent.left
//        anchors.right: parent.right
//        anchors.margins: 5
//        visible: false
//        model: myModel5
//        TableViewColumn {
//            role: "id"
//            title: "ID"
//        }
//        TableViewColumn {
//            role: "name"
//            delegate: TextEdit{
//                    id: textbox

//                    onTextChanged: {
//                        database.updateTableNameE(textbox.text, newL.text)
//                        myModel1.updateModel();
//                        myModel3.updateModel();
//                        myModel2.updateModel();
//                        myModel4.updateModel();
//                        myModel5.updateModel();
//                    }
//                }
//        }

//    }
}

