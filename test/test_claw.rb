require "test/unit"
require "claw"

ASSET_DIR = File.join(File.dirname(__FILE__), 'assets')

class TestClaw < Test::Unit::TestCase
  def setup
    @app = Claw::Application.new(ASSET_DIR)
  end
  
  def test_search_by_filename
    assert_equal %w[foo.rb],          @app.find_by_name('foo')
    assert_equal %w[test_file.txt],   @app.find_by_name('testfile')
    assert_equal %w[Capfile],         @app.find_by_name('cap')
  end
end
