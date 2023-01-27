*** Settings ***
Library    SeleniumLibrary

*** Variables ***
${URL}                                    http://www.amazon.com.br
${MENU_ELETRONICOS}                       //a[@href='/Livros/b/?ie=UTF8&node=6740748011&ref_=nav_cs_books'][contains(.,'Livros')]
${HEADER_ELETRONICOS}                     //h2[contains(.,'Loja de Livros')]

*** Keywords ***

Abrir o navegador
    Open Browser    browser=chrome
    Maximize Browser Window

Fechar o navegador
    Close Browser

Acessar a home page do site Amazon.com.br
    Go To    url=${URL}
    Wait Until Element Is Visible    locator=${MENU_ELETRONICOS}

Entrar no menu "Livros"
    Click Element    locator=${MENU_ELETRONICOS}

Verificar se aparece a frase "${FRASE}"
    Wait Until Page Contains            text=${FRASE}
    Wait Until Element is Visible      locator=${HEADER_ELETRONICOS}

Verificar se o título da página fica "${TITULO}"
    Title Should Be    title=${TITULO}

Verificar se aparece a categoria "${NOME_CATEGORIA}"
    Element Should Be Visible    locator=//a[@aria-label='${NOME_CATEGORIA}']

Digitar o nome do produto "Xbox Series S" no campo de pesquisa
Clicar no botão de pesquisa
Verificar o resultado da pesquisa se está listando o produto pesquisado