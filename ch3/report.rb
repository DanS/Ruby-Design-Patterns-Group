

class Report
  def initialize(messenger)
    @messenger = messenger
    @title = 'Monthly Report'
    @text =  ['Things are going', 'really, really well.']
  end

  def output_report(format)
    
    if format == :plain
      @messenger.puts("*** #{@title} ***")
    elsif format == :html
      @messenger.puts('<html>')
      @messenger.puts('  <head>')
      @messenger.puts("    <title>#{@title}</title>")
      @messenger.puts('  </head>')
      @messenger.puts('  <body>')
    else
      raise "Unknown format: #{format}"
    end

    @text.each do |line|
      if format == :plain
        @messenger.puts(line)
      else
        @messenger.puts("    <p>#{line}</p>" )
      end
    end

    if format == :html
      @messenger.puts('  </body>')
      @messenger.puts('</html>')
    end
    @output
  end
end

