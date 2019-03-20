require 'test_helper'
class GameTest < ActiveSupport::TestCase
 # use test data in test/fixtures/game.yml
  fixtures :game
  
  # test display method 
  # test methods must begin with test_
  # correctly returning the display string
  # word is computer, already guessed cpue
  def test_display_1
    g = game(:one)
    assert_equal g.display, "c _ _ p u _ e _ "
    # correct guess should reveal the letter
    g.guess?("t")
    # incorrect guess
    assert_equal g.display, "c _ _ p u t e _ "
    g.guess?("a")
    assert_equal g.display, "c _ _ p u t e _ "
    # game won should be false
    assert_equal g.won?,  false
    # correctly guess remaining letters
    # game should now be won
    g.guess?("o")
    g.guess?("r")
    g.guess?("m")
    assert_equal g.display, "c o m p u t e r "
    assert_equal g.won?, true
  end
  
  # display test
  # when user guesses a letter in a word
  # that occurs multiple times, all occurrences are 
  # revealed
  def test_display_2
    g = game(:two)
    assert_equal  g.display, "_ _ _ _ _ _ _ _ "
    g.guess?("s")
    assert_equal  g.display, "_ _ s _ s _ _ _ "
  end
end
