################################################################ 
# By Deepa Kackar
# Purpose: Logic for the capture of stones in GO Game ONLY
#          Note: 
#          Does not clear the captured stones
#          Does not validate moves and other game logic
################################################################ 

Ruby Run:
  ruby gridium_go.rb (Tests are NOT in this source file)
 
Ruby Test of Go Captures:
  rspec spec/gridium_go_spec.rb
  
  (File ruby_spec_results contains save output of rspec)

Python Run:
  python gridium_go.py (Tests ARE in this source file)

Python Test of Go Captures:
  python gridium_go.py


################################################################ 
Some details

1. ADJACENTS = [[1,0],[0,1],[-1,0],[0,-1]]
   The x,y increments that should be added to the current square coordinates to get the adjacent square cordinates

2. MAX = 19  
   Board Size

3. Method: check_adjacents(color,row,col)
   Once a move is made, this method will call for checking of captures from each adjacent squares
   ADJACENTS array is used to get adjacent squares

   Returns true if atleast one adjacent results in capture

4. check_capture(opp_color,row,col,ignore_pos=nil)
   
   Case 1: Capture by opponent
     a. Recursion if current player move and sequence of adjacent stones is opponent

     b. FALSE is returned if EMPTY square next to color square
   
     c. TRUE is returned if BOUNDARY or current player stone next to opponent stone

   Case 2: Bad move causing capture of self stones by opponent
     a. Recursion if current player move and sequence of adjacent stones is current player stones

     b. FALSE is returned if EMPTY square next to color square
   
     c. TRUE is returned if BOUNDARY or opponent stone next to current player stone 
