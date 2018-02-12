
#!/usr/bin/ruby
###############################################################
#
# CSCI 305 - Ruby Programming Lab
#
# GiantFrog
# ***REMOVED***
#
###############################################################

$bigrams = Hash.new # The Bigram data structure; I am using a hash filled with hashes.
$name = "GiantFrog"

# function to process each line of a file and extract the song titles
def process_file(file_name)
  puts "Processing File.... "

  begin
    #if RUBY_PLATFORM.downcase.include? 'mswin'
		if true
      file = File.open(file_name, encoding: "utf-8")
      unless file.eof?
        file.each_line do |line|
          # do something for each line (if using windows)
          tally_words(cleanup_title(line).split)
        end
      end
      file.close
    else
      IO.foreach(file_name, encoding: "utf-8") do |line|
        # do something for each line (if using macos or linux)
				tally_words(cleanup_title(line).split)
      end
    end

    puts "Finished. Bigram model built.\n"
  rescue
    STDERR.puts "Could not open file"
		exit 4
  end
end

# Makes extracted titles readable
def cleanup_title (title)
	title.slice!(/.*<SEP>/)                           #gets title and tosses all other data
	title.slice!(/([\(\[\{\\\/_\-:"`+=*]|feat\.).*/)  #trims anything off the title after certain symbols
	title.gsub!(/[\?¿\!¡\.;&@%#\|"]/, '') 		  			#removes a couple symbols
	#title.gsub!(/\ba\b/, '')
	#title.gsub!(/\ban\b/, '')												#this ugly thing gets rid of stop words
	#title.gsub!(/\band\b/, '')
	#title.gsub!(/\bby\b/, '')
	#title.gsub!(/\bfor\b/, '')
	title.gsub!('from', '')
	title.gsub!(/\bin\b/, '')
	#title.gsub!(/\bof\b/, '')
	#title.gsub!(/\bon\b/, '')
	#title.gsub!(/\bor\b/, '')
	#title.gsub!(/\bout\b/, '')
	#title.gsub!(/\bthe\b/, '')
	#title.gsub!(/\bto\b/, '')
	#title.gsub!(/\bwith\b/, '')

	if title.match(/[^\w|\s']/)                       #if the title has weird characters, toss it
		return ''
	else
		title.downcase!																	#otherwise, return it in lowercase
		return title
  end
end

# Adds counts to $bigrams
def tally_words (words)
	words.each_cons(2) do |pair|
		starting = pair[0].to_sym
		following = pair[1].to_sym

		unless $bigrams[starting]							#if the word has not been seen before, add a hash for it which defaults to 0
			$bigrams[starting] = Hash.new(0)		#word on the street is that symbols are faster than strings
		end
		$bigrams[starting][following] += 1
	end
end

# Takes a word and returns the most likely word to follow
def mcw (word)
	wordSym = word.to_sym
	bestWords = Array.new

	if $bigrams[wordSym]													#if the word has been recorded before,
		$bigrams[wordSym].each do |key, tally|			#go through each value. If it has the max tally, add it to the list to
			if tally == $bigrams[wordSym].values.max 	#randomly pick from.
				bestWords << key.to_s
			end
		end
	end
	if bestWords.size > 0
		return bestWords[rand(bestWords.size)]			#[0] to [size-1]
	else return ''
	end
end

# Takes a word and guesses a good song title based off of it
def create_title (seed)
	generated = [seed]										#start with the seed

	while generated.size < 20 do					#unless there are 20 words, keep adding the most common on to the end
		generated << mcw(generated.last)
		if generated.last == ''							#if there was no data, break out of the loop
			generated.pop											#and get rid of the empty entry
			break
		end
	end

	title = ''
	generated.each do |word|
		title << word << ' '
	end
	title.chomp!(' ')
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
	while true
		puts "Enter a word [Enter 'q' to quit]: "
		seed = STDIN.gets.chomp
		if seed == 'q'
			break
		else
			title = create_title(seed)
			puts title
		end
	end
end

if __FILE__==$0
	main_loop()
end
