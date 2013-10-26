require 'integration_helper'

feature "Minhas TAGs em uma técnica", %q{
  Como um usuário cadastrado
  Eu quero criar uma Tag
  E associar uma técnica a essa Tag
} do
  background do
    @id = 1

    FactoryGirl.create(:user, admin: true).tap do |user|
      login_as(user, scope: :user, run_callbacks: false)
      @technique = create_technique_mocking_elasticsearch(id: @id, name: "Anaconda Choke", user: user)
      FactoryGirl.create(:tag, user: user, name: "strangleholds").tap do |tag|
        FactoryGirl.create(:tag_technique, tag: tag, technique: @technique)
      end
    end

    FactoryGirl.create(:user, admin: true, name: "Renata").tap do |user|
      FactoryGirl.create(:tag, user: user, name: "strangleholds").tap do |tag|
        FactoryGirl.create(:tag_technique, tag: tag, technique: @technique)
      end
    end

  end

  scenario "Listar Tags", :js => true, :driver => :webkit do
    visit technique_path(@technique)
    fill_in "tags", :with => "strangleholds"
    page.driver.browser.execute_script "$('input#tags').keydown();"
    expect(page).to have_content 'strangleholds'
  end

end

#Cenário: Listar Tags
#Dado que eu digitei "strangleholds" em "tags"
#Quando terminar de digitar
#Então eu deveria ver a lista de minhas Tags e de outros usuários para escolher:
#| name          | user      |
#| strangleholds | cmilfont  |
#| strangleholds | renata    |

#  Cenário: Criar uma TAG
#    Dado que eu escrevi uma TAG e não apareceu na listagem
#    Quando eu apertar enter
#    Então eu deveria ver "TAG criada e técnica indexada com sucesso"
#
#  Cenário: Indexar técnica à TAG
#    Dado uma lista de tags
#    Quando eu clicar em uma delas que pertence a mim
#    Então eu deveria ver "Técnica indexada com sucesso na tag"
#
#  Cenário: Adicionar dois números
#    Dado uma lista de tags
#    Quando eu clicar em uma delas que não pertence a mim
#    Então eu deveria criar uma nova Tag para meu usuário e indexar a técnica a essa nova tag
#
#  Cenário: Adicionar dois números
#    Dado um nome de uma tag na tela de uma técnica
#    Quando eu passar o Mouse
#    Então eu deveria ver um link para remover a tag
#
#  Cenário: Adicionar dois números
#    Dado um link para remover a tag
#    Quando eu clicar em remover
#    Então a técnica deve deixar de ser indexada por essa tag