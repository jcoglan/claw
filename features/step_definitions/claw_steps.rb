Given /^I start the app with "([^\"]*)"$/ do |command|
  options = Claw::BIN_SPEC.parse(command.split(/\s+/))
  @io = StringIO.new
  @app = Claw::Application.new(options, @io)
  
  @commands = []
  @app.stub('`') { |cmd| @commands << cmd }
end

Given /^I enter "([^\"]*)"$/ do |command|
  @app.interpret(command)
end

Then /^I should see$/ do |string|
  @io.rewind
  @io.read.gsub(/^\n*/, '').gsub(/\n*$/, '').should == string
end

Then /^"([^\"]*)" should be open in "([^\"]*)"$/ do |file, program|
  @commands.include?("#{program} #{File.expand_path file}").should be_true
end

