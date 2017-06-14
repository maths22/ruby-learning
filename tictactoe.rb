class Board
    def initialize
        @state = [
            [' ',' ',' '],
            [' ',' ',' '],
            [' ',' ',' ']
        ]
    end

    def play_piece(x, y, player)
        return false if !(0 .. 2).cover?(x) || !(0 .. 2).cover?(y)
        return false if @state[x][y] != ' '
        @state[x][y] = player
        return true
    end

    def winner
        (0..2).each do |i|
            row = @state[i]
            if(row[0] != ' ' && row[0] == row[1] && row[0] == row[2])
                return row[0]
            end
            row = [@state[0][i], @state[1][i], @state[2][i]]
            if(row[0] != ' ' && row[0] == row[1] && row[0] == row[2])
                return row[0]
            end
        end
        if(@state[0][0] != ' ' && @state[0][0] == @state[1][1] && @state[0][0] == @state[2][2])
            return @state[0][0]
        end

        if(@state[0][2] != ' ' && @state[0][2] == @state[1][1] && @state[0][2] == @state[2][0])
            return @state[0][2]
        end

        is_full = true
        @state.each do |row|
            row.each do |cell|
                if cell == ' '
                    is_full = false
                    return
                end
            end
        end

        if is_full
            return 'T'
        end

        return nil
    end

    def to_s
        body = @state.each_with_index.map {|x, i| (i + 1).to_s + ' ' + x.join(' | ') + ' '} . join("\n    |   |   \n ---+---+---\n    |   |   \n")
        "  1   2   3 \n    |   |   \n" + body + "\n    |   |   \n"
    end
end

the_board = Board.new
player = 'X'

while the_board.winner.nil?
    puts the_board
    puts
    success = false
    while !success
        puts "Player " + player + ", please select a row:"
        row = gets.to_i - 1
        puts "Please select a column:"
        column = gets.to_i - 1
        success = the_board.play_piece row, column, player
        puts
        if !success
            puts "Invalid move.  Please try again."
        end 
    end
    player = player == 'X' ? 'O' : 'X'
end

puts the_board
puts

if the_board.winner == 'T'
    puts 'The players tied :('
else
    puts 'Player ' + the_board.winner + ' wins!'
end