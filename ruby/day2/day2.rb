p1 = 0
p2 = 0
File.read('input').lines do |line|
  range, letter, password = line.strip.split(' ')
  low, high = range.split('-').map(&:to_i)
  letter = letter[0]

  if password.count(letter) >= low && password.count(letter) <= high
    p1 += 1
  end

  if [password[low-1], password[high-1]].count(letter) == 1
    p2 += 1
  end
end

p p1
p p2
