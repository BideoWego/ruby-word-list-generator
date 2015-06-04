def status(message, overwrite=false)
	STDOUT.flush
	print "\r"
	if overwrite		
		print message
	else

		puts message
	end
end

def progress(current, total, message)
	last = (current === total -1)
	percent = (last) ? '100' : ((current.to_f / total.to_f) * 1000).to_s[0..1]
	status(" -- Progress: " + percent + '%', true)
 	puts "" if last
end

def get_words(file)
	lines = []
	filename = file
	status("Opening: " + filename)
	file = File.open(file, 'r')
	num_lines = file.read.count("\n")
	file.close
	file = File.open(filename, 'r')
	status(" - Reading: " + filename)
	file.readlines.each_with_index do |l, i|
		progress(i, num_lines, " - Getting words: ")
		l = l.gsub(/\s/, '').gsub(/\n/, '').downcase
		lines << l
	end
	status(" - Closing: " + filename)
	file.close
	lines
end

def write_out(words)
	filename = 'out.txt'
	status("Writing output to: " + filename)
	file = File.exist?(filename) ? File.new(filename, 'w') : File.open(filename, 'w')
	words.each_with_index do |w, i|
		progress(i, words.size, " - Writing output: ")
		file.puts(w)
	end
	status(" - Output written!")
	file.close
	filename
end

def filter_words(ones, twos, words)
	filtered = []
	status("Filtering words")
	words.each_with_index do |w, i|
		progress(i, words.size, " - Filtering: ")
		filter = true
		if w.length == 1
			filter = false if ones.include?(w)
		elsif w.length == 2
			filter = false if twos.include?(w)
		elsif w.length > 2
			filter = false
		end
		filtered << w if not filter
	end
	status(" - Filter done!")
	filtered
end

def remove_duplicates(words)
	unique = []
	status("Removing duplicate words")
	words.each_with_index do |w, i|
		progress(i, words.size, " - Removing: ")
		filter = true
		if w.length == 1
			if not unique.include?(w)
				filter = false
			end
		else
			filter = false 
		end
		unique << w if not filter
	end
	status(" - Duplicate words removed!")
	unique
end

status("Initializing...")

ones = ['a', 'i', 'o']
twos = get_words('twos.txt')
words = get_words('words.txt')

words = filter_words(ones, twos, words)
words = remove_duplicates(words)

filename = write_out(words)

status("Done! Output words to " + filename)