class HangpersonGame

  # add the necessary class methods, attributes, etc. here
  # to make the tests in spec/hangperson_game_spec.rb pass.

  # Get a word from remote "random word" service

  # def initialize()
  # end
  
  def initialize(word)
    @word = word
    @guesses = ''
    @wrong_guesses = ''
  end
  
  attr_accessor :word, :guesses, :wrong_guesses

  def self.get_random_word
    require 'uri'
    require 'net/http'
    uri = URI('http://watchout4snakes.com/wo4snakes/Random/RandomWord')
    Net::HTTP.post_form(uri ,{}).body
  end
  
  def guess(letter)
    if letter == nil
      raise ArgumentError, 'Your guess must be a letter!'
    end
  
    letter.downcase!
    
    if letter == '' or /[a-z]/.match(letter).nil? == true
      raise ArgumentError, 'Your guess must be a letter!'
    end

    if word.include?(letter) and @guesses.include?(letter) == false
      @guesses << letter
    elsif word.include?(letter) == false and @wrong_guesses.include?(letter) == false
      @wrong_guesses << letter
    else
      return false
    end
  end
  
  def word_with_guesses
    string = ''
    word.each_char do |x|
      if @guesses.include?(x)
        string << x
      else
        string << '-'
      end
    end
    return string 
  end
  
  def check_win_or_lose
    if @wrong_guesses.length == 7
      return :lose
    elsif self.word_with_guesses == word
      return :win
    else
      return :play
    end
  end
  
end
