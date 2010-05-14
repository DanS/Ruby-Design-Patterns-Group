class Report4
  attr_reader :title, :text
  attr_accessor :formatter

  def initialize(messenger, &formatter)
    @title = 'Monthly Report'
    @text =  [ 'Things are going', 'really, really well.' ]
    @formatter = formatter
    @messenger = messenger
  end

  def output_report
    @formatter.call(@messenger, self )
  end
end


HTMLFormatterProc  = lambda do |@messenger, context|
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

PlainTextFormatterProc = lambda do |@messenger, context|
  @messenger.puts("***** #{context.title} *****")
  context.text.each do |line|
    @messenger.puts(line)
  end
end

