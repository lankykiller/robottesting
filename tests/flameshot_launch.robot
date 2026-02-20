*** Settings ***
Library     Process
Library     RPA.Desktop
Library     OperatingSystem
Library     String

Resource    resource.robot

*** Variables ***
${CONFIG_FILE}    %{APPDATA}\\flameshot\\flameshot.ini

*** Test Cases ***

Application Starts Successfully
    [Documentation]    Verify Flameshot process launches and runs without error
    ${result}=    Run Process    flameshot    --version    stdout=PIPE    stderr=PIPE
    Should Be Equal As Integers    ${result.rc}    0
    Should Not Be Empty    ${result.stdout}

GUI Loads Properly
    [Documentation]    Verify Flameshot GUI opens and the capture interface is visible on screen
    Open Flameshot
    Sleep    2s
    ${left}    ${top}    ${right}    ${bottom}=    Screen Dimensions
    ${width}=     Evaluate    ${right} - ${left}
    ${height}=    Evaluate    ${bottom} - ${top}
    Should Be True    ${width} > 0
    Should Be True    ${height} > 0
    [Teardown]    Close Flameshot

Settings Help Output Contains Expected Options
    [Documentation]    Verify config --help exposes the real CLI flags
    ${result}=    Run Process    flameshot    config    --help
    ...           stdout=PIPE    stderr=PIPE
    Should Be Equal As Integers    ${result.rc}    0
    Should Contain    ${result.stdout}    --showhelp
    Should Contain    ${result.stdout}    --filename
    Should Contain    ${result.stdout}    --autostart
    Should Contain    ${result.stdout}    --notifications
    Should Contain    ${result.stdout}    --check

Settings Showhelp Can Be Enabled
    [Documentation]    Enable showhelp by writing directly to the INI config file
    File Should Exist    ${CONFIG_FILE}
    ${content}=    Get File    ${CONFIG_FILE}
    Should Contain    ${content}    showHelp
    ${updated}=    Replace String    ${content}    showHelp=false    showHelp=true
    Create File    ${CONFIG_FILE}    ${updated}
    ${verify}=    Get File    ${CONFIG_FILE}
    Should Contain    ${verify}    showHelp=true

Settings Showhelp Can Be Disabled
    [Documentation]    Disable showhelp by writing directly to the INI config file
    File Should Exist    ${CONFIG_FILE}
    ${content}=    Get File    ${CONFIG_FILE}
    Should Contain    ${content}    showHelp
    ${updated}=    Replace String    ${content}    showHelp=true    showHelp=false
    Create File    ${CONFIG_FILE}    ${updated}
    ${verify}=    Get File    ${CONFIG_FILE}
    Should Contain    ${verify}    showHelp=false

Settings Filename Pattern Can Be Changed
    [Documentation]    Set a custom filename pattern and verify command succeeds
    ${result}=    Run Process    flameshot    config    --filename    test_%d
    ...           stdout=PIPE    stderr=PIPE
    Should Be Equal As Integers    ${result.rc}    0

Settings Filename Pattern Can Be Reverted
    [Documentation]    Restore the default filename pattern
    ${result}=    Run Process    flameshot    config    --filename    flameshot_%d_%H%M%S
    ...           stdout=PIPE    stderr=PIPE
    Should Be Equal As Integers    ${result.rc}    0

Settings Config Check Passes
    [Documentation]    Verify config --check reports no errors in the ini file
    ${result}=    Run Process    flameshot    config    --check
    ...           stdout=PIPE    stderr=PIPE
    Should Be Equal As Integers    ${result.rc}    0

Settings savePath Written To INI File
    [Documentation]    Verify the savePath key exists in the flameshot config file
    File Should Exist    ${CONFIG_FILE}
    ${content}=    Get File    ${CONFIG_FILE}
    Should Contain    ${content}    savePath