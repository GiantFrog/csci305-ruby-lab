
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
$name = "<firstname> <lastname>"

# function to process each line of a file and extract the song titles
def process_file(file_name)
	puts "Processing File.... "

	begin
		IO.foreach(file_name, encoding: "utf-8") do |line|
			# do something for each line
		end

		puts "Finished. Bigram model built.\n"
	rescue
		STDERR.puts "Could not open file"
		exit 4
	end
end

# Makes extracted titles readable
def cleanup_title(title)
	title.slice!(/.*<SEP>/)				#gets title and tosses all other data
	title.slice!(/([\(\[\{\\\/_\-:"`+=*]|feat\.).*/)#trims anything off the title after certain symbols
	title.slice!(/[\?¿!¡.;&@%#\|]/) 		#removes some other symbols
	title.slice!(/[^\w|\s]/)			#removes everything besides english letters and whitespace, which should
	title.downcase!					#get rid of the earlier symbols too, but whatever.
	return title
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
