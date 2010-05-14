require "spec_helper"
require "formatter4procs"

class FakeIO
  attr_reader :text
  def initialize; @text = ''; end
  def puts(str); @text += str + "\n"; end
end

describe "Report formatter procs as strategies" do
  before(:each) do
    @tags = %w(<html> </html> <head> </head> <body> </body> <title> </title> <p> </p>)
    @body = ['Things are going', 'really, really well\.']
    @messenger = FakeIO.new
  end
  context "HTML format" do  
    it "should have a title with tags" do
      report = Report4.new(@messenger, &HTMLFormatterProc)
      report.output_report
      @messenger.text.should =~ /<title>Monthly Report<\/title>/
    end
    it "should have all the tags" do
      Report4.new(@messenger, &HTMLFormatterProc).output_report
      @tags.each do |tag|
        @messenger.text.should =~ /#{tag}/
      end
    end
    it "should have the body wrapped in p tags" do
      Report4.new(@messenger, &HTMLFormatterProc).output_report
      @body.each do |line|
        @messenger.text.should match(/<p>#{line}<\/p>/)
      end
    end
  end
  context "Plain text format" do
    it "should not have HTML tags" do
      Report4.new(@messenger, &PlainTextFormatterProc).output_report
      @tags.each do |tag|
        @messenger.text.should_not =~ /#{tag}/
      end
    end
    it "should have title surrounded by asterisks" do
      Report4.new(@messenger, &PlainTextFormatterProc).output_report
      @messenger.text.should =~ /\*\*\*\*\* Monthly Report \*\*\*\*\*/
    end
    it "should have the body text" do
      Report4.new(@messenger, &PlainTextFormatterProc).output_report
      @messenger.text.should =~ /Things are going\nreally, really well\./
    end
  end
end