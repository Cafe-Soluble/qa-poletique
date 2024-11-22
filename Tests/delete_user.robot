*** Settings ***
Documentation    Ce fichier vérifie que l'utilisateur peut être supprimé après s'être connecté.
Library    ../Librairies/EmailLibrary.py
Variables    ../Resources/variables.py
Resource    ../Resources/keywords.resource

Suite Teardown    Close All Browsers

*** Variables ***
${PASSWORD}      TestPassword123


*** Test Cases ***
Delete User After Signup And Login
    [Documentation]    Vérifie qu'il est possible de supprimer un utilisateur après sa création et connexion.
    Create New User
    Log In User
    Access Profil Page
    Delete User
    Verify User Deletion



*** Keywords ***
Create New User
    [Documentation]    Crée un nouvel utilisateur pour les tests de suppression.
    Sign-Up And Confirm Email    ${RANDOM_USERNAME}    ${RANDOM_EMAIL}

Log In User
    [Documentation]    Connecte l'utilisateur créé pour le test de suppression.
    Fill Login Form    ${RANDOM_USERNAME}    ${PASSWORD}
    Verify Flash Message    Bienvenue ${RANDOM_USERNAME} !

Delete User
    [Documentation]    Supprime l'utilisateur connecté pour vérifier la suppression de compte.
    # Ici vous allez ajouter les étapes nécessaires pour naviguer jusqu'à la section "Supprimer compte"
    # Exemple :
    Click Element    css:[data-qa="delete-account-button"]
    Element Should Be Visible    css:[data-qa="modal-warning"]
    Element Text Should Be    css:[data-qa="modal-warning"]    Avertissement
    Element Should Be Disabled    css:[data-qa="confirm-delete-account-button"]    # Le bouton doit être désativé tant que le mot de passe n'est pas renseigné
    Input Password    css:[data-qa="confirm-password-delete-account"]    ${PASSWORD}
    Element Should Be Enabled    css:[data-qa="confirm-delete-account-button"]
    Click Button    css:[data-qa="confirm-delete-account-button"]
    Verify Flash Message    Vous avez été déconnecté avec succès.
    Close Browser 


Access Profil Page
    [Documentation]    Accède à la page de profil de l'utilisateur
    Click Element    css:[data-qa="user-menu-button"]
    Click Element    css:[data-qa="user-profil"]

Verify User Deletion
    [Documentation]    Vérifie que l'utilisateur n'est plus en mesure de se connecter après la suppression.
    Open Login Page
    Fill Login Form    ${USER_NAME}    ${PASSWORD}
    Verify Flash Message    Mot de passe ou nom d'utilisateur incorrects
    Close Browser



