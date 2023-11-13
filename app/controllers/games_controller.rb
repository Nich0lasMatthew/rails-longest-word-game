require 'open-uri'
require 'json'

class GamesController < ApplicationController
  def new
    @letters = ('A'..'Z').to_a.sample(10)
  end

  def validate
    user_input = params[:input].upcase
    letters = params[:letters].split
    @result = valid_input?(user_input, letters)
  end

  def score
    @letters = params[:letters].split
    word = params[:input].upcase
    @result = check_word(word) && valid_input?(word, @letters)
    @score = @result ? "Congratulations #{word} is an English word" : "Sorry, #{word} is not an English word"
  end

  def valid_input?(input, letters)
    input.chars.all? { |letter| letters.include?(letter) }
  end

  def check_word(word)
    url = "https://wagon-dictionary.herokuapp.com/#{word}"
    user_serialized = URI.open(url).read
    result = JSON.parse(user_serialized)
    result['found'] == true
  end
end
