Rails.application.routes.draw do
   get 'games/new' => 'games#start'
   get 'games/:id' => 'games#play'
end


