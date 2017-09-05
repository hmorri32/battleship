module Messages 
  def self.welcome 
    "\nWelcome to BATTLESHIP\nWould you like to (p)lay, read the (i)nstructions, or (q)uit?"    
  end

  def self.instructions 
    "\n\nPrepare for battle!\nYou are up against an ultra advanced AI opponent!\nIt will place it's ships and then you will place your ships.\n\nRules are as follows:\n\nYou will select the start and end spaces for your ship.\nYour ship must either be horizontally placed or vertically placed.\nYour ships boundaries cannot fall outside the confines of the grid.\nYour ship can not be placed on top of another ship.\nYour ship must occupy an existing space.\nYou can then attack spaces on your opponents board.\nIf you attack an empty space, you will MISS!\nIf you attack an occupied space, you will HIT!\nYour turn ends after you have shot.\nYour opponent will then shoot upon your board.\nThe game ends when one player has sunk all of the opponent's ships.\n\n"
  end

  def self.computer_has_placed_ships 
    "\nThe computer has placed it's ships!\nYou must now place yours."
  end

  def self.place_ship(ship)
    str = ''
    ship.length == 3 ? str << "A1 A3" : str << "A1 A2"

    "\nEnter the spaces in which you wish to place your #{ship.length} length ship\nThese are space separated values.\nThe first value will be the starting point\nand the second value will be the end point.\nFor example, #{str} will place your ships bow at #{str[0..1]} and stern at #{str[0..-1]}.\n\nPlease input your spaces.\n"
  end
end
