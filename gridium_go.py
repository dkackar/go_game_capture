#!/usr/bin/env python

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

ADJACENTS = [[1,0],
             [0,1],
             [-1,0],
             [0,-1]]
MAX = 19

class Board(object):
    def __init__(self):
        self.board = [[EMPTY] * 19 for _ in xrange(19)] # 2d 19x19 matrix of 0's

    def __str__(self):
        s = ''
        for row in self.board:
            if s:
                s += '\n'
            for sq in row:
                if sq:
                    s += str(sq)
                else:
                    s += '_'
        return s

    #Checks that any row or col increment stays within the max allowed
    def is_within_boundary(self,row,col):
        return (0 <= row < MAX and 0 <= col < MAX)

    #Get opponent color
    def opponent_color(self,color):
        if color == BLACK:
            color = WHITE
        else:
            color = BLACK

        return color

    def color_string(self,color):
        if color == BLACK:
            color = "BLACK"
        else:
            color = "WHITE"
        
        return color

    def is_empty(self,row,col):
        return self.board[row][col] == EMPTY

    def check_adjacents(self,color,row,col):
        is_capture = False

        for xy_pos in ADJACENTS:
       
            r1,c1 = xy_pos[0]+row , xy_pos[1]+col

            if self.is_within_boundary(r1,c1):
                if self.board[r1][c1] == self.opponent_color(color):
                    is_capture = self.check_capture(self.opponent_color(color),r1,c1)
    
        return is_capture

    #recursive function to check if a collection of "opponet stones"
    #are bound by boundary of player stones
    def check_capture(self,opp_color,row,col,ignore_pos=None):
        is_capture = True
     
        for xy_pos in ADJACENTS:

            r1,c1 = xy_pos[0]+row , xy_pos[1]+col
       
            if self.is_within_boundary(r1,c1):
          
                if self.is_empty(r1,c1):
                    is_capture = False
                    break

                if self.board[r1][c1] == opp_color:
                    if ignore_pos != [r1,c1]:
                        is_capture = self.check_capture(opp_color,r1,c1,[row,col]) 
                        if not is_capture:
                            break
  
        return is_capture

    def move_piece(self,color, row, col):
        self.board[row][col] = color

    def move(self, color, row, col):
        self.move_piece(color, row, col)
        
        #Check the adjacency for opponent captures
        if self.check_adjacents(color,row,col):
            print "\n\tCAPTURED %s after moving %s to row %d, col %d"\
                % (self.color_string(self.opponent_color(color)), self.color_string(color), row,col)
        
        #Check the adjacency for current player captures 
        if self.check_adjacents(self.opponent_color(color),row,col):
           print "\n\tSUICIDE by %s after moving to row %d, col %d"\
                % (self.color_string(color), row, col)


print "=======================================================================\n"
print "\nTest 1: Sample test results in capture"
b = Board()
b.move(BLACK, 4, 4)
b.move(BLACK, 4, 5)

b.move(WHITE, 3, 4)
b.move(WHITE, 3, 5)
b.move(WHITE, 4, 3)
b.move(WHITE, 4, 6)
b.move(WHITE, 5, 4)
b.move(WHITE, 5, 5)
print b

print "\n============== TESTS FOR NO CAPTURES ===================="
print "\nTest 2: Series of black only moves does NOT result in capture"
b = Board()
b.move(1,4,4)
b.move(1,4,3)
b.move(1,4,5)
b.move(1,5,4)
b.move(1,3,4)

print "\nTest 3: Series of white only moves does NOT result in capture"
b = Board()
b.move(2,4,4)
b.move(2,4,3)
b.move(2,4,5)
b.move(2,5,4)
b.move(2,3,4)

print "\nTest 4: Series of black only moves with horizontal boundary does NOT result in capture"
b = Board()
for ind in range(19):
    b.move(1,0,ind)

for ind in range(19):
    b.move_piece(1,1,ind)

print "\nTest 5: Series of white only moves with vertical boundary does NOT result in capture"
b = Board()
for ind in range(19):
    b.move(2,ind,18)

for ind in range(19):
    b.move_piece(2,ind,17)

print "\nTest 6: 1 black move surrounded by 3 white moves with 1 missing white piece does NOT result in capture"
b = Board()
b.move(1,4,4)

b.move(2,4,3)
b.move(2,4,5)
b.move(2,5,4)

print "\nTest 7: 1 white move surrounded by 3 black moves with 1 missing black piece does NOT result in capture"
b = Board()
b.move(2,4,4)

b.move(1,4,3)
b.move(1,4,5)
b.move(1,5,4)

print "\nTest 8: 2 horizontal black moves surrounded by 5 white moves with 1 missing white piece does NOT result in capture"
b = Board()
b.move(1,4,4)
b.move(1,4,5)

b.move(2,4,3)
b.move(2,4,6)
b.move(2,5,4)
b.move(2,5,5)
b.move(2,3,5)

print "\nTest 9: 2 vertical black moves surrounded by 5 white moves with 1 missing left white piece does NOT result in capture"
b = Board()
b.move(1,3,4)
b.move(1,4,4)

b.move(2,3,5)
b.move(2,4,3)
b.move(2,4,5)
b.move(2,5,4)
b.move(2,2,4)

print "\nTest 10: 2 vertical black moves surrounded by 5 white moves with 1 missing right white piece does NOT result in capture"
b = Board()
b.move(1,3,4)
b.move(1,4,4)

b.move(2,5,4)
b.move(2,2,4)
b.move(2,3,3)
b.move(2,3,5)
b.move(2,4,5)

