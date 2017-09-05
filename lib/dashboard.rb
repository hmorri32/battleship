require 'colorize'
require_relative 'board'
require_relative 'ship'
require_relative 'player'

class DashBoard 

  def border
    '=============='   
  end

  def format_row(arr)
    arr.map {|letter| letter == '' ? ' ' : letter}.join(' ')
  end

  def top(size, arr = ["."])
    for i in 1..size do 
      arr << i.to_s
    end
    arr.join(' ')
  end

  def grid(size, rows)
    "#{border}\n#{top(size)}\n#{rows.map {|letter|"#{format_row(letter)}\n"}.join}#{border}"
  end

  def rows(board)
    board.board.map do |row|
      arr = []
      row.each do |s|
        space = s.values[0]
        arr.push(space.position[0]) if space.position[1] == "1"
        arr.push("")  if empty?(board, space.position)
        arr.push("H") if hit?(board, space.position)
        arr.push("M") if miss?(board, space.position)
      end
      arr
    end
  end

  def draw(board)
    grid(board.size, rows(board))
  end

  def hit?(board, space)
    board.hit?(space)
  end

  def miss?(board, space)
    board.miss?(space)
  end

  def empty?(board, space)
    board.fired_on?(space) == false
  end
end


# board = Board.new(4)
# # puts 'cool'.colorize(:red)
# # TODO BUILD THE REST OF THE FOOKIN BOARD 
# dash = DashBoard.new
# # p dash.border(4)
# # p dash.row(['', 'M'])
# row1 = ['A', 'H', '', '', 'M']
# row2 = ['B', '', '', '', 'H']
# row3 = ['C', '', '', '', 'H']
# row4 = ['D', 'H', 'H', '', '']
# # puts dash.grid(4, row1, row2, row3, row4)
# # p dash.get_rows_from_board(board)
# board.fire_on('A1')
# board.fire_on('B3')
# board.fire_on('A3')
# player = Player.new([2,3])
# ship = player.ships[0]
# player.place_ship(board, ship, 'A4', 'B4')
# player.shoot(board, 'A4')
# player.shoot(board, 'B4')
# player.shoot(board, 'C4')
# puts dash.render(board)