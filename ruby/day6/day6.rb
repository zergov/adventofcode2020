require 'set'

p1 = 0
p2 = 0
for group in File.read('input').split("\n\n")
  s = Set.new

  person_count = group.split("\n").size
  yeps = {}
  for answer in group.split("\n")
    answer.chars.each { |c| s.add(c) }
    answer.chars.each { |c| yeps.key?(c) ? yeps[c] += 1 : yeps[c] = 1 }
  end

  p1 += s.size
  p2 += yeps.values.select { |n| n == person_count }.size
end

p p1
p p2
