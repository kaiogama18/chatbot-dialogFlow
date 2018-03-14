require 'sinatra'
require 'thin'
require 'json'
require 'pp'

require_relative './funcao'
require_relative './comandos'
set :port, 8000

post '/webhook' do 
    fb = Conexao.new();
    comando = Comandos.new();
    request_payload =  "#{ request.body.read }"
    request_json = JSON.parse(request_payload,symbolize_names: true)
    tag = fb.parseGetAction(request_json)
    resposta = fb.parseGetResposta(request_json)
    
    if tag == "action-cpf"
        enviar = comando.Cpf(tag,resposta)
    elsif tag == "action-cep"
        enviar = comando.Cep(tag,resposta)    
        enviar = comando.organizar(enviar)
    
    end
    messageText = enviar
    messengerID = fb.parseGetId(request_json)
    fb.post(fb.messageText(messengerID,messageText))
end