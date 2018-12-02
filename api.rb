require 'sinatra/base'

class Api < Sinatra::Base
  get '/' do
    "Go to /play and add a board as a param!"
  end

  get '/play' do
    board = params['board']
    return status 400 unless board && valid_board(board)

    play_o(board)
  end

  private

  def valid_board(input)
    counts = group_chars(input.chars)
    input.chars.count == 9 &&
      room_left_to_play(counts) &&
      plausibly_o_turn(counts)
  end

  def play_o(board)
    board.sub(' ', 'o')
  end

  def group_chars(chars)
    counts = {}
    chars.group_by(&:itself).each { |k,v| counts[k] = v.length }
    counts
  end

  def room_left_to_play(counts)
    !counts[" "].nil?
  end

  def plausibly_o_turn(counts)
    counts["o"] = 0 if counts["o"].nil?
    counts["x"] = 0 if counts["x"].nil?

    (counts["x"] - counts["o"]).abs <= 1
  end
end
