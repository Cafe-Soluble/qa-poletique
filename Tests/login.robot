*** Settings ***
Resource    ../Resources/keywords.resource
Variables    ../Resources/variables.py
Library     SeleniumLibrary
Suite Teardown    Close All Browsers



*** Test Cases ***
Log In as a Simple User with Username
    [Documentation]    Ce test vérifie qu'il est possible de se connecter avec un compte utilisateur avec l'username
    Open Login Page
    Fill Login Form    ${USER_NAME}    ${ADMIN_PASSWORD}
    Verify Flash Message    Bienvenue ${USER_NAME} !
    Element Should Not Be Visible    css:[data-qa="admin-access-button"]

Log In as an Administrator with Username
    [Documentation]    Ce test vérifie qu'il est possible de se connecter avec un compte administrateur avec l'username
    Open Login Page
    Fill Login Form    ${ADMIN_NAME}    ${ADMIN_PASSWORD}
    Verify Flash Message    Bienvenue ${ADMIN_NAME} !
    Element Should Be Visible    css:[data-qa="admin-access-button"]

Log In as a Simple User with Email
    [Documentation]    Ce test vérifie qu'il est possible de se connecter sur un compte utilisateur avec l'email
    Open Login Page
    Fill Login Form    ${USER_EMAIL}    ${USER_PASSWORD}
    Verify Flash Message    Bienvenue ${USER_NAME} !
    Element Should Not Be Visible    css:[data-qa="admin-access-button"]

Log In as an Administrator with Email
    [Documentation]    Ce test vérifie qu'il est possible de se connecter avec un compte administrateur avec l'email
    Open Login Page
    Fill Login Form    ${ADMIN_EMAIL}    ${ADMIN_PASSWORD}
    Verify Flash Message    Bienvenue ${ADMIN_NAME} !
    Element Should Be Visible    css:[data-qa="admin-access-button"]

Fail Credentials
    [Documentation]    Ce test vérifie qu'il n'est pas possible de se connecter avec des identifiants incorrects et qu'un message d'erreur s'affiche
    Open Login Page

    Fill Login Form    WRONG-USERNAME   ${ADMIN_PASSWORD}
    Verify Flash Message    Mot de passe ou nom d'utilisateur incorrects
    Title Should Be    Connexion — ${TITLE}

    Fill Login Form    ${USER_EMAIL}    WRONG-PASSWORD
    Verify Flash Message    Mot de passe ou e-mail incorrects
    Title Should Be    Connexion — ${TITLE}

    Fill Login Form    ${USER_NAME}    WRONG-PASSWORD
    Verify Flash Message    Mot de passe ou nom d'utilisateur incorrects
    Title Should Be    Connexion — ${TITLE}

    Fill Login Form    ${ADMIN_NAME}    WRONG-PASSWORD
    Verify Flash Message    Mot de passe ou nom d'utilisateur incorrects
    Title Should Be    Connexion — ${TITLE}

    Close All Browsers




