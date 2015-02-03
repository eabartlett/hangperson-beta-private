class HangpersonGame

  attr_accessor :guesses
  attr_accessor :wrong_guesses
  attr_accessor :word
  def initialize(new_word)
    @word = new_word
    @guesses = ''
    @wrong_guesses = ''
  end

  def guess(letter)
    letter.gsub!(/[^a-zA-z]/i, '')
    if letter.size == 0 or not letter 
      raise ArgumentError
    end
    if @guesses.include? letter or @wrong_guesses.include? letter
      return false
    end
    if @word.include? letter
      @guesses = @guesses << letter
      return true
    end
    @wrong_guesses = @wrong_guesses << letter
    return true
  end

  def word_with_guesses
    word.chars.map do |l| 
      if @guesses.include? l 
        l
      else
        "-"
      end
    end.join
  end

  def check_win_or_lose
    if @wrong_guesses.size >= 7
      :lose
    elsif not word_with_guesses.include? "-"
      :win
    else
      :play
    end
  end


  # Get a word from remote "random word" service

  def self.get_random_word
    require 'uri'
    require 'net/http'
    uri = URI('http://watchout4snakes.com/wo4snakes/Random/RandomWord')
    Net::HTTP.post_form(uri ,{}).body
  end

end
