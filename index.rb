require 'sinatra'
require 'thin'
require 'json'
require 'pp'

require_relative './funcao'
set :port, 8000

require_relative './comandos'


post '/webhook' do 
    fb = Conexao.new();
    comando = Comandos.new();
    request_payload =  "#{ request.body.read }"
    request_json = JSON.parse(request_payload,symbolize_names: true)
    tag = fb.parseGetAction(request_json)
=begin  
    message = {
        "recipient":{
            "id": '2350817118277406'
        },
        "sender_action":"typing_on"
       
    }
=end



    if tag == "action-cpf"
        tag_resposta = fb.parseGetTagCpf(request_json)
        enviar = comando.Cpf(tag,tag_resposta)
    elsif tag == "action-cep"
        tag_resposta = fb.parseGetTagCep(request_json)
        enviar = comando.Cep(tag,tag_resposta)    
        #enviar = comando.Organizar(enviar)
    elsif tag == "action-cnpj"
        tag_resposta = fb.parseGetTagCnpj(request_json)
        enviar = comando.Cnpj(tag,tag_resposta)
    end
    
    
    
    messageText = enviar
    messengerID = fb.parseGetId(request_json)
    
   
    
    
    fb.post(fb.messageText(messengerID,messageText))
end