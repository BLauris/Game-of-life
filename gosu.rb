require 'gosu'
require_relative 'game.rb'

class GameWindow < Gosu::Window
	def initialize(height=1200, width=600)
		@height = height
		@width = width

		# Define window width, height and full screan 
		super height, width, false

		# Colors for grid, live cells and dead cells
		@background_color = Gosu::Color.new(0xffdedede)
		@cell_is_alive = Gosu::Color.new(0xffB2207C)
		@cell_is_dead = Gosu::Color.new(0xffdedede)

		# Define width and height for colls ans rows
		@colls = width/10
		@rows = height/10
		@width = width/@colls
		@height = height/@rows

		# Define new game
		@world = World.new(@colls, @rows)
		@game = Game.new(@world)
		@game.world.randomly_update
	end

	# By default game is updating 16x per second
	def update
		@game.step!
	end

	# Draw grid and cells
	def draw
		board_grid
		working_cells
	end

	# Setting up live cells and dead cells
	def working_cells
		@game.world.cells.each do |cell|
			if cell.alive?
				# Live cells
				draw_quad(
									cell.x * @width, cell.y * @height, @cell_is_alive,
									cell.x * @width + @width, cell.y * @height, @cell_is_alive,
									cell.x * @width + @width, cell.y * @height + @height, @cell_is_alive,
									cell.x * @width, cell.y * @height + @height, @cell_is_alive
								 )
			else
				# Dead cells
				draw_quad(
									cell.x * @width, cell.y * @height, @cell_is_dead,
									cell.x * @width + @width, cell.y * @height, @cell_is_dead,
									cell.x * @width + @width, cell.y * @height + @height, @cell_is_dead,
									cell.x * @width, cell.y * @height + @height, @cell_is_dead
								 )
			end
		end
	end

	# Setting up an board
	def board_grid
		draw_quad(0, 0, @background_color, width, 0, @background_color,  width, height, @background_color, 0, height, @background_color)
	end
end


# Outputs game
game = GameWindow.new
game.show
