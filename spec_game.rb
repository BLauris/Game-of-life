require 'rspec'
require_relative 'game.rb'
require_relative 'cell.rb'
require_relative 'world.rb'

describe "game of life" do

	let(:world) { World.new }
	let(:cell) { Cell.new(1, 1) }

	context "world" do
		subject { World.new }

		it "Should create a new world" do
			subject.is_a?(World).should be_true
		end

		it "should hawe rows and cols" do
			subject.should respond_to(:rows)
			subject.should respond_to(:cols)
			subject.should respond_to(:cell_grid)
			subject.should respond_to(:cell_live_neighbours)
			subject.should respond_to(:cells)
			subject.should respond_to(:randomly_update)
			# subject.should respond_to(:live_cells)	
		end

		it "Should create an propper grid" do
			subject.cell_grid.is_a?(Array).should be_true
			subject.cell_grid.each do |row|
				row.is_a?(Array).should be_true
				row.each do |col|
					col.is_a?(Cell).should be_true
				end
			end
		end

		it "should add all cells" do
			subject.cells.count.should == 100
		end

		it "Detects live cell top" do
			subject.cell_grid[cell.y + 1][cell.x].alive = true
			subject.cell_live_neighbours(cell).count.should == 1
		end

		it "Detects live cell top-right" do
			subject.cell_grid[cell.y + 1][cell.x + 1].alive = true
			subject.cell_live_neighbours(cell).count.should == 1
		end

		it "Detects live cell right" do
			subject.cell_grid[cell.y ][cell.x + 1].alive = true
			subject.cell_live_neighbours(cell).count.should == 1
		end

		it "Detects live cell bottom-right" do
			subject.cell_grid[cell.y - 1][cell.x + 1].alive = true
			subject.cell_live_neighbours(cell).count.should == 1
		end

		it "Detects live cell bottom" do
			subject.cell_grid[cell.y - 1][cell.x].alive = true
      subject.cell_live_neighbours(cell).count.should == 1
		end

		it "Detects live cell bottom-left" do
			subject.cell_grid[cell.y - 1][cell.x - 1].alive = true
			subject.cell_live_neighbours(cell).count.should == 1
		end

		it "Detects live cell left" do
			subject.cell_grid[cell.y][cell.x - 1].alive = true
			subject.cell_live_neighbours(cell).count.should == 1
		end

		it "Detects live cell top-left" do
			subject.cell_grid[cell.y + 1][cell.x - 1].alive = true
			subject.cell_live_neighbours(cell).count.should == 1
		end

		# it "should randomly populate cells" do
		# 	subject.live_cells.count.should == 0
		# 	subject.randomly_update
		# 	subject.live_cells.count.should_not == 0
		# end

	end

	context "Cell" do
		subject {Cell.new}

		it "should create new cell" do
			subject.is_a?(Cell).should be_true
		end

		it "Should be alive" do
			subject.should respond_to(:alive)
			subject.should respond_to(:x)
			subject.should respond_to(:y)
			subject.should respond_to(:alive?)
			subject.should respond_to(:die!)
		end

		it "Should properly initialize" do
			subject.alive.should be_false
			subject.x.should == 0
			subject.y.should == 0
		end
	end

	context "Game" do
		subject {Game.new}

		it "should create new game" do
			subject.is_a?(Game).should be_true
		end

		it "should use propper methods" do
			subject.should respond_to(:world)
			subject.should respond_to(:cells)
		end

		it "Should propperly initialize" do
			subject.world.is_a?(World).should be_true
			subject.cells.is_a?(Array).should be_true
		end

		it "should add" do
			game = Game.new(world, [[1,2], [0,2]])
			world.cell_grid[1][2].should be_alive
			world.cell_grid[0][2].should be_alive
		end
	end

	context "Rules" do
		let(:game) {Game.new}

		context "Rule Nr.1" do
			it "should kill a cell if has none neighbor" do
				game.world.cell_grid[1][1].alive = true
				game.world.cell_grid[1][1].should be_alive
				game.step!
				game.world.cell_grid[1][1].should be_dead
			end

			it "Should kill a cell if has one neighbor" do
				game = Game.new(world, [[1,0], [2,0]])
				game.step!
				world.cell_grid[1][0].should be_dead
				world.cell_grid[2][0].should be_dead
			end

			it "does not kill live cell with two neighbors" do
				game = Game.new(world, [[0, 1], [1, 1], [2, 1]])
				# binding.pry
        game.step!
        world.cell_grid[1][1].should be_alive
			end
		end
	end
end
