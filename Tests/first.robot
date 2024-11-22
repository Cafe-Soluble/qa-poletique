*** Settings ***
Documentation     Ouverture de navigateur pour vérification fonctionnelle
Library    SeleniumLibrary
Variables    ../Resources/variables.py

*** Test Cases ***
Ouvrir Firefox et accéder à Google
    Open Browser    https://www.google.fr    firefox
    Title Should Be    title=Google
    Close Browser
