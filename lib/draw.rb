module Draw 
  def border
    '==================' 
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
end