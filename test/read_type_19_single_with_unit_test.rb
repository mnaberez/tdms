class ReadType19SingleWithUnitTest < Test::Unit::TestCase

  def test_reads_one_single_with_unit_channel_in_one_segment
    filename = fixture_filename("type_19_single_with_unit_one_segment")
    doc = Tdms::File.parse(filename)

    assert_equal 1, doc.segments.size
    assert_equal 1, doc.segments[0].objects.size
    assert_equal Tdms::DataType::SingleWithUnit::Id, doc.segments[0].objects[0].data_type_id

    chan = doc.channels.find {|ch| ch.path == "/'single_group'/'single_channel'" }
    assert_equal 5, chan.values.size

    expected = %w[-2.02 -1.01 0.00 1.01 2.02]
    assert_equal expected, chan.values.map { |float| "%0.2f" % float }
  end

  def test_reads_two_single_with_unit_channels_in_one_segment
    filename = fixture_filename("type_19_single_with_unit_two_channels_one_segment")
    doc = Tdms::File.parse(filename)

    assert_equal 1, doc.segments.size
    assert_equal 2, doc.segments[0].objects.size
    assert_equal Tdms::DataType::SingleWithUnit::Id, doc.segments[0].objects[0].data_type_id
    assert_equal Tdms::DataType::SingleWithUnit::Id, doc.segments[0].objects[1].data_type_id

    chan = doc.channels.find {|ch| ch.path == "/'single_group'/'single_channel_a'" }
    assert_equal 5, chan.values.size
    expected = %w[-2.02 -1.01 0.00 1.01 2.02]
    assert_equal expected, chan.values.map { |float| "%0.2f" % float }

    chan = doc.channels.find {|ch| ch.path == "/'single_group'/'single_channel_b'" }
    assert_equal 5, chan.values.size
    expected = %w[2.02 1.01 0.00 -1.01 -2.02]
    assert_equal expected, chan.values.map { |float| "%0.2f" % float }
  end

  def test_reads_one_single_with_unit_channel_across_three_segments
    filename = fixture_filename("type_19_single_with_unit_three_segments")
    doc = Tdms::File.parse(filename)

    assert_equal 3, doc.segments.size
    assert_equal 1, doc.segments[0].objects.size
    assert_equal 1, doc.segments[1].objects.size
    assert_equal 1, doc.segments[2].objects.size
    assert_equal Tdms::DataType::SingleWithUnit::Id, doc.segments[0].objects[0].data_type_id
    assert_equal Tdms::DataType::SingleWithUnit::Id, doc.segments[1].objects[0].data_type_id
    assert_equal Tdms::DataType::SingleWithUnit::Id, doc.segments[2].objects[0].data_type_id

    chan = doc.channels.find {|ch| ch.path == "/'single_group'/'single_channel'" }
    assert_equal 15, chan.values.size
    expected = %w[-2.02 -1.01 0.00 1.01 2.02
                  -2.02 -1.01 0.00 1.01 2.02
                  -2.02 -1.01 0.00 1.01 2.02]
    assert_equal expected, chan.values.map { |float| "%0.2f" % float }
  end

end
