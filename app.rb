require 'sinatra'
require 'shotgun'

get '/' do 
  erb :welcome
end

get '/random_person_selector' do 
  if params[:p_names]
    # get names
    @name=params[:p_names]
    # turn to array
    @name = @name.split(',')
    #remove all white trailing and leading whitespaces 
    @name = @name.map{|x|x.strip}
    #remove all empty strings
    @name = @name.reject{|x|x.empty?}
    @winner = @name.sample
  else
    @winner = ""
  end
  erb :random_person_selector
end

get '/personality_test' do 
  erb :personality_test
end

get '/results' do 
  erb :results 
end
