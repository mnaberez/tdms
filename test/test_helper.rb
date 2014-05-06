require 'test/unit'

class Test::Unit::TestCase

  def fixture_filename(fixture_name)
    File.dirname(__FILE__) + "/fixtures/#{fixture_name}.tdms"
  end

end