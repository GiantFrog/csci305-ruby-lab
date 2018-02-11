
#!/usr/bin/ruby
###############################################################
#
# CSCI 305 - Ruby Programming Lab
#
# GiantFrog
# ***REMOVED***
#
###############################################################

$bigrams = Hash.new # The Bigram data structure
$name = "GiantFrog"

# function to process each line of a file and extract the song titles
def process_file(file_name)
  puts "Processing File.... "

  begin
    if RUBY_PLATFORM.downcase.include? 'mswin'
      file = File.open(file_name)
      unless file.eof?
        file.each_line do |line|
          # do something for each line (if using windows)
          cleanup_title(line)
        end
      end
      file.close
    else
      IO.foreach(file_name, encoding: "utf-8") do |line|
        # do something for each line (if using macos or linux)
      end
    end

    puts "Finished. Bigram model built.\n"
  rescue
    STDERR.puts "Could not open file"
		exit 4
  end
end

# Makes extracted titles readable
def cleanup_title(title)
	title.slice!(/.*<SEP>/)                           #gets title and tosses all other data
	title.slice!(/([\(\[\{\\\/_\-:"`+=*]|feat\.).*/)  #trims anything off the title after certain symbols
	dirty = true
	while dirty
		if not title.slice!(/[\?¿\!¡\.;&@%#\|"]/) 		  #my "global search" keeps slicing off characters until
			dirty = false																	#the title is clean, then moves on.
		end
	end

	if title.match(/[^\w|\s']/)                       #if the title has weird characters, toss it
		return nil
	else
		title.downcase!																	#otherwise, return it in lowercase
		return title
  end
end

# Executes the program
def main_loop()
	puts "CSCI 305 Ruby Lab submitted by #{$name}"

	if ARGV.length < 1
		puts "You must specify the file name as the argument."
		exit 4
	end

	# process the file
	process_file(ARGV[0])

	# Get user input
end

if __FILE__==$0
	main_loop()
end
