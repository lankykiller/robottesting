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

