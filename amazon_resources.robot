*** Settings ***
Library    SeleniumLibrary

*** Variables ***
${BROWSER}                                chrome
${URL}                                    http://www.amazon.com.br
${MENU_ELETRONICOS}                       //a[@href='/Livros/b/?ie=UTF8&node=6740748011&ref_=nav_cs_books'][contains(.,'Livros')]
${HEADER_ELETRONICOS}                     //h2[contains(.,'Loja de Livros')]
${CART_SUCCESS}                           //div[contains(@id,'SUCCESS')][contains(.,'Adicionado ao carrinho')]
${CART_DELETE}                            //input[@value='Excluir']

*** Keywords ***

Abrir o navegador
    Open Browser    browser=${BROWSER}
    Maximize Browser Window

Fechar o navegador
    Capture Page Screenshot
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

Digitar o nome do produto "${PRODUTO}" no campo de pesquisa
    Input Text    locator=twotabsearchtextbox    text=${PRODUTO}

Clicar no botão de pesquisa
    Click Element    locator=nav-search-submit-button

Verificar o resultado da pesquisa se está listando o produto "${PRODUTO}"
    Wait Until Element is Visible    locator=//h2[contains(.,'${PRODUTO}')]

Adicionar o produto "${PRODUTO}" no Carrinho
    Click Element    locator=(//a[@class='a-link-normal s-underline-text s-underline-link-text s-link-style a-text-normal'][contains(.,'${PRODUTO}')])[1]
    Wait Until Element Is Visible    locator=add-to-cart-button
    Click Element    locator=add-to-cart-button

Verificar se o produto "${$PRODUTO}" foi adicionado com sucesso
    Wait Until Element Is Visible    locator=${CART_SUCCESS}  timeout=30s

Remover o produto do carrinho
    Click Element    locator=//a[contains(@data-csa-c-type,'button')]
    Wait Until Element Is Visible    locator=${CART_DELETE}
    Click Element    locator=${CART_DELETE}

Verificar se o carrinho fica vazio
    Wait Until Element Is Visible    locator=//h1[contains(.,'vazio.')]  timeout=30s