def adjacents(seats, i, j)
  neighbors = [
    [i + 1, j],
    [i - 1, j],
    [i, j + 1],
    [i, j - 1],

    [i - 1, j + 1],
    [i + 1, j + 1],
    [i - 1, j - 1],
    [i + 1, j - 1],
  ]

  neighbors
    .select { |i, j| i >= 0 && i < seats.size && j >= 0 && j < seats.first.size }
    .map { |i, j| seats[i][j] }
end


def adjacents2(seats, i, j)
  neighbors = []
  [
    [1, 0],
    [-1, 0],
    [0, 1],
    [0, -1],
    [-1, 1],
    [1, 1],
    [-1, -1],
    [1, -1],
  ].each do |di, dj|
    ii = i
    jj = j

    [seats.size, seats.first.size].max.times do
      ii += di
      jj += dj

      if ii >= 0 && ii < seats.size && jj >= 0 && jj < seats.first.size && (seats[ii][jj] == "#" || seats[ii][jj] == "L")
        neighbors << [ii, jj]
        break
      end
    end
  end

  neighbors.uniq.map { |i, j| seats[i][j] }
end

grid = []
File.read('input').lines.map(&:strip).each do |line|
  grid << line.chars
end

loop do
  changed = false
  grid = grid.map.with_index do |row, i|
    row.map.with_index do |col, j|
      if col == "L" && adjacents2(grid, i, j).all? { |s| s != "#" }
        changed = true
        "#"
      elsif col == "#" && adjacents2(grid, i, j).count { |s| s == "#"} >= 5
        changed = true
        "L"
      else
        col
      end
    end
  end

  break unless changed
end

p grid.flatten.count { |s| s == "#" }
