require 'sinatra'
require 'sinatra/reloader'

def reset_game
  @@guesses_remaining = 5
  @@secret_number = rand(100)
end

def lost_game
  reset_game
  " You lost. A new number has been generated."
end

def check_guess(guess, secret_number)
  if guess
    if guess.to_i > (secret_number + 5)
      @@guesses_remaining -= 1
      "Way too high!"
    elsif guess.to_i < (secret_number - 5)
      @@guesses_remaining -= 1
      "Way too low!"
    elsif guess.to_i > secret_number
      @@guesses_remaining -= 1
      "Too high!"
    elsif guess.to_i < secret_number
      @@guesses_remaining -= 1
      "Too low!"
    else
      reset_game
      "You got it right! The secret number is #{secret_number}."
    end
  else
    "Guess a number (0-99)."
  end
end

reset_game

get '/' do
  guess = params['guess']
  message = check_guess(guess, @@secret_number)
  message += lost_game if @@guesses_remaining < 1

  erb :index, :locals =>
                {:secret_number => @@secret_number,
                 :message => message}
end
