require 'sinatra'
require 'shotgun'
# require 'pony'
require 'pry'

get '/' do 
  erb :welcome
end

get '/random_person_selector' do 
  if params[:p_names]
    # get names
    pick_random(params[:p_names])
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
  # if user enters both team members and x number of teams
  if params[:people_names] && params[:number_of_teams]
    names = params[:people_names]
    # sort_string is helper method - see below
    sort_string(names)
    # binding.pry
    teams = params[:number_of_teams]
    if names.length < teams.to_i
      @uneventeams = true;
      # binding.pry
    # if evenly divisible
    elsif teams.to_i === 0
      @dividebyzero = true;
    elsif @list.length%teams.to_i == 0
      @eachteam = @list.length/teams.to_i
      @teams = @list.each_slice(@eachteam).to_a
      puts "here are the teams #{@teams}"
    # if not evenly divisible
    else
      @eachteam = @list.length.divmod(teams.to_i)
      # divmod returns array where array[0]=quotent, array[1]=remaineder
      # @teams = @eachteam
      @extras = @list.shift(@eachteam[1])
      @whatsleft = @list
      puts "#{@eachteam[0]}"
      @teams = @whatsleft.each_slice(@eachteam[0]).to_a
      # puts " here are the teams #{@teams}, but also #{@eachteam[1]} left over"
      puts "here are the teams #{@teams}, here are the extras #{@extras}"

      @extras.each do |x| 
        @teams.sample.push(x)
      end

      puts "heres the final teams #{@teams}"
    end

  end
  # end of if statement 

  erb :team_organizer
end


# helper methods

helpers do 
  # converts string to array, picks a random array value
  def pick_random(list)
      # turn to array
      list = list.split(',')
      #remove all white trailing and leading whitespaces 
      list = list.map{|x|x.strip}
      #remove all empty strings
      list = list.reject{|x|x.empty?}
    @winner = list.sample
  end

  # converts string to array, formats it 
  def sort_string(list)
    # turn to array
    list = list.split(',')
    #remove all white trailing and leading whitespaces 
    list = list.map{|x|x.strip}
    #remove all empty strings
    @list = list.reject{|x|x.empty?}
  end
end





