# All spaces in numbers have been replaced with the letter 'x' to avoid issues with indentation, IDE finickiness, etc. 

class Numbers
   ZERO = <<-EOL.chomp
x_x
|x|
|_|
EOL

   ONE = <<-EOL.chomp
xxx
xx|
xx|
EOL

   TWO = <<-EOL.chomp
x_x
x_|
|_x
EOL

   THREE = <<-EOL.chomp
x_x
x_|
x_|
EOL

   FOUR = <<-EOL.chomp
xxx
|_|
xx|
EOL

   FIVE = <<-EOL.chomp
x_x
|_x
x_|
EOL

   SIX = <<-EOL.chomp
x_x
|_x
|_|
EOL

   SEVEN = <<-EOL.chomp
x_x
xx|
xx|
EOL

   EIGHT = <<-EOL.chomp
x_x
|_|
|_|
EOL

   NINE = <<-EOL.chomp
x_x
|_|
x_|
EOL
   def self.grids
      [ZERO, ONE, TWO, THREE, FOUR, FIVE, SIX, SEVEN, EIGHT, NINE]
   end
end