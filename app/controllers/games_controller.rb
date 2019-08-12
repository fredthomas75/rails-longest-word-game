class GamesController < ApplicationController
  def new
    @letters = ('A'..'Z').to_a.sample(10)
  end

  def score
    @letters = params[:letters]
    @answer = params[:answer].upcase
    @answer_array = @answer.split("")

    @result = {}

    url = "https://wagon-dictionary.herokuapp.com/#{@answer}"
    raw_data = open(url).read
    valid_data = JSON.parse(raw_data)
    word_valid = valid_data["found"]
    word_json = valid_data["word"]
    word_length = valid_data["length"]

    @answer_array.each do |char|
      if @answer_array.count(char) > @letters.count(char)
        @result[:score] = 0
        @result[:message] = "Sorry but #{@answer} can't be built out of #{@letters}"
      end
    end
    if word_valid == false
      @result[:score] = 0
      @result[:message] = "Sorry but #{@answer} is not an english word"
    else
      @result[:score] = (word_length)
      @result[:message] = "Congratulations: #{@answer} is a valid English word!"
    end
  end
end
