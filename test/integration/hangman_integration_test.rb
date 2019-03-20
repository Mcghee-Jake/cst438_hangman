require 'test_helper'
 
class HangmanIntegrationTest < ActionDispatch::IntegrationTest
    
  fixtures :game
  
  def test_new_game
      get "/hangman/game/new"
      assert_response :success
       
  end   
  
  def test_game_one
      get "/hangman/game/#{:one}", params: {:guess => "o"}
      assert_response :success
      assert_select "p#2", "c o _ p u _ e _ " 
  end   
      
end