
# Go is a 2 player board game with simple rules. Two players alternate turns
# placing stones on a grid. If a stone is surrounded on 4 sides by stones of
# the opponent, it is captured. If a group of stones are surrounded, they are
# captured.
# See http://en.wikipedia.org/wiki/Rules_of_Go#Capture for a visual explanation.

# Below is an implementation of a Go board. Please write some code in the
# move() method to check for captures and output something when a capture
# occurs. The sample moves represent a capture of two black stones.

EMPTY = 0
BLACK = 1
WHITE = 2

class Board

  #Adjacent cells - add the x and y coordinates
  @@ADJACENTS = [[1,0],
                 [0,1],
                 [-1,0],
                 [0,-1]]

  @@MAX = 19  #Max rows, cols

  def initialize
    @board = Array.new(19){Array.new(@@MAX, EMPTY)}
  end

  def printBoard
    @board.length.times do |row|
      @board[row].length.times do |col|
        if @board[row][col]
           print "#{@board[row][col].to_s} "
        else
          print "_ "
        end  
      end
      puts "\n"
    end
  end

  #Checks that any row or col increment stays within the max allowed
  #0...@@MAX => does not include the MAX
  def is_within_boundary?(row,col)
    return (0...@@MAX) === row && (0..@@MAX) === col
  end

  def opponent_color(color)
    color == BLACK ? (color = WHITE) : (color = BLACK)
  end

  def color_string(color)
    color == BLACK ? "BLACK" : "WHITE"
  end

  def move_piece(color, row, col)
    @board[row][col] = color
  end

  def move(color, row, col)

    move_piece(color, row, col)
    #Check the adjacency for opponent captures
    if check_adjacents(color,row,col)
       puts "\n\tCAPTURED #{color_string(opponent_color(color))} "\
            "after moving #{color_string(color)} to row #{row}, col #{col}"
    end

    #Check the adjacency for current player captures 
    if check_adjacents(opponent_color(color),row,col)
       puts "\n\tSUICIDE #{color_string(color(color))} "\
            "after moving #{color_string(color)} to row #{row}, col #{col}"
    end
  end

  def is_empty?(row,col)
      return @board[row][col] == EMPTY
  end

  #This method will check 4 adjacent squares 
  def check_adjacents(color,row,col)
    
    is_capture = false

    @@ADJACENTS.each do |xy_pos|
       
       r1,c1 = xy_pos[0]+row , xy_pos[1]+col

       if is_within_boundary?(r1,c1) && @board[r1][c1] == opponent_color(color)
          is_capture = check_capture(opponent_color(color),r1,c1)
       end
    end
    
    is_capture

  end

  #recursive function to check if a collection of "opponet stones"
  #are bound by boundary of player stones
  def check_capture(opp_color,row,col,ignore_pos=nil,arr = [])

    is_capture = true
     
    @@ADJACENTS.each do |xy_pos|

      r1,c1 = xy_pos[0]+row , xy_pos[1]+col

      if is_within_boundary?(r1,c1)
        if is_empty?(r1,c1)
          is_capture = false
          break
        end

        if @board[r1][c1] == opp_color
          is_capture = check_capture(opp_color,r1,c1,[row,col]) if ignore_pos != [r1,c1]
          break if !is_capture
        end

      end

    end

    return is_capture
  end 

end


# --------------------------------------#
# Please see the rspec (for ruby tests) #
# spec/gridium_go_spec.rb also          #
# --------------------------------------#
b = Board.new
b.printBoard
b.move(BLACK, 4, 4)
b.move(BLACK, 4, 5)
b.move(WHITE, 3, 4)
b.move(WHITE, 3, 5)
b.move(WHITE, 4, 3)
b.move(WHITE, 4, 6)
b.move(WHITE, 5, 4)
b.move(WHITE, 5, 5)

