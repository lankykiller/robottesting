*** Settings ***
Library    Process
Library    RPA.Desktop

Test Setup    Open Flameshot
Test Teardown    Close Flameshot

Resource    resource.robot

*** Variables ***

*** Test Cases ***
Full Screen Capture
    ${left}    ${top}    ${right}    ${bottom}=    Screen Dimensions
    Capture Fullscreen    ${left}    ${top}    ${right}    ${bottom}

Partial Screen Capture
    Capture Partial screen

Delayed Capture
    sleep    5.0
    ${left}    ${top}    ${right}    ${bottom}=    Screen Dimensions
    Capture Fullscreen    ${left}    ${top}    ${right}    ${bottom}
