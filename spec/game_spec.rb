require_relative '../game.rb'

describe Game do
    let(:game) { Game.new }
  
    describe '#initialize' do
        it 'should create a new game instance' do
            expect(game).to be_an_instance_of(Game)
        end
    end
  
    describe '#make_move' do
        it 'should update the board with the player symbol' do
            player = Player.new('Player 1', 'X')
            game.make_move(player, 0, 0)
            expect(game.board[0, 0]).to eq('X')
        end
    end
  
    describe '#check_winner' do
        context 'when there is a winner' do
            it 'should return true' do
                game.board[0, 0] = 'X'
                game.board[0, 1] = 'X'
                game.board[0, 2] = 'X'
                expect(game.check_winner).to eq(true)
            end
        end
  
        context 'when there is no winner' do
            it 'should return false' do
                game.board[0, 0] = 'X'
                game.board[0, 1] = 'O'
                game.board[0, 2] = 'X'
                expect(game.check_winner).to eq(false)
            end
        end
    end
end