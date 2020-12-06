require 'set'

def b(s, e, str)
  for i in str.chars
    case str[i]
    when "F", "L"
      e = (s + e) / 2
    when "B", "R"
      s = ((s + e) / 2) + 1
    end
  end

  s
end

p1 = []
seats = Set.new
(0..127).to_a.each do |r|
  (0..7).to_a.each do |c|
    seats.add("#{r}:#{c}")
  end
end

File.read('input').lines.each.with_index do |line, i|
  line = line.strip

  row = b(0, 127, line[..6])
  col = b(0, 7, line[7..9])
  p1 << row * 8 + col
  seats.delete("#{row}:#{col}")
end

p p1.max
p seats.to_a # 76:7 was the the one seats not in the front / back
