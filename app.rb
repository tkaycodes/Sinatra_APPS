require 'sinatra'
require 'shotgun'
# require 'pony'

get '/' do 
  erb :welcome
end

get '/random_person_selector' do 
  if params[:p_names]
    # get names
    @name=params[:p_names]
    @name.pick_random
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
  #Pony.mail(:to => 'tabish003@hotmail.com', :from => 'tabish003@hotmail.com', :subject => 'sinatra app', :body => 'Hello there. A Personality quiz was just completed by somebody')
end

get '/team_organizer' do 
  erb :team_organizer
  if params[:people_names]
    @name = @name.s
  end
end


def pick_random
  # turn to array
  @name = @name.split(',')
  #remove all white trailing and leading whitespaces 
  @name = @name.map{|x|x.strip}
  #remove all empty strings
  @name = @name.reject{|x|x.empty?}
  @winner = @name.sample
end

