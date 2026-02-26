*** Settings ***
Library    Process
Library    OperatingSystem
Library    RPA.Desktop

Resource    resource.robot

*** Keywords ***

*** Variables ***
${OUTPUT_DIR}    ${CURDIR}${/}output
${FILE_PATH}    D:\\minel\\Pictures\\local_folder_gui.png   

*** Test Cases ***
Take Screenshot And Save To Local Folder CLI
    Create Directory    ${OUTPUT_DIR}

    ${result}=    Run Process
    ...    flameshot
    ...    full
    ...    --path
    ...    ${OUTPUT_DIR}${/}test_picture.png
    Should Be Equal As Integers    ${result.rc}    0

    File Should Exist    ${OUTPUT_DIR}${/}test_picture.png
    Sleep    1s
    Run Keyword And Ignore Error    Remove File    ${OUTPUT_DIR}${/}test_picture.png

Take Screenshot And Save To Clipboard CLI
    Start Process    flameshot
    ${result}=    Run Process
    ...    flameshot
    ...    full
    ...    --clipboard
    Should Be Equal As Integers    ${result.rc}    0

    ${clip}=    Run Process    
    ...    powershell    
    ...    Get-Clipboard -Format Image   
    ...    shell=True
    Should Be Equal As Integers    ${clip.rc}    0

Take Screenshot And Save To Local Folder GUI
    Open Flameshot
    ${left}    ${top}    ${right}    ${bottom}=    Screen Dimensions
    Capture Fullscreen    ${left}    ${top}    ${right}    ${bottom}

    Press Keys    ctrl  s
    Sleep    1s
    Type Text    local_folder_gui.png
    Sleep    1s
    Press Keys    enter
    Sleep    1s

    File Should Exist    ${FILE_PATH}
    Sleep    1s
    Run Keyword And Ignore Error    Remove File    ${FILE_PATH}

Take Screenshot And Save To Clipboard GUI
    Open Flameshot
    ${left}    ${top}    ${right}    ${bottom}=    Screen Dimensions
    Capture Fullscreen    ${left}    ${top}    ${right}    ${bottom}

    Press Keys    ctrl  c
    Sleep    1s

    ${clip}=    Run Process    
    ...    powershell    
    ...    Get-Clipboard -Format Image   
    ...    shell=True
    Should Be Equal As Integers    ${clip.rc}    0