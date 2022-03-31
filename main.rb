# Construir 1 clase llamada Player donde se guardaran las elecciones de cada jugador
# El tablero va a ser un array donde pa checar el ganador se loopeara cada que se haga una eleccion
# Cada que se haga la eleccion se comprobara si hay ganador primero horizontal (3), luego vertical (3) 
# Y luego diagonal (2) 
# Pa las elecciones se usara otra clase llamada Election, donde se crearan los objetos, estos objetos
# Seran pasados a Player cada que se cree uno nuevo y se colocaran dentro del array tablero
# El juego en si va a ser una loop de preguntas sobre donde colocar su eleccion (1 - 9)
# 

class Player
    @@board = Array.new(3, 3)
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
end

# Make a function to display the current board
def print_board(array)
    str = "__|__|__\n"
    str +="__|__|__\n"
    str +="  |  |  "
end 

def game_start
    print "Player 1, Write your name: "
    name = gets.chomp
    print "Hello #{name1}!, now choose the symbol with you will play with: "
    symbol = gets.chomp
    player1 = Player.new(name, symbol) #Creating the object for the player #1
    puts "Ok player 1, all set, your name is #{name} & your symbol is #{symbol}\n"
    
    print "Player 2, Write your name: "
    name = gets.chomp
    print "Hello #{name1}!, now choose the symbol with you will play with: "
    symbol = gets.chomp
    player2 = Player.new(name, symbol) #Creating the object for the player #2
    puts "Ok player 2, all set, your name is #{name} & your symbol is #{symbol}\n"

    game(player1, player2)
end

def game(player1, player2)
     validate_election(player1)
     check_if_winner()

     validate_election(player2)
     check_if_winner()
end

def validate_election(player)
    while true
        puts print_board()
        print "#{player.name}, choose your next move: "
        election = gets.chomp
        while true
            begin
                election = election.to_i
            rescue
                puts "That is not a number."
            else
                if election <= 3 && election >= 0
                    break if player.board[0][election - 1] == nil
                elsif election <= 6 && election >= 4
                    break if player.board[election - 4] == nil
                elsif election <= 9 && election >= 7
                    break if player.board[2][election - 7] == nil
                else
                    puts "You cannot put your play there."
                end
            end
        end
        player.new_election(election)
    end
end

game_start()