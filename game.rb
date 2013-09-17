require_relative 'world.rb'
require_relative 'cell.rb'

class Game
	attr_accessor :world, :cells

	def initialize(world = World.new, cells = [])
		@world = world
		@cells = cells
		@cells = []

		cells.each do |cell|
			world.cell_grid[cell[0]][cell[1]].alive = true
		end
	end

	def step!
    live_in_next_step = []
    dead_in_next_step = []

    world.cells.each do |cell|
      neighbour_count = world.cell_live_neighbours(cell).count
      case
        when cell.alive? && neighbour_count < 2
          dead_in_next_step << cell
        when cell.alive? && ([2, 3].include? neighbour_count)
          live_in_next_step << cell
        when cell.alive? && neighbour_count > 3
          dead_in_next_step << cell
        when cell.dead? && neighbour_count == 3
          live_in_next_step << cell
      end
    end

    live_in_next_step.each { |cell| cell.revive! }
    dead_in_next_step.each { |cell| cell.die! }

	end
end
