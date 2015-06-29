require 'sinatra'
require 'sinatra/reloader'


def check_guess(guess, secret_number)
  if guess
    if guess.to_i > (secret_number + 5)
      "Way too high!"
    elsif guess.to_i < (secret_number - 5)
      "Way too low!"
    elsif guess.to_i > secret_number
      "Too high!"
    elsif guess.to_i < secret_number
      "Too low!"
    else
      "You got it right! The secret number is #{secret_number}."
    end
  else
    "Guess a number (0-99)."
  end
end

set :secret_number, rand(100)

get '/' do
  guess = params['guess']
  message = check_guess(guess, settings.secret_number)

  erb :index, :locals =>
                {:secret_number => settings.secret_number,
                 :message => message}
end
