grid = []
File.read('input').lines do |line|
  grid << line.strip.chars
end

def slope(i, j, di, dj, grid)
  max_i = grid.size

  trees = 0
  loop do
    i += di
    j += dj

    jj = j % grid[0].size

    if i >= max_i
      return trees
    end

    if grid[i][jj] == "#"
      trees += 1
    end
  end
end

p slope(0, 0, 1, 3, grid)

trees = []
trees << slope(0, 0, 1, 1, grid)
trees << slope(0, 0, 1, 3, grid)
trees << slope(0, 0, 1, 5, grid)
trees << slope(0, 0, 1, 7, grid)
trees << slope(0, 0, 2, 1, grid)

p trees.inject(&:*)
