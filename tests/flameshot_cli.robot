*** Settings ***
Library    Process

*** Test Cases ***
Flameshot Help Command Works
    ${result}=    Run Process    flameshot    --help    stdout=PIPE    stderr=PIPE
    Should Be Equal As Integers    ${result.rc}    0
    Should Contain    ${result.stdout}    Flameshot
    Should Contain    ${result.stdout}    Usage:
    Should Contain    ${result.stdout}    Options:
    Should Contain    ${result.stdout}    Subcommands:




