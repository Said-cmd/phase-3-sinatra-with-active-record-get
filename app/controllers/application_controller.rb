class ApplicationController < Sinatra::Base

  set :default_content_type, 'application/json'

  get '/games' do 
    # gets all the games from the database
    games = Game.all.order(:title).limit(10)
    # returns a JSON response with an array of all the game data
    games.to_json
  end
  # using the :id syntax to create a dynamic route
  get '/games/:id' do
    # looks up the game in the database using its ID
    game = Game.find(params[:id])
    # sends a JSON-formatted response of the game data
    # includes the associated reviews in the JSON response
    game.to_json(only: [:id, :title, :genre, :price], include: {
      reviews: { only: [:comment, :score], include: {
        user: { only: [:name] }
      } }
    })
  end

end
