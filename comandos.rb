#require 'correios-cep'

#class Validar_Cep
#    def validacao(tag){
#        finder = Correios::CEP::AddressFinder.new
#        address = finder.get(message.text)
#    }
#end

#class Cep
#    def validacao_cep(tag)
#        puts tag
#
#        message = {
#            "recipient":{
#                "id": '2350817118277406'
#            },
#            "message":{
#
#                "text": 'Está dentro da validação cep ;)'
#            }
#        }
#        post(message)
#    end    
#end