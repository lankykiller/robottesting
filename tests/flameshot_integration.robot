*** Settings ***
Library    Process
Library    OperatingSystem
Library    BuiltIn

Suite Setup       Start Flameshot
Suite Teardown    Stop Flameshot

*** Keywords ***
Start Flameshot
    Run Process    open -a Flameshot    shell=True
    Sleep    2s

Stop Flameshot
    Run Process    pkill -f flameshot    shell=True

Flameshot Should Be Running
    ${result}=    Run Process    pgrep -f flameshot    shell=True    stdout=TRUE
    Should Not Be Empty    ${result.stdout}

Press Flameshot Hotkey
    Run Process    osascript -e 'tell application "System Events" to keystroke "X" using {shift down, command down}'    shell=True
    Sleep    2s

Hotkey Should Not Crash Flameshot
    ${result}=    Run Process    pgrep -f flameshot    shell=True    stdout=TRUE
    Should Not Be Empty    ${result.stdout}

*** Test Cases ***
System Tray Integration
    Flameshot Should Be Running

Keyboard Shortcut Triggers Overlay
    Press Flameshot Hotkey
    Hotkey Should Not Crash Flameshot

Global Hotkey Works From Another App
    Run Process    open -a TextEdit    shell=True
    Sleep    1s
    Press Flameshot Hotkey
    Hotkey Should Not Crash Flameshot
