require 'optparse'

class LSCommand
	def initialize
		opt = OptionParser.new
		params = {}
		opt.on('-a') {|v| params[:a] = v }
		opt.on('-r') {|v| params[:r] = v }
		opt.on('-l') {|v| params[:l] = v }
		opt.parse!(ARGV)
		#puts ARGV.class
		#puts ARGV[0].class
		#puts ARGV[1].class

		@path = ARGV[0] ? ARGV[0] : Dir.pwd
		#puts @path
	end

	def datein 
		@name = {}
		@max_size = 0

		Dir.chdir(@path) do
			Dir.glob(@path + "/*" ).each do |n|
				filename = n.gsub(/.+\/([^\/]+$)/){ $1 }
				@max_size = filename.size if @max_size < filename.size
				@name[:"#{filename}"] = File.stat(filename)	
			end
		end
	end

	def row_line
		case @max_size
		when (35..)
			row = 1
		when (24..34)
			row = 2
		else
			row = 3
		end

		@line = @name.size / row 
		@line += 1 if @name.size % row > 0
	end

	def output
		@line.times do |time|
			@name.select.with_index{|(k, v), i| i % @line == time }.keys.each{|k| print "%-23s" % k}
			print "\n"
			time += 1
		end
	end

end

ls = LSCommand.new
#puts ls.class
ls.datein
#puts ls.class
ls.row_line
ls.output
