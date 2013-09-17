require_relative 'game.rb'
require_relative 'cell.rb'

class World

	attr_accessor :rows, :cols, :cell_grid, :cells

  def initialize(rows = 10, cols = 10)
    @rows = rows
    @cols = cols
    @cells = []

    @cell_grid = Array.new(rows) do |row|
      Array.new(cols) do |col|
        Cell.new(col, row)
      end
    end

    cell_grid.each do |row|
      row.each do |element|
        if element.is_a?(Cell)
          cells << element
        end
      end
    end
  end

  def cell_live_neighbours(cell)

    live_neighbours = []

    if cell.y < (rows - 1)
      # Top
      candidate = self.cell_grid[cell.y + 1][cell.x]
      live_neighbours << candidate if candidate.alive?
    end

    if cell.y < (rows - 1) && cell.x < (cols - 1)
      # Top right
      candidate = self.cell_grid[cell.y + 1][cell.x + 1]
      live_neighbours << candidate if candidate.alive?
    end

    if cell.x < (cols - 1)
      # Right
      candidate = self.cell_grid[cell.y][cell.x + 1]
      live_neighbours << candidate if candidate.alive?
    end

    if cell.y > 0 && cell.x < (cols - 1)
      # Bottom right
      candidate = self.cell_grid[cell.y - 1][cell.x + 1]
      live_neighbours << candidate if candidate.alive?
    end

    if cell.y > 0
      # bottom
      candidate = self.cell_grid[cell.y - 1][cell.x]
      live_neighbours << candidate if candidate.alive?
    end

    if cell.y > 0 && cell.x > 0
      # Bottom left
      candidate = self.cell_grid[cell.y - 1][cell.x - 1]
      live_neighbours << candidate if candidate.alive?
    end

    if cell.x > 0
      # Left
      candidate = self.cell_grid[cell.y][cell.x - 1]
      live_neighbours << candidate if candidate.alive?
    end

    if cell.y < (rows - 1) && cell.x > 0
      # Top left
      candidate = self.cell_grid[cell.y + 1][cell.x - 1]
      live_neighbours << candidate if candidate.alive?
    end

    live_neighbours
  end

  def randomly_update
    cells.each { |cell| cell.alive = [true, false].sample }
  end

end


