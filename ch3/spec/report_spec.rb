require "report.rb"

describe "report" do
  before(:each) do
    @title = 'Monthly Report'
    @text =  ['Things are going', 'really, really well.']
    @tags = ["<html>", "</html>", "  <head>", "  </head>", "  <body>","  </body>"]
    @messenger = mock("messenger").as_null_object
    @report = Report.new(@messenger)
  end

  context "should output a html formatted report when passed :html argument" do
    it "should output html tags" do
      for tag in @tags
        @messenger.should_receive(:puts).with(tag)
      end
      @report.output_report(:html)
    end
    it "should have a title tag" do
      @messenger.should_receive(:puts).with("    <title>Monthly Report</title>")
      @report.output_report(:html)
    end
    it "should have the body text inside p tags" do
      for text in @text
        @messenger.should_receive(:puts).with("    <p>#{text}</p>")
      end
      @report.output_report(:html)
    end
  end
  
  context "should output plain text when passed :plain argument" do
    it "should not output any html tags" do
      for tag in @tags + ['<p>', '</p>', '<title>', '</title>']  
        @messenger.should_not_receive(:puts).with(tag) 
      end
      @report.output_report(:plain)
    end
    it "should have the title surrounded with asterisks" do
      @messenger.should_receive(:puts).with("*** #{@title} ***")
      @report.output_report(:plain)
    end 
    it "should have the body text" do
      for text in @text
        @messenger.should_receive(:puts).with(text)
      end
      @report.output_report(:plain)
    end
  end

end
