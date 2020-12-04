def valid?(passport)
  byr = passport["byr"].to_i
  iyr = passport["iyr"].to_i
  eyr = passport["eyr"].to_i
  hgt = passport["hgt"]
  hcl = passport["hcl"]
  ecl = passport["ecl"]
  pid = passport["pid"]

  return unless byr.between?(1920, 2002)
  return unless iyr.between?(2010, 2020)
  return unless eyr.between?(2020, 2030)

  if hgt.match?(/\d*cm/)
    return unless hgt[..-3].to_i.between?(150, 193)
  elsif hgt.match?(/\d*in/)
    return unless hgt[..-3].to_i.between?(59, 76)
  else
    return false
  end

  return unless hcl[0] == "#" && hcl.size == 7
  return unless hcl[1..].chars.all? { |c| %w(0 1 2 3 4 5 6 7 8 9 a b c d e f).include?(c) }
  return unless %w(amb blu brn gry grn hzl oth).include?(ecl)
  return unless pid.match?(/\d*/) && pid.size == 9
  true
end

p1 = 0
p2 = 0
passport = {}
valid_fields = ["byr", "iyr", "eyr", "hgt", "hcl", "ecl", "pid"]

File.read('input').lines do |line|
  line = line.strip

  unless line == ""
    line.strip.split(" ").each do |x|
      key, val = x.split(":")
      passport[key] = val
    end
  else
    p line
    fields = passport.keys

    if valid_fields.all? { |f| fields.include?(f) }
      p1 += 1
      p2 += 1 if valid?(passport)
    end

    passport = {}
  end
end

p p1
p p2
