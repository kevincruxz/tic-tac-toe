class Player
    @@board = [[nil, nil, nil], [nil, nil, nil], [nil, nil, nil]]
    attr_reader :name

    def initialize(name, symbol)
        @name = name
        @symbol = symbol
    end

    def new_election(coord)
        if coord <= 3
            @@board[0][coord - 1] = @symbol
        elsif coord <= 6
            @@board[1][coord - 4] = @symbol
        else
            @@board[2][coord - 7] = @symbol
        end
    end

    def board
        @@board
    end

    def check_if_winner
        counter = 0
        # Check if winner horizontally
        @@board.each do |row|
            row.each do |square|
                if square == @symbol
                    counter += 1
                    if counter == 3
                        return true
                    end
                end
            end
            counter = 0
        end
        # Check if winner vertically
        for i in (0..2) do
            for j in (0..2) do
                if @@board[j][i] == @symbol
                    counter += 1
                    if counter == 3
                        return true
                    end
                end
            end
            counter = 0
        end
        # Check if winner diagonal
        if @@board[0][0] == @symbol && @@board[1][1] == @symbol && @@board[2][2] == @symbol or #Checks first diagonal
            @@board[0][2] == @symbol && @@board[1][1] == @symbol && @@board[2][0] == @symbol #Checks second diagonal
            return true
        end
            
        false # returns false if it is not a winner yet
    end
end

# Make a function to display the current board
def print_board(array)
    str = ""
    array.each_with_index do |row, j|
        row.each_with_index do |element, i|
            if i == 0 || i == 2
                if element == nil
                   if j == 2
                       str += " #{7 + i} "
                   else 
                       str += " #{i + ((j + 1) * (j + 1))} " 
                   end
                else
                    str += " #{element} "
                end
            else
                if element == nil
                    if j == 2
                        str += "| #{7 + i} |"
                    else 
                        str += "| #{i + ((j + 1) * (j + 1))} |"
                    end
                else
                    str += "| #{element} |"
                end
            end
        end
        str += "\n---+---+---\n" unless j == 2
    end
    str
end 

def game_start
    print "Player 1, Write your name: "
    name = gets.chomp
    print "Hello #{name}!, now choose the symbol with you will play with: "
    symbol = gets.chomp
    while symbol.ord <= 32 || symbol.ord >= 48 && symbol.ord <= 57 || symbol.length != 1
        print "Invalid symbol! Enter another one (1 character long, no numbers): "
        symbol = gets.chomp
    end
    player1 = Player.new(name, symbol) #Creating the object for the player #1
    puts "Ok player 1, all set, your name is #{name} & your symbol is #{symbol}\n"
    
    print "Player 2, Write your name: "
    name = gets.chomp
    print "Hello #{name}!, now choose the symbol with you will play with: "
    symbol = gets.chomp
    while symbol.ord <= 32 || symbol.ord >= 48 && symbol.ord <= 57 || symbol.length != 1
        print "Invalid symbol! Enter another one (1 character long, no numbers): "
        symbol = gets.chomp
    end
    player2 = Player.new(name, symbol) #Creating the object for the player #2
    puts "Ok player 2, all set, your name is #{name} & your symbol is #{symbol}\n"

    game(player1, player2)
end

def game(player1, player2)
    is_winner = false
    move = 0
    while true
        validate_election(player1)
        is_winner = player1.check_if_winner
        if is_winner
            puts print_board(player1.board)
            puts "#{player1.name} wins!"
            break
        end
        move += 1

        if move == 9 # In tic tac toe it is only posible to do 9 moves, until there is a tie
            puts print_board(player1.board)
            puts "Oh man! it's a tie." 
            break
        end

        validate_election(player2)
        is_winner = player2.check_if_winner 
        if is_winner
            puts print_board(player2.board)
            puts "#{player2.name} wins!"
            break
        end
        move += 1
    end
end

def validate_election(player)
    election = ""
    board = player.board
    while true
        puts print_board(board)
        print "#{player.name}, choose your next move: "
        election = gets.chomp
        
        election = election.to_i
        
        if election <= 3 && election > 0
            if board[0][election - 1] == nil
                break 
            end
        elsif election <= 6 && election >= 4
            if board[1][election - 4] == nil
                break 
            end
        elsif election <= 9 && election >= 7
            if board[2][election - 7] == nil
                break 
            end
        else
            puts "Wut?."
        end
    end
    player.new_election(election)
end

game_start()