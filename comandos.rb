require "brcep"
require "cpf_cnpj"

require_relative './funcao'


class Comandos
    # Função para validar o Cpf
    def Cpf(tag,texto)
        if tag == "action-cpf"
            cpf = texto.to_i
            aux =  CPF.valid?(cpf) 
            puts aux
            respostaCpf = 'Cpf Inválido' 
            return respostaCpf
        end
    end    

    # Função para validar o Cep
    def Cep(tag,texto)
        if tag == "action-cep"
            cep = texto.to_i
            endereco = BuscaEndereco.cep(cep)
            autenticado = endereco.to_s
            puts autenticado    
            return autenticado
        end
    end

    def organizar(string)
        str = string
        aux = str.gsub(/{:tipo_logradouro=>/, "Endereço: ")
        aux = aux.gsub(/"/, "")
        aux = aux.gsub(/, :logradouro=>/, " ")     
        aux = aux.gsub(/ :bairro=>/, " ")
        aux = aux.gsub(/ :cidade=>/, " Cidade: ")
        aux = aux.gsub(/, :uf=>/, ", Estado: ")
        aux = aux.gsub(/, :cep=>/, ", Cep informado: ")
        aux = aux.gsub(/}/, "")
        return aux    
    end    
end








