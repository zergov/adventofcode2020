instructions = File.read('input').lines.map(&:strip)

def p1(instructions)
  position = [0, 0]
  angle = 90
  for line in instructions
    a = line[0]
    n = line[1...].to_i

    x, y = position

    case a
    when "N"
      y += n
    when "S"
      y -= n
    when "E"
      x += n
    when "W"
      x -= n
    when "R"
      angle = (angle + n) % 360
    when "L"
      angle = angle - n
      angle = 360 + angle if angle < 0
    when "F"
      case angle
      when 0 then y += n
      when 90 then x += n
      when 180 then y -= n
      when 270 then x -= n
      end
    end

    position = [x, y]
  end

  x, y = position
  p x.abs + y.abs
end

def p2(instructions)
  ship_position = [0, 0]
  waypoint_position = [10, 1]

  for line in instructions
    a = line[0]
    n = line[1...].to_i

    sx, sy = ship_position
    wx, wy = waypoint_position

    case a
    when "N"
      waypoint_position = [wx, wy + n]
    when "S"
      waypoint_position = [wx, wy - n]
    when "E"
      waypoint_position = [wx + n, wy]
    when "W"
      waypoint_position = [wx - n, wy]
    when "R"
      (n / 90).times { waypoint_position = [waypoint_position[1], -waypoint_position[0]] }
    when "L"
      (n / 90).times { waypoint_position = [-waypoint_position[1], waypoint_position[0]] }
    when "F"
      ship_position = [sx + wx * n, sy + wy * n]
    end
  end

  x, y = ship_position
  p x.abs + y.abs
end

p1(instructions)
p2(instructions)
