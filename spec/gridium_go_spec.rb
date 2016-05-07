require_relative '../gridium_go'

describe 'Board' do

  describe  "#check non captures" do
    ## Should be a suicide actually - but we are doing captures
    ## for now - so these tests will pass

    let(:default_board) { Board.new }
    
    it "series of black only moves does not result in capture" do
      default_board.move_piece(1,4,4)
      default_board.move_piece(1,4,3)
      default_board.move_piece(1,4,5)
      default_board.move_piece(1,5,4)
      default_board.move_piece(1,3,4)
      expect(default_board.check_adjacents(1,3,4)).to eq(false)
    end

    it "series of white only moves does not result in capture" do
      default_board.move_piece(2,4,4)
      default_board.move_piece(2,4,3)
      default_board.move_piece(2,4,5)
      default_board.move_piece(2,5,4)
      default_board.move_piece(2,3,4)
      expect(default_board.check_adjacents(2,3,4)).to eq(false)
    end

    it "series of black only moves with horizontal boundary does not result in capture" do
      19.times do |ind|
        default_board.move_piece(1,0,ind)
      end
      19.times do |ind|
        default_board.move_piece(1,1,ind)
      end  
      expect(default_board.check_adjacents(1,1,18)).to eq(false)
    end

    it "series of white only moves with vertical boundary does not result in capture" do
      19.times do |ind|
        default_board.move_piece(2,ind,18)
      end
      19.times do |ind|
        default_board.move_piece(2,ind,17)
      end  
      expect(default_board.check_adjacents(2,18,17)).to eq(false)
    end

    it "1 black move surrounded by 3 white moves with 1 missing white piece" do
      default_board.move_piece(1,4,4)

      default_board.move_piece(2,4,3)
      default_board.move_piece(2,4,5)
      default_board.move_piece(2,5,4)
      expect(default_board.check_adjacents(2,5,4)).to eq(false)
    end

    it "1 white move surrounded by 3 black moves with 1 missing white piece " do
      default_board.move_piece(2,4,4)

      default_board.move_piece(1,4,3)
      default_board.move_piece(1,4,5)
      default_board.move_piece(1,5,4)
      expect(default_board.check_adjacents(1,5,4)).to eq(false)
    end

    it "2 horizontal black moves surrounded by 5 white moves with 1 missing white piece" do
      default_board.move_piece(1,4,4)
      default_board.move_piece(1,4,5)

      default_board.move_piece(2,4,3)
      default_board.move_piece(2,4,6)
      default_board.move_piece(2,5,4)
      default_board.move_piece(2,5,5)
      default_board.move_piece(2,3,5)
      expect(default_board.check_adjacents(2,3,5)).to eq(false)
    end

    it "2 vertical black moves surrounded by 5 white moves with 1 missing left white piece" do
      default_board.move_piece(1,3,4)
      default_board.move_piece(1,4,4)

      default_board.move_piece(2,3,5)
      default_board.move_piece(2,4,3)
      default_board.move_piece(2,4,5)
      default_board.move_piece(2,5,4)
      default_board.move_piece(2,2,4)
      expect(default_board.check_adjacents(2,2,4)).to eq(false)
    end

    it "2 vertical black moves surrounded by 5 white moves with 1 missing right white piece" do
      default_board.move_piece(1,3,4)
      default_board.move_piece(1,4,4)

      default_board.move_piece(2,5,4)
      default_board.move_piece(2,2,4)
      default_board.move_piece(2,3,3)
      default_board.move_piece(2,3,5)
      default_board.move_piece(2,4,5)
      expect(default_board.check_adjacents(2,4,5)).to eq(false)
    end 

    it "2 vertical black moves surrounded by 5 white moves with 1 missing top white move" do
      default_board.move_piece(1,3,4)
      default_board.move_piece(1,4,4)

      default_board.move_piece(2,5,4)
      default_board.move_piece(2,3,3)
      default_board.move_piece(2,3,5)
      default_board.move_piece(2,4,3)
      default_board.move_piece(2,4,5)
      expect(default_board.check_adjacents(2,4,5)).to eq(false)
    end 

    it "2 vertical black moves surrounded by 5 white moves with 1 missing bottom white piece" do
      default_board.move_piece(1,4,4)
      default_board.move_piece(1,3,4)

      default_board.move_piece(2,2,4)
      default_board.move_piece(2,4,3)
      default_board.move_piece(2,4,5)
      default_board.move_piece(2,3,3)
      default_board.move_piece(2,3,5)      
      expect(default_board.check_adjacents(2,3,5)).to eq(false)
    end
  end

  describe  "#check simple captures" do
    let(:default_board) { Board.new }
    it "1 black move surrounded by all white moves" do
      default_board.move_piece(1,4,4)

      default_board.move_piece(2,4,3)
      default_board.move_piece(2,4,5)
      default_board.move_piece(2,5,4)
      default_board.move_piece(2,3,4)
      expect(default_board.check_adjacents(2,3,4)).to eq(true)
    end

    it "1 white move surrounded by all black moves" do
      default_board.move_piece(2,4,4)

      default_board.move_piece(1,4,3)
      default_board.move_piece(1,4,5)
      default_board.move_piece(1,5,4)
      default_board.move_piece(1,3,4)
      expect(default_board.check_adjacents(1,3,4)).to eq(true)
    end

    it "2 horizontal white moves surrounded by all black moves" do
      default_board.move_piece(2,4,4)
      default_board.move_piece(2,4,5)

      default_board.move_piece(1,4,3)
      default_board.move_piece(1,4,6)
      default_board.move_piece(1,5,4)
      default_board.move_piece(1,5,5)
      default_board.move_piece(1,3,4)
      default_board.move_piece(1,3,5)
      expect(default_board.check_adjacents(1,3,5)).to eq(true)
    end

    it "2 vertical black moves surrounded by all white moves" do
      default_board.move_piece(1,4,4)
      default_board.move_piece(1,3,4)

      default_board.move_piece(2,4,3)
      default_board.move_piece(2,4,5)
      default_board.move_piece(2,3,3)
      default_board.move_piece(2,3,5)
      default_board.move_piece(2,5,4)
      default_board.move_piece(2,2,4)
      expect(default_board.check_adjacents(2,2,4)).to eq(true)
    end

    it "2 vertical white moves surrounded by all black moves" do
      default_board.move_piece(2,4,4)
      default_board.move_piece(2,3,4)

      default_board.move_piece(1,4,3)
      default_board.move_piece(1,4,5)
      default_board.move_piece(1,3,3)
      default_board.move_piece(1,3,5)
      default_board.move_piece(1,5,4)
      default_board.move_piece(1,2,4)
      expect(default_board.check_adjacents(1,2,4)).to eq(true)
    end 

    it "2 vertical black moves surrounded by white moves and top horizontal boundary" do
      default_board.move_piece(1,0,4)
      default_board.move_piece(1,1,4)

      default_board.move_piece(2,0,3)
      default_board.move_piece(2,0,5)
      default_board.move_piece(2,1,3)
      default_board.move_piece(2,1,5)
      default_board.move_piece(2,2,4)
      expect(default_board.check_adjacents(2,2,4)).to eq(true)
    end

    it "2 vertical white moves surrounded by black moves and bottom horizontal boundary" do
      default_board.move_piece(2,18,4)
      default_board.move_piece(2,17,4)

      default_board.move_piece(1,18,3)
      default_board.move_piece(1,18,5)
      default_board.move_piece(1,17,3)
      default_board.move_piece(1,17,5)
      default_board.move_piece(1,17,4)

      expect(default_board.check_adjacents(1,17,4)).to eq(true)
    end

    it "L shaped white moves surrounded by black moves" do
      default_board.move_piece(2,1,2)
      default_board.move_piece(2,2,2)
      default_board.move_piece(2,3,2)
      default_board.move_piece(2,3,3)
      default_board.move_piece(2,3,4)

      default_board.move_piece(1,0,2)
      default_board.move_piece(1,1,1)
      default_board.move_piece(1,2,1)
      default_board.move_piece(1,3,1)
      default_board.move_piece(1,4,1)
      default_board.move_piece(1,4,2)
      default_board.move_piece(1,4,3)      
      default_board.move_piece(1,4,4)
      default_board.move_piece(1,3,5)
      default_board.move_piece(1,2,3)
      default_board.move_piece(1,2,4)

      expect(default_board.check_adjacents(1,1,3)).to eq(false)
      default_board.move_piece(1,1,3)
      expect(default_board.check_adjacents(1,1,3)).to eq(true)
    end

    it "C shaped black moves surrounded by white moves" do
      default_board.move_piece(1,3,7)
      default_board.move_piece(1,3,8)
      default_board.move_piece(1,3,9)
      default_board.move_piece(1,4,7)
      default_board.move_piece(1,5,7)
      default_board.move_piece(1,6,7)
      default_board.move_piece(1,6,8)
      default_board.move_piece(1,6,9)

      default_board.move_piece(2,3,10)
      default_board.move_piece(2,2,7)
      default_board.move_piece(2,2,8)
      default_board.move_piece(2,2,9)
      default_board.move_piece(2,3,6)
      default_board.move_piece(2,4,6)
      default_board.move_piece(2,5,6)
      default_board.move_piece(2,6,6)
      default_board.move_piece(2,7,7) 
      default_board.move_piece(2,7,8)
      default_board.move_piece(2,7,9)
      default_board.move_piece(2,4,8)
      default_board.move_piece(2,4,9)
      default_board.move_piece(2,5,8)
      default_board.move_piece(2,5,9)      
      default_board.move_piece(2,6,10)
      expect(default_board.check_adjacents(2,6,10)).to eq(true)
    end

    it "T shaped black moves surrounded by white moves" do
      default_board.move_piece(1,2,3)
      default_board.move_piece(1,2,4)
      default_board.move_piece(1,2,5)
      default_board.move_piece(1,3,4)
      default_board.move_piece(1,4,4)
           
      default_board.move_piece(2,1,2)
      default_board.move_piece(2,1,3)
      default_board.move_piece(2,1,4)
      default_board.move_piece(2,1,5)
      default_board.move_piece(2,1,6)
      default_board.move_piece(2,2,2)
      default_board.move_piece(2,2,6)
      default_board.move_piece(2,3,3)
      default_board.move_piece(2,3,5)
      default_board.move_piece(2,4,3)
      default_board.move_piece(2,4,5)
      default_board.move_piece(2,5,4)

      expect(default_board.check_adjacents(2,5,4)).to eq(true)
    end

    it "Diagonal shaped black moves surrounded by white moves" do
      default_board.move_piece(1,6,8)
      default_board.move_piece(1,7,7)
      default_board.move_piece(1,8,6)

      default_board.move_piece(2,6,7)
      default_board.move_piece(2,7,6)
      default_board.move_piece(2,8,5)
      default_board.move_piece(2,8,7)
      default_board.move_piece(2,7,8)

      expect(default_board.check_adjacents(2,7,8)).to eq(true)
    end

    it "Black row and then White row bounded by top horizontal boundary" do
    
      19.times do |col|
         default_board.move_piece(1,0,col)
      end   
    
      18.times do |col|
        default_board.move_piece(2,1,col)
        expect(default_board.check_adjacents(2,1,17)).to eq(false)
      end
      default_board.move_piece(2,1,18)
      expect(default_board.check_adjacents(2,1,18)).to eq(true)
    end

    it "Black row and then White row bounded by bottom horizontal boundary" do
    
      19.times do |col|
         default_board.move_piece(1,18,col)
      end   
    
      18.times do |col|
        default_board.move_piece(2,17,col)
        expect(default_board.check_adjacents(2,17,17)).to eq(false)
      end
      default_board.move_piece(2,17,18)
      expect(default_board.check_adjacents(2,17,18)).to eq(true)
    end

    it "White row between Black row and bottom horizontal boundary (suicide)" do
    
      19.times do |col|
         default_board.move_piece(1,17,col)
      end   
    
      18.times do |col|
        default_board.move_piece(2,18,col)
        expect(default_board.check_adjacents(2,18,17)).to eq(false)
      end
      default_board.move_piece(2,18,18)
      expect(default_board.check_adjacents(1,18,18)).to eq(true)

    end

    it "Black column and then White column bounded by left vertical boundary" do
    
      19.times do |row|
         default_board.move_piece(1,row,0)
      end   
    
      18.times do |row|
        default_board.move_piece(2,row,1)
        expect(default_board.check_adjacents(2,17,1)).to eq(false)
      end
      default_board.move_piece(2,18,1)
      expect(default_board.check_adjacents(2,18,1)).to eq(true)
    end
  end  
end
