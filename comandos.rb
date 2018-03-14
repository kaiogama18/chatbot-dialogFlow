
# Função para validar o Cep
class Cep
    def initialize(tag)
        if tag == "action-cep"
            puts tag
            resposta = 'Cep Inválido'
            Resposta_texto.new(resposta)
        end
    end    
end

# Função para validar o Cpf
class Cpf
    def initialize(tag)
        if tag == "action-cpf"
            puts tag
            resposta = 'Cpf Inválido'
            Resposta_texto.new(resposta)
        end
    end    
end


class Resposta_texto
    def initialize(resposta)
        message = {
            "recipient":{
                "id": '2350817118277406'
            },
            "message":{
                "text": resposta
            }
        }
        post(message)
    end
end