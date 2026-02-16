*** Settings ***
Library    Process
Library    RPA.Desktop
Library    OperatingSystem

Test Setup    Open Flameshot
Test Teardown    Close Flameshot

Resource    resource.robot


*** Test Cases ***
Test text is added
  
    ${left}    ${top}    ${right}    ${bottom}=    Screen Dimensions
    Capture Fullscreen    ${left}    ${top}    ${right}    ${bottom}
    
    Press keys    t
    Sleep    2s

    ${middle_x}    ${middle_y}=    Screen Middle    ${left}    ${top}    ${right}    ${bottom}
    Click    locator=coordinates:${middle_x},${middle_y}
    Sleep    1s

    Type text    test text
    Sleep    2s

    Press keys   ctrl  s
    Sleep    2s

    Type text    testfile.png
    Sleep     1s

    Press keys    enter

Arrow added

    ${left}    ${top}    ${right}    ${bottom}=    Screen Dimensions
    Capture Fullscreen    ${left}    ${top}    ${right}    ${bottom}

    Press keys    a
    Sleep    2s

    ${start_x}    ${start_y}    ${end_x}    ${end_y}=    Arrow Coordinates    ${left}    ${top}    ${right}    ${bottom}
    Draw Drag    ${start_x}    ${start_y}    ${end_x}    ${end_y}

    Press keys   ctrl  s
    Sleep    1s

    Type text    testfile_arrow.png
    Sleep     1s

    Press keys    enter

Shape added

    ${left}    ${top}    ${right}    ${bottom}=    Screen Dimensions
    Capture Fullscreen    ${left}    ${top}    ${right}    ${bottom}

    Press keys    c
    Sleep    2s

    ${middle_x}    ${middle_y}=    Screen Middle    ${left}    ${top}    ${right}    ${bottom}
    ${end_x}    ${end_y}=    Move Coordinates    ${middle_x}    ${middle_y}    100    100
    Draw Drag    ${middle_x}    ${middle_y}    ${end_x}    ${end_y}
    Sleep    2s

    Press keys   ctrl  s
    Sleep    1s

    Type text    testfile_shape.png
    Sleep    1s

    Press keys    enter

Blur added

    ${left}    ${top}    ${right}    ${bottom}=    Screen Dimensions
    Capture Fullscreen    ${left}    ${top}    ${right}    ${bottom}

    Press keys    b
    Sleep    2s

    ${middle_x}    ${middle_y}=    Screen Middle    ${left}    ${top}    ${right}    ${bottom}
    ${end_x}    ${end_y}=    Move Coordinates    ${middle_x}    ${middle_y}    100    100
    Draw Drag    ${middle_x}    ${middle_y}    ${end_x}    ${end_y}
    Sleep    2s

    Press keys   ctrl  s
    Sleep    1s

    Type text    testfile_blur.png
    Sleep    1s

    Press keys    enter
    
