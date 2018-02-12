require 'open-uri'
require 'json'

class GamesController < ApplicationController
  def new
    @array = ('A'..'Z').to_a.sample(8)
    @letters = @array.join(" ")
  end

  def included?(guess, grid)
    guess.all? { |letter| guess.count(letter) <= grid.count(letter) }
  end

  def english_word?(word)
    response = open("https://wagon-dictionary.herokuapp.com/#{word}")
    json = JSON.parse(response.read)
    return json['found']
  end

  def score
    @guess = params[:guess].downcase.chars
    @grid = params[:grid].downcase.chars
    if included?(@guess, @grid)
      if english_word?(@guess.join)
        @results = "Well done"
      else
        @results = "Not an english word"
      end
    else
      @results = "Not in the grid"
    end
  @score = @guess.length
  end


end
