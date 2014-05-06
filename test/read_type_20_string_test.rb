class ReadType20StringTest < Test::Unit::TestCase

  def test_reads_one_string_channel_in_one_segment
    filename = fixture_filename("type_20_string_one_segment")
    doc = Tdms::File.parse(filename)

    assert_equal 1, doc.segments.size
    assert_equal 1, doc.segments[0].objects.size
    assert_equal Tdms::DataType::Utf8String::Id, doc.segments[0].objects[0].data_type_id

    chan = doc.channels.find {|ch| ch.path == "/'string_group'/'string_channel'" }
    assert_equal 10, chan.values.size
    expected = %w{zero one two three four five six seven eight nine}
    assert_equal expected, chan.values.to_a
  end

  def test_reads_two_string_channels_in_one_segment
    filename = fixture_filename("type_20_string_two_channels_one_segment")
    doc = Tdms::File.parse(filename)

    assert_equal 1, doc.segments.size
    assert_equal 2, doc.segments[0].objects.size
    assert_equal Tdms::DataType::Utf8String::Id, doc.segments[0].objects[0].data_type_id
    assert_equal Tdms::DataType::Utf8String::Id, doc.segments[0].objects[1].data_type_id

    chan = doc.channels.find {|ch| ch.path == "/'string_group'/'string_channel_a'" }
    assert_equal 10, chan.values.size
    expected = %w{a-zero a-one a-two a-three a-four a-five a-six a-seven a-eight a-nine}
    assert_equal expected, chan.values.to_a

    chan = doc.channels.find {|ch| ch.path == "/'string_group'/'string_channel_b'" }
    assert_equal 10, chan.values.size
    expected = %w{b-zero b-one b-two b-three b-four b-five b-six b-seven b-eight b-nine}
    assert_equal expected, chan.values.to_a
  end

  def test_reads_one_string_channel_across_three_segments
    filename = fixture_filename("type_20_string_three_segments")
    doc = Tdms::File.parse(filename)

    assert_equal 3, doc.segments.size
    assert_equal 1, doc.segments[0].objects.size
    assert_equal 1, doc.segments[1].objects.size
    assert_equal 1, doc.segments[2].objects.size
    assert_equal Tdms::DataType::Utf8String::Id, doc.segments[0].objects[0].data_type_id
    assert_equal Tdms::DataType::Utf8String::Id, doc.segments[1].objects[0].data_type_id
    assert_equal Tdms::DataType::Utf8String::Id, doc.segments[2].objects[0].data_type_id

    chan = doc.channels.find {|ch| ch.path == "/'string_group'/'string_channel'" }
    assert_equal 30, chan.values.size

    expected = %w{zero one two three four five six seven eight nine
                  ten eleven twelve thirteen fourteen fifteen sixteen
                  seventeen eighteen nineteen twenty twenty-one twenty-two
                  twenty-three twenty-four twenty-five twenty-six
                  twenty-seven twenty-eight twenty-nine}
    assert_equal expected, chan.values.to_a
  end

end
