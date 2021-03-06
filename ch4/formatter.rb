class Formatter
  def initialize(messenger)
    @messenger = messenger
  end
  def output_report( title, text )
    raise 'Abstract method called'
  end
end

class HTMLFormatter < Formatter
  def output_report( title, text )
    @messenger.puts('<html>')
    @messenger.puts('  <head>')
    @messenger.puts("    <title>#{title}</title>")
    @messenger.puts('  </head>')
    @messenger.puts('  <body>')
    text.each do |line|
      @messenger.puts("    <p>#{line}</p>" )
    end
    @messenger.puts('  </body>')
    @messenger.puts('</html>')
  end
end

class PlainTextFormatter < Formatter
  def output_report(title, text)
    @messenger.puts("***** #{title} *****")
    text.each do |line|
      @messenger.puts(line)
    end
  end
end

class Report
  attr_reader :title, :text
  attr_accessor :formatter
  def initialize(formatter)
    @title = 'Monthly Report'
    @text =  [ 'Things are going', 'really, really well.' ]
    @formatter = formatter
  end
  def output_report
    @formatter.output_report( @title, @text )
  end
end
