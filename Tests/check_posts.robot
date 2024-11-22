*** Settings ***
Documentation    Ce fichier vient compter le nombre de publications d'un utilisateur et le comparer à la data affichée dans son profil
Variables    ../Resources/variables.py
Resource    ../Resources/keywords.resource
Library    Dialogs

*** Variables ***
${USER}    Utilisateur

*** Test Cases ***
Compare Actual Number of User Posts With Displayed Count
    [Documentation]    Vérifier que le nombre de posts affichés pour un utilisateur correspond au nombre de posts effectifs publiés.
    Open Browser    ${URL}
    Go To the User Stats Page
    ${DISPLAYED_POSTS_NUMBER}=    Get Publications Number
    ${COUNTED_POSTS_NUMBER}=    Count Publications User
    Should Be Equal As Integers    ${DISPLAYED_POSTS_NUMBER}    ${COUNTED_POSTS_NUMBER}    msg=Le nombre de publications réelles (${COUNTED_POSTS_NUMBER}) diffère du nombre attendu (${DISPLAYED_POSTS_NUMBER}).
    Close Browser

*** Keywords ***
Go To the User Stats Page
    Go To   ${URL}/users/user/${USER}
    Title Should Be    Profil de ${USER} — ${TITLE}

Get Publications Number
    ${publications_text}=    Get Text    css:[data-qa="publications"]
    ${publication_number}=    Convert To Integer    ${publications_text.split()[0]}
    Log    Number of Publications: ${publication_number}
    ${message}=    Set Variable    Le nombre de publications est : ${publication_number}
    # Execute Manual Step    ${message}    title=Publication Info
    Log    ${message}
    RETURN    ${publication_number}

Count Publications User
    # Récupère la liste des éléments pour chaque nom d'utilisateur
    Go To    ${URL}
    # Initialisation de la variable de comptage
    ${count}=    Set Variable    0
    
    WHILE    True
        ${usernames}=    Get WebElements    css:[data-qa="article-author-name"]

        # Boucle sur chaque élément trouvé
        FOR    ${username_element}    IN    @{usernames}
            ${username_text}=    Get Text    ${username_element}
            IF    '${username_text}' == '${USER}'
                ${count}=    Evaluate    ${count} + 1

            END 
        END
        
        ${is_visible}=    Run Keyword And Return Status    Element Should Be Visible    css:[data-qa="next-page"]
        IF    ${is_visible}
            Click Element    css:[data-qa="next-page"]
        ELSE
            BREAK
        END
        Sleep    0.5s
    END
    RETURN    ${count}

    