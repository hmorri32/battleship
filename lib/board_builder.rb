module BoardBuilder
  def rows
    ('A'..'Z').to_a.shift(@size)
  end
  
  def columns
    ('1'..'26').to_a.shift(@size)
  end

  def space_name_arr
    rows.flat_map {|letter| columns.flat_map{|number| letter + number}}
  end

  def space_hash
    space_name_arr.reduce({}) do |spaces, name| 
      spaces["#{name}"] = Space.new(name)
      spaces
    end
  end

  def row_arr
    space_name_arr.each_slice(@size).to_a
  end

  def build_board
    row_arr.map do |row|
      row.map.with_index do |coordinates, index|
        row[index] = {coordinates => space_hash[coordinates]}
      end
    end
  end
end