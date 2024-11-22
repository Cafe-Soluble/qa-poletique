*** Settings ***
Resource    ../Resources/keywords.resource
Library    ../Librairies/EmailLibrary.py
Variables    ../Resources/variables.py



*** Test Cases ***
Access to Sign-Up Page
    [Documentation]    Vérifie que la page d'inscription est accessible depuis la page de connexion.
    Open Signup Page
    Close Browser

Sign-Up a New User
    [Documentation]    Vérifie qu'il est possible d'inscrire un nouvel utilisateur.
    Open Signup Page
    Fill Signup Form    ${RANDOM_USERNAME}    ${RANDOM_EMAIL}
    Verify Flash Message    Un mail de confirmation a été envoyé à ${RANDOM_EMAIL}

Sign-up Confirmation Email
    [Documentation]    Vérifie la bonne récéption du mail de confirmation et valide l'inscription.
    ${link} =    Wait For Email    ${IMAP}    ${IMAP_ACCOUNT}    ${IMAP_PASSWORD}    ${SENDER}    ${RANDOM_EMAIL}    timeout=300    delete_email=False
    Go To    ${link}
    Verify Flash Message    Votre compte a été confirmé avec succès.




