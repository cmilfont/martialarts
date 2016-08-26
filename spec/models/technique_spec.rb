# encoding: UTF-8
require 'spec_helper'

describe Technique do
  
  describe ".search", %q{
    Como um usuário do sistema
      Eu quero pesquisar por técnicas
      Para que possa ver o video indexado
  } do
    
    let(:retorno) {
      {
        "hits" => {
              "hits" => [
                  {
                    "_id" => 2
                  }
                ]
          }        
      }
    }
    
    let(:ids) { [2] }
        
    it %q{
      Dado que eu tenha tecnicas indexados
      Quando buscar
      Então deveria trazer os modelos associados
    } do
      Technique.should_receive(:search_es).and_return retorno
      Technique.should_receive(:where).with id: ids 
      Technique.search("kata")
    end
  end
  
end
