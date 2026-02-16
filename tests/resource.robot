*** Settings ***
Library    Process
Library    RPA.Desktop

*** Variables ***

*** Keywords ***
Open Flameshot
    Start Process    flameshot    gui
    sleep    1.0

Close Flameshot
    Press Keys    ESC
    Sleep    0.5
    Run Process    taskkill    /IM    flameshot.exe    /F

Screen Dimensions
    ${region}=    Get Display Dimensions
    RETURN    ${region.left}    ${region.top}    ${region.right}    ${region.bottom}

Capture Fullscreen
    [Arguments]    ${left}    ${top}    ${right}    ${bottom}
    Move Mouse    locator=coordinates:${left},${top}
    Press Mouse Button    button=left
    Sleep    0.5

    ${r}=   Set Variable    ${left}
    ${b}=  Set Variable    ${top}


    WHILE    ${r} < ${right} or ${b} < ${bottom}
        ${r}=    Evaluate    ${r}+100
        ${b}=    Evaluate    ${b}+100
        Move Mouse    locator=coordinates:${r},${b}
        sleep    0.01
    END

    Release Mouse Button    button=left
    sleep    1.5

Capture Partial screen
    ${left}    ${top}    ${right}    ${bottom}=    Screen Dimensions

    ${left}=     Evaluate    ${left}+200
    ${top}=      Evaluate    ${top}+200
    ${right}=    Evaluate    ${right}-200
    ${bottom}=   Evaluate    ${bottom}-200

    Capture Fullscreen    ${left}    ${top}    ${right}    ${bottom}
    sleep    1.5

Screen Middle
    [Arguments]    ${left}    ${top}    ${right}    ${bottom}
    ${middle_x}=    Evaluate    int((${left}+${right})/2)
    ${middle_y}=    Evaluate    int((${top}+${bottom})/2)
    RETURN    ${middle_x}    ${middle_y}

Arrow Coordinates
    [Arguments]    ${left}    ${top}    ${right}    ${bottom}    ${end_margin}=100    ${start_x_ratio}=0.25    ${start_y_ratio}=0.5
    ${start_x}=    Evaluate    int(${left} + (${right} - ${left}) * ${start_x_ratio})
    ${start_y}=    Evaluate    int(${top} + (${bottom} - ${top}) * ${start_y_ratio})
    ${end_x}=    Evaluate    int(${right} - ${end_margin})
    ${end_y}=    Evaluate    int(${bottom} - ${end_margin})
    RETURN    ${start_x}    ${start_y}    ${end_x}    ${end_y}

Move Coordinates
    [Arguments]    ${x}    ${y}    ${dx}    ${dy}
    ${nx}=    Evaluate    int(${x}+${dx})
    ${ny}=    Evaluate    int(${y}+${dy})
    RETURN    ${nx}    ${ny}

Draw Drag
    [Arguments]    ${start_x}    ${start_y}    ${end_x}    ${end_y}    ${press_delay}=0.2s    ${move_delay}=0.5s
    Move Mouse    locator=coordinates:${start_x},${start_y}
    Press Mouse Button    button=left
    Sleep    ${press_delay}
    Move Mouse    locator=coordinates:${end_x},${end_y}
    Sleep    ${move_delay}
    Release Mouse Button    button=left
    Sleep    1s

