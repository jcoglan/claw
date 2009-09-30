require "test/unit"
require "lib/claw"

ASSET_DIR = File.join(File.dirname(__FILE__), 'assets')

class TestClaw < Test::Unit::TestCase
  def setup
    @search = Claw::Search.new(ASSET_DIR)
  end
  
  def test_search_by_filename
    assert_equal %w[foo.rb],          @search.by_name('foo')
    assert_equal %w[test_file.txt],   @search.by_name('testfile')
    assert_equal %w[Capfile],         @search.by_name('cap')
  end
  
  def test_search_by_contents
    assert_equal [['Capfile', 2, 'def something(one, two)'], ['foo.rb', 5, '      def something']],
                 @search.by_content('def something')
  end
end