print "\nTest 11: 2 vertical black moves surrounded by 5 white moves with 1 missing top white move does NOT result in capture"
b = Board()
b.move(1,3,4)
b.move(1,4,4)

b.move(2,5,4)
b.move(2,3,3)
b.move(2,3,5)
b.move(2,4,3)
b.move(2,4,5)

print "\nTest 12: 2 vertical black moves surrounded by 5 white moves with 1 missing bottom white piece does NOT result in capture"
b = Board()
b.move(1,4,4)
b.move(1,3,4)

b.move(2,2,4)
b.move(2,4,3)
b.move(2,4,5)
b.move(2,3,3)
b.move(2,3,5)

print "\n============== CAPTURE TESTS ===================="
print "\nTest 13: 1 Black move surrounded by all white moves results in capture"
b = Board()
b.move(1,4,4)
b.move(2,4,3)
b.move(2,4,5)
b.move(2,5,4)
b.move(2,3,4)

print "\nTest 14: 1 white move surrounded by all black moves results in capture"
b = Board()
b.move(2,4,4)
b.move(1,4,3)
b.move(1,4,5)
b.move(1,5,4)
b.move(1,3,4)

print "\nTest 15: 2 horizontal black moves surrounded by all white moves results in capture"
b = Board()
b.move(1,4,4)
b.move(1,4,5)
b.move(2,4,3)
b.move(2,4,6)
b.move(2,5,4)
b.move(2,5,5)
b.move(2,3,4)
b.move(2,3,5)

print "\nTest 16: 2 vertical black moves surrounded by all white moves results in capture"
b = Board()
b.move(1,4,4)
b.move(1,3,4)
b.move(2,4,3)
b.move(2,4,5)
b.move(2,3,3)
b.move(2,3,5)
b.move(2,5,4)
b.move(2,2,4)

print "\nTest 17: 2 vertical white moves surrounded by all black moves results in capture"
b = Board()
b.move(2,4,4)
b.move(2,3,4)
b.move(1,4,3)
b.move(1,4,5)
b.move(1,3,3)
b.move(1,3,5)
b.move(1,5,4)
b.move(1,2,4)

print "\nTest 18: 2 vertical black moves surrounded by all white moves and top horizontal boundary results in capture"
b = Board()
b.move(1,0,4)
b.move(1,1,4)
b.move(2,0,3)
b.move(2,0,5)
b.move(2,1,3)
b.move(2,1,5)
b.move(2,2,4)

print "\nTest 19: 2 vertical white moves surrounded by black moves and bottom horizontal boundary results in capture "
b = Board()
b.move(2,18,4)
b.move(2,17,4)
b.move(1,18,3)
b.move(1,18,5)
b.move(1,17,3)
b.move(1,17,5)
b.move(1,17,4)

print "\nTest 20: L shaped white moves surrounded by all black moves results in capture"
b = Board()
b.move(2,1,2)
b.move(2,2,2)
b.move(2,3,2)
b.move(2,3,3)
b.move(2,3,4)

b.move(1,0,2)
b.move(1,1,1)
b.move(1,2,1)
b.move(1,3,1)
b.move(1,4,1)
b.move(1,4,2)
b.move(1,4,3)
b.move(1,4,4)
b.move(1,3,5)
b.move(1,2,3)
b.move(1,2,4)
b.move(1,1,3)

print "\nTest 21: C shaped black moves surrounded by all white moves results in capture"
b = Board()
b.move(1,3,7)
b.move(1,3,8)
b.move(1,3,9)
b.move(1,4,7)
b.move(1,5,7)
b.move(1,6,7)
b.move(1,6,8)
b.move(1,6,9)

b.move(2,3,10)
b.move(2,2,7)
b.move(2,2,8)
b.move(2,2,9)
b.move(2,3,6)
b.move(2,4,6)
b.move(2,5,6)
b.move(2,6,6)
b.move(2,7,7) 
b.move(2,7,8)
b.move(2,7,9)
b.move(2,4,8)
b.move(2,4,9)
b.move(2,5,8)
b.move(2,5,9)      
b.move(2,6,10)

print "\nTest 22: T shaped black moves surrounded by all white moves results in capture" 
b = Board()
b.move(1,2,3)
b.move(1,2,4)
b.move(1,2,5)
b.move(1,3,4)
b.move(1,4,4)
   
b.move(2,1,3)
b.move(2,1,4)
b.move(2,1,5)
b.move(2,2,2)
b.move(2,2,6)
b.move(2,3,3)
b.move(2,3,5)
b.move(2,4,3)
b.move(2,4,5)
b.move(2,5,4)

print "\nTest 23: Diagonal shaped black moves surrounded by white moves results in capture"
b = Board()
b.move(1,6,8)
b.move(1,7,7)
b.move(1,8,6)

b.move(2,6,7)
b.move(2,7,6)
b.move(2,8,5)
b.move(2,8,7)
b.move(2,7,8)

print "\nTest 24: Black row and then White row bounded by top horizontal boundary"
b = Board()    
for col in range(19):
    b.move(1,0,col)

for col in range(19):
    b.move(2,1,col)

print "\nTest 25: Black row and then White row bounded by bottom horizontal boundary"
b = Board()
for col in range(19):
    b.move(1,18,col)

for col in range(19):
    b.move(2,17,col) 

print "\nTest 26: White row between Black row and bottom horizontal boundary (suicide)"
b = Board()
for col in range(19):
    b.move(1,17,col)

for col in range(19):
    b.move(2,18,col)

print "\nTest 27: Black column and then White column bounded by left vertical boundary"
b = Board()
for row in range(19):
    b.move(1,row,0)

for row in range(19):
    b.move(2,row,1) 

