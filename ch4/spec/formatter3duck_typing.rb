require "spec_helper"
require "formatter3duck_typing"

class FakeIO
  attr_reader :text
  def initialize; @text = ''; end
  def puts(str); @text += str + "\n"; end
end

describe "Report formatter duck typing" do
  before(:each) do
    @messenger = mock("messenger").as_null_object
    @tags = %w(<html> </html> <head> </head> <body> </body> <title> </title> <p> </p>)
    @body = ['Things are going', 'really, really well\.']
  end
  context "HTML format" do  
    it "should have a title with tags" do
      @messenger.should_receive(:puts).with(/<title>Monthly Report<\/title>/)
      report = Report.new(HTMLFormatter.new(@messenger))
      report.output_report
    end
    it "should have all the tags" do
      output = FakeIO.new
      Report.new(HTMLFormatter.new(output)).output_report
      @tags.each do |tag|
        output.text.should =~ /#{tag}/
      end
    end
    it "should have the body wrapped in p tags" do
      output = FakeIO.new
      Report.new(HTMLFormatter.new(output)).output_report
      @body.each do |line|
        output.text.should match(/<p>#{line}<\/p>/)
      end
    end
  end
  context "Plain text format" do
    it "should not have HTML tags" do
      @tags.each do |tag|
        @messenger.should_not_receive(:puts).with(/#{tag}/)
        Report.new(PlainTextFormatter.new(@messenger)).output_report
      end
    end
    it "should have title surrounded by asterisks" do
      @messenger.should_receive(:puts).with("***** Monthly Report *****")
      Report.new(PlainTextFormatter.new(@messenger)).output_report
    end
    it "should have the body text" do
      output = FakeIO.new
      Report.new(PlainTextFormatter.new(output)).output_report
      output.text.should =~ /Things are going\nreally, really well\./
    end
  end
end