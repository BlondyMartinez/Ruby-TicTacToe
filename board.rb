class Board
  def initialize
    # 3x3
    @grid = Array.new(3) { Array.new(3, ' ') }
  end

  def [](row, col)
    @grid[row][col]
  end

  def []=(row, col, value)
    @grid[row][col] = value
  end

  def display
    @grid.each_with_index do |row, index|
      puts ' ' + row.join(' | ') + ' '
      puts '---|---|---' if index != 2
    end
  end

  def cell_empty?(row, col)
    @grid[row][col] == ' '
  end
end