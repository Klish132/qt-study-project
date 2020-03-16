import QtQuick 2.13
import QtQuick.Window 2.13
import QtQuick.Controls 2.5

Window {
    id: window
    visible: true
    width: 280
    height: 500
    title: "Authorization"
    property int instance: 1

    // Sign in top text
    Text {
        id: titleTextLogin
        text: (instance == 1) ? "SIGN IN" : "SIGN UP"
        color: "#404040"
        font.pixelSize: 25
        anchors.top: top
        anchors.topMargin: 10
        anchors.horizontalCenter: parent.horizontalCenter
    }
    // Sign in fields column
    Column {
        id: signInColumn
        anchors.top: titleTextLogin.bottom
        anchors.topMargin: 10
        anchors.horizontalCenter: parent.horizontalCenter
        spacing: 10
        visible: instance
        // Login field
        TextField {
            id: signInField1
            width: window.width - 20
            font.pixelSize: 16
            placeholderText: "Login"
        }
        // Password field
        TextField {
            id: signInField2
            width: window.width - 20
            font.pixelSize: 16
            placeholderText: "Password"
        }
        // Sign in button
        Button {
            id: signInButton
            text: "Sign in"
            anchors.horizontalCenter: parent.horizontalCenter
            enabled: signInField1.length >= 5 && signInField2.length >= 5
            onClicked: {
                loadingIndicatorOpacity.start()
            }
        }
    }
    // Sign up fields column
    Column {
        id: signUpColumn
        anchors.top: titleTextLogin.bottom
        anchors.topMargin: 10
        anchors.horizontalCenter: parent.horizontalCenter
        spacing: 10
        visible: !instance
        // Login field
        TextField {
            id: signUpField1
            width: window.width - 20
            font.pixelSize: 16
            placeholderText: "Login"
        }
        // Password field
        TextField {
            id: signUpField2
            width: window.width - 20
            font.pixelSize: 16
            placeholderText: "Password"
        }
        // Repeat pasword field
        TextField {
            id: signUpField3
            width: window.width - 20
            font.pixelSize: 16
            placeholderText: "Repeat password"
        }
        // Nickname field
        TextField {
            id: signUpField4
            width: window.width - 20
            font.pixelSize: 16
            placeholderText: "Nickname"
        }
        // Sign up button
        Button {
            id: signUpButton
            text: "Sign up"
            anchors.horizontalCenter: parent.horizontalCenter
            enabled: signUpField1.length >= 5 && signUpField2.length >= 5 && signUpField3.length >= 5 && signUpField4.length >= 5
            onClicked: {
                loadingIndicatorOpacity.start()
            }
        }
    }
    // Loading Indicator
    BusyIndicator {
        id: loadingIndicator
        anchors.top: (instance == 1) ? signInColumn.bottom : signUpColumn.bottom
        anchors.topMargin: 10
        anchors.horizontalCenter: parent.horizontalCenter
        width: 50; height: 50
        running: true
        opacity: 0
        // Opacity animation
        OpacityAnimator{
            target: loadingIndicator
            id: loadingIndicatorOpacity
            from: 0;
            to: 1;
            duration: 1000
            running: false
        }
    }
    // Bottom row
    Row {
        id: promptRow
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 10
        anchors.horizontalCenter: parent.horizontalCenter
        spacing: 10
        // Sign in prompt button
        Text {
            id: signInPrompt
            text: "Sign in"
            font.pixelSize: 16
            color: "#404040"
            font.underline: instance
            MouseArea {
                id: signInPromptArea
                enabled: !instance
                anchors.fill: parent
                cursorShape: Qt.PointingHandCursor
                onClicked: {
                    window.instance = 1
                    signUpField1.text = ""
                    signUpField2.text = ""
                    signUpField3.text = ""
                    signUpField4.text = ""
                    loadingIndicatorOpacity.stop()
                    loadingIndicator.opacity = 0
                }
            }
        }
        Text {
            id: slash
            text: "/"
            font.pixelSize: 16
            color: "#404040"
        }
        // Sign up prompt button
        Text {
            id: signUpPrompt
            text: "Sign up"
            font.pixelSize: 16
            color: "#404040"
            font.underline: !instance
            MouseArea {
                id: signUpPromptArea
                enabled: instance
                anchors.fill: parent
                cursorShape: Qt.PointingHandCursor
                onClicked: {
                    window.instance = 0
                    signInField1.text = ""
                    signInField2.text = ""
                    loadingIndicatorOpacity.stop()
                    loadingIndicator.opacity = 0
                }
            }
        }
    }
}
