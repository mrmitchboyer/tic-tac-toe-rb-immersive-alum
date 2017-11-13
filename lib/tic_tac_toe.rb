require 'pry'

WIN_COMBINATIONS = [
  [0,1,2],
  [3,4,5],
  [6,7,8],
  [0,3,6],
  [1,4,7],
  [2,5,8],
  [0,4,8],
  [6,4,2]
]

def won?(board)
  WIN_COMBINATIONS.find do |win_arr|
    if board[win_arr[0]] == "X"
      win_arr.all? {|i| board[i] == "X"}
    elsif board[win_arr[0]] =="O"
      win_arr.all? {|i| board[i] == "O"}
    end
  end
end

def full?(board)
  board.all? {|i| i != " "}
end

def draw?(board)
  full?(board) && !won?(board)
end

def over?(board)
  !!draw?(board) || !!won?(board)
end

def winner(board)
  board[won?(board)[0]] if !!won?(board)
end

def current_player(board)
  if turn_count(board) % 2 == 1
    "O"
  else
    "X"
  end
end

def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def input_to_index(user_input)
  user_input.to_i - 1
end

def move(board, index, current_player)
  board[index] = current_player
end

def position_taken?(board, location)
  board[location] != " " && board[location] != ""
end

def valid_move?(board, index)
  index.between?(0,8) && !position_taken?(board, index)
end

def result(board)
  if !!draw?(board)
    puts "Cat's Game!"
  else
    puts "Congratulations #{winner(board)}!"
  end
end

def turn(board)
  puts "Select a number between 1-9"
  display_board(board)
  
  input = gets.chomp
  index = input_to_index(input)
  current_player = current_player(board)

  if valid_move?(board, index)
    move(board, index, current_player)
  else
    puts "INVALID INPUT"
    turn(board)
  end
end

def turn_count(board)
  board.select {|slot| slot != " "}.count
end

def play(board)
  while turn_count(board) < 10
    if !over?(board)
      turn(board)
    else
      return result(board)
    end
  end

end
