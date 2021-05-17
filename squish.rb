#!/usr/bin/ruby

require 'fileutils'
require 'vips'

#Change these to your desired thresholds
$max_height = 700
$max_width = 700

#Checks if the image dimensions are below the height and width thresholds
def check_dimensions(image)
    if image.height < $max_height and image.width < $max_width
        return true
    else
        return false
    end
end


sweet_ascii = "
           ____________________
          /\\  _______  _______ \\
         /  \\ \\     /\\ \\     /\\ \\
        / /\\ \\ \\   /  \\ \\   /  \\ \\
       / /  \\ \\ \\ /    \\ \\ /    \\ \\
      / /    \\ \\ \\______\\ \\______\\ \\
     / /______\\ \\  _______  _______ \\
    /  \\      /  \\ \\     /\\ \\     /\\ \\
   / /\\ \\    / /\\ \\ \\   /  \\ \\   /  \\ \\
  / /  \\ \\  / /  \\ \\ \\ /    \\ \\ /    \\ \\
 / /    \\ \\/ /    \\ \\ \\______\\ \\______\\ \\                      ___________
/ /______\\  /______\\ \\___________________\\                    /\\  _______ \\
\\ \\      /  \\      / / ______   ______   /                   /  \\ \\     /\\ \\
 \\ \\    / /\\ \\    / / /      / /      / /                   / /\\ \\ \\   /  \\ \\
  \\ \\  / /  \\ \\  / / / \\    / / \\    / /                   / /  \\ \\ \\ /    \\ \\
   \\ \\/ /    \\ \\/ / /   \\  / /   \\  / /      >>>>>>       / /    \\ \\ \\______\\ \\
    \\  /______\\  / /_____\\/ /_____\\/ /       SQUISH      / /______\\ \\__________\\
     \\ \\      / / _______  _______  /        >>>>>>      \\ \\      / /  ______  /
      \\ \\    / / /      / /      / /                      \\ \\    / / /      / /
       \\ \\  / / / \\    / / \\    / /                        \\ \\  / / / \\    / /
        \\ \\/ / /   \\  / /   \\  / /                          \\ \\/ / /   \\  / /
         \\  / /_____\\/ /_____\\/ /                            \\  / /_____\\/ /
          \\/___________________/                              \\/__________/
\n"

puts sweet_ascii
puts "Squishing images to < #{$max_height}x#{$max_width}!"

#Creates a directory for the resized images
FileUtils.mkdir_p "squished" unless File.exists? "squished"
puts "Resized images will be placed into '/squished'."

#Cycles through all png's in the current directory...
Dir.glob("*.png") do |image_name|
    puts "\nSquishing: #{image_name}..."
    #Opens the image with Vips
    current_image = Vips::Image.new_from_file "#{image_name}"
    #While the dimensions are above the thresholds, resizes the image by a factor of 0.9, then checks again
    while check_dimensions(current_image) == false do
        current_image = current_image.resize 0.9
    end
    #Writes the resized image into the 'squished' directory
    current_image.write_to_file "squished/#{image_name}"
    puts "Successfully resized #{image_name}."
end

puts "\nAll images squished!"