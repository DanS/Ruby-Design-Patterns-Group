
class Report3
  attr_reader :title, :text
  attr_accessor :formatter

  def initialize(formatter)
    @title = 'Monthly Report'
    @text =  [ 'Things are going', 'really, really well.' ]
    @formatter = formatter
  end

  def output_report
    @formatter.output_report( self )
  end
end


class HTMLFormatter3
  def initialize(messenger)
    @messenger = messenger
  end
  def output_report( context )
    @messenger.puts('<html>')
    @messenger.puts('  <head>')
    @messenger.puts("    <title>#{context.title}</title>")
    @messenger.puts('  </head>')
    @messenger.puts('  <body>')
    context.text.each do |line|
      @messenger.puts("    <p>#{line}</p>" )
    end
    @messenger.puts('  </body>')
    @messenger.puts('</html>')
  end
end

class PlainTextFormatter3
  def initialize(messenger)
    @messenger = messenger
  end
  def output_report( context)
    @messenger.puts("***** #{context.title} *****")
    context.text.each do |line|
      @messenger.puts(line)
    end
  end
end

