require 'test/unit'
require 'tdms'

class ReadTest < Test::Unit::TestCase
  
  # Strings
  
  def test_reads_one_string_channel_in_one_segment
    filename = fixture_filename("strings_one_segment")
    doc = Tdms::File.parse(filename)

    assert_equal 1, doc.segments.size
    assert_equal 1, doc.segments[0].objects.size
    
    chan = doc.channels.find {|ch| ch.path == "/'string_group'/'string_channel'" }
    assert_equal 10, chan.values.size
    expected = %w{zero one two three four five six seven eight nine}
    assert_equal expected, chan.values.to_a
  end

  def test_reads_two_strings_channels_in_one_segment
    filename = fixture_filename("strings_two_channels_one_segment")
    doc = Tdms::File.parse(filename)

    assert_equal 1, doc.segments.size
    assert_equal 2, doc.segments[0].objects.size

    chan = doc.channels.find {|ch| ch.path == "/'string_group'/'string_channel_a'" }
    assert_equal 10, chan.values.size
    expected = %w{a-zero a-one a-two a-three a-four a-five a-six a-seven a-eight a-nine}
    assert_equal expected, chan.values.to_a

    chan = doc.channels.find {|ch| ch.path == "/'string_group'/'string_channel_b'" }
    assert_equal 10, chan.values.size
    expected = %w{b-zero b-one b-two b-three b-four b-five b-six b-seven b-eight b-nine}
    assert_equal expected, chan.values.to_a
  end
  
  def test_reads_one_string_channel_across_two_segments
    filename = fixture_filename("strings_two_segments")
    doc = Tdms::File.parse(filename)

    assert_equal 2, doc.segments.size
    assert_equal 1, doc.segments[0].objects.size
    assert_equal 1, doc.segments[1].objects.size

    chan = doc.channels.find {|ch| ch.path == "/'string_group'/'string_channel'" }
    assert_equal 20, chan.values.size

    expected = %w{zero one two three four five six seven eight nine
                  ten eleven twelve thirteen fourteen fifteen sixteen 
                  seventeen eighteen nineteen}
    assert_equal expected, chan.values.to_a
  end
  
  private

  # Test Helpers
  
  def fixture_filename(fixture_name)
    File.dirname(__FILE__) + "/fixtures/#{fixture_name}.tdms"
  end

end
