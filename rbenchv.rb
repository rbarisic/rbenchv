# Ruby Versioning Benchmark

@file = File.new("./rbench/bench_#{RUBY_ENGINE}_v#{RUBY_VERSION}.result","w")
@file_html = File.new("./rbench/bench_#{RUBY_ENGINE}_v#{RUBY_VERSION}.result.html","w") if ARGV.include?('--html')

def putf(string)
	@file.write(string + "\n")
	puts string
end

def putb(string) # put console + text + html
	putf(string)
	puth(string)
	puts string
end

def puth(string)
	if ARGV.include?('--html')
		@file_html.write(string)
	else
		putb(string)
	end
end

def benchmark(description, &block)
	putf '####################################################'
	putf '# ' + "#{description} Benchmark:"
	putf '####################################################'
	puth "<div class='benchmark'>"
	puth "<h2>#{description} Benchmark:</h2>"
	total_time = 0
	10.times do |i|
		puth "<div class='iteration'>"
		putb "  Iteration No. #{i+1} <br />"
		a = Time.now
		yield
		b = Time.now - a
		total_time += b
		putb "  Time taken: <b>#{b * 1000}ms</b>."
		putf "  --------------------------------------------------"
		puth "</div>"
	end
	putf "===================================================="
	puth "Total Time for this Benchmark: #{total_time} seconds."
	puth "</div>"
end

# The Benchmark starts here:

# Set Stylesheet
File.open('./bench.css','r') do |file|
	puth file.read
end
puth "<div id='header'></div>"
@header_text = "<h1>Ruby Implementation Benchmark - #{RUBY_ENGINE} #{RUBY_VERSION}</h1>"

@a = Time.now

benchmark "Put 10'000 times" do
	10000.times do |i|
		puts "hello"
	end
end

benchmark "1'000'000 Random Numbers between 0..1000000" do
	1000000.times do
		randiman = rand(0..100000)
		randiman = 0
	end
end

@b = Time.now - @a

puth "<script>window.addEventListener(\"load\",function() { document.getElementById('header').innerHTML = \"<h1>#{@header_text}<h2>TOTAL BENCHMARK TIME: #{@b}s</h2>\";},false);</script>"

puth "<div id='machine-info'>"
puth "TOTAL BENCHMARK TIME: #{@b} seconds."
puth "<br />"
putb "\n\n"
puth "Ruby Implementation: '#{RUBY_ENGINE}', version: #{RUBY_VERSION}"
puth "<br />"
puth "Info: #{RUBY_DESCRIPTION}"
puth "<br />"
puth "Machine: #{RUBY_PLATFORM}"
puth "</div>"
@file.close
@file_html.close if ARGV.include?('--html')

# The Benchmark has ended by here.