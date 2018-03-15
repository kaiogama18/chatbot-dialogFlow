require 'sinatra'
require 'thin'
require 'json'
require 'pp'

require_relative './funcao'
set :port, 9000

require_relative './comandos'


post '/webhook' do 
    fb = Conexao.new();
    comando = Comandos.new();
    request_payload =  "#{ request.body.read }"
    request_json = JSON.parse(request_payload,symbolize_names: true)
    tag = fb.parseGetAction(request_json)
    messengerID = fb.parseGetId(request_json)
    aux = messengerID
    if tag == "action-cpf" 
        tag_resposta = fb.parseGetTagCpf(request_json)
        enviar = comando.Cpf(tag,tag_resposta)
        messageText = enviar
    elsif tag == "action-cep"
        tag_resposta = fb.parseGetTagCep(request_json)
        puts tag_resposta
        enviar = comando.Cep(tag,tag_resposta)    
        messageText = enviar
    elsif tag == "action-cnpj"
        tag_resposta = fb.parseGetTagCnpj(request_json)
        enviar = comando.Cnpj(tag,tag_resposta)
        messageText = enviar
    elsif tag == "action-mapa"
        tag_resposta = fb.parseGetTagRua(request_json)
        enviar = comando.Rua(tag_resposta)
        messageText = enviar
    end
    
    
    objJson = {
      :recipient => {:id   => messengerID},
      :message   => {:text => "OI"}
    }

      
    #fb.post(objJson1)

    
    fb.post(fb.messageText(messengerID,messageText))
end