require 'sinatra'
require 'sinatra/reloader'
require 'csv'

def all_songs
  songs = []

  CSV.foreach('jams.csv', headers: true, header_converters: :symbol) do |row|
    songs << row.to_hash
  end

  songs
end

get '/' do
  songs = all_songs

  erb :index, locals: { songs: songs }
end

# /artist/U2
# /artist/Empire of the Sun
# /artist/Jay-z

get '/artists/:artist_name' do
  artist_name = params[:artist_name]

  songs = all_songs.find_all do |song|
    song[:artist] == artist_name
  end

  erb :'artists/show', locals: {
    artist_name: artist_name,
    songs: songs
  }
end
