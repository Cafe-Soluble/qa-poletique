*** Settings ***
Library    SeleniumLibrary
Library    ../Librairies/EmailLibrary.py

Variables    variables.py

*** Keywords ***
Open Signup Page
    Open Browser    ${URL}    ${BROWSER}
    Go To    ${URL}
    Title Should Be    ${TITLE}
    Click Link    /users/login
    Page Should Contain    text=Pas encore de compte ? Inscrivez-vous !
    Click Link    /users/signup
    Title Should Be    S'inscrire — ${TITLE}

Fill Signup Form
    [Arguments]    ${username}    ${email}
    Input Text    id=username    ${username}
    Input Text    id=email    ${email}
    Input Password    id=password    ${PASSWORD}
    Input Password    id=confirm_password    ${PASSWORD}
    Click Button    S'inscrire

Verify Flash Message
    [Arguments]    ${expected_flash_message}
    Wait Until Element Is Visible    css=.alert-message    timeout=20s
    ${alert_text}=    Get Text    css=.alert-message
    Should Be Equal As Strings    ${alert_text}    ${expected_flash_message}

Open Login Page
    Open Browser    ${URL}    ${BROWSER}
    Go To    ${URL}
    Title Should Be    ${TITLE}
    Click Link    /users/login
    Title Should Be    Connexion — ${TITLE}

Fill Login Form
    [Arguments]    ${username}    ${password}
    Input Text    id=username    ${username}
    Input Password    id=password    ${password}
    Click Button    Se connecter

Sign-Up And Confirm Email
    [Documentation]    Créer et valider un nouvel utilisateur
    [Arguments]    ${username}    ${email}
    Open Signup Page
    Fill Signup Form    ${username}    ${email}
    Verify Flash Message    Un mail de confirmation a été envoyé à ${email}
    ${link} =    Wait For Email    ${IMAP}    ${IMAP_ACCOUNT}    ${IMAP_PASSWORD}    ${SENDER}    ${email}    timeout=300    delete_email=False
    Go To    ${link}
    Verify Flash Message    Votre compte a été confirmé avec succès.


