require 'sinatra'
require 'thin'
require 'json'
require 'pp'

require_relative './funcao'
require_relative './comandos'
set :port, 8000

post '/webhook' do 
    fb = Facebook.new();
    request_payload =  "#{ request.body.read }"
    request_json = JSON.parse(request_payload,symbolize_names: true)
    tag = fb.parseGetAction(request_json)
    
    Cep.new(tag)
    Cpf.new(tag)
    
    if tag == "Bot"
        messageText = 'Final'
    end
     
    messengerID = fb.parseGetId(request_json)
    fb.post(fb.messageText(messengerID,messageText))
end