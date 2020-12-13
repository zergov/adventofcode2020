def contains_shiny_gold?(bag, bags)
  bags[bag].keys.any? { |b| b == "shiny gold" || contains_shiny_gold?(b, bags) }
end

def count_bags(bag, bags)
  count = 0
  for b, n in bags[bag]
    count += n + (n * count_bags(b, bags))
  end

  count
end

bags = {} # <bag: {bag: n}>
File.read("input").lines.map(&:strip).each do |line|
  bag, contained = line.split("contain").map(&:strip).map(&:chop)
  bag = bag.split(" ")[0...-1].join(" ")
  bags[bag] = {}

  unless contained.include?("no other bags")
    for bb in contained.split(",").map(&:strip)
      n, b = bb.split(" ", 2)
      b = b.split(" ")[0...-1].join(" ")

      if bags.key?(bag)
        bags[bag][b] = n.to_i
      else
        bags[bag] = {}
        bags[bag][b] = n.to_i
      end
    end
  end
end

p bags.keys.select { |bag| contains_shiny_gold?(bag, bags) }.size
p count_bags("shiny gold", bags)
