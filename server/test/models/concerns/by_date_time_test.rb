require 'test_helper'

class ByDateTest < ActiveSupport::TestCase
	setup do
		@by_date_time = Quotation	# Concern methods are included in the Quotation model so far
	end

	test 'strpdatetime raises ArgumentError for wrong number of arguments' do
		assert_raises(ArgumentError) do
			@by_date_time.strpdatetime
		end
	end
	test 'strpdatetime returns [nil, nil] when argument passed is blank' do
		assert_equal([nil, nil], @by_date_time.strpdatetime(nil))
		assert_equal([nil, nil], @by_date_time.strpdatetime(''))
		assert_equal([nil, nil], @by_date_time.strpdatetime(' '))
		assert_equal([nil, nil], @by_date_time.strpdatetime(false))
		assert_equal([nil, nil], @by_date_time.strpdatetime([]))
		assert_equal([nil, nil], @by_date_time.strpdatetime({}))
	end
	test 'strpdatetime returns [nil, nil] when argument passed is present but NOT a parseable string' do
		assert_equal([nil, nil], @by_date_time.strpdatetime('foo'))
		assert_equal([nil, nil], @by_date_time.strpdatetime(['foo']))
		assert_equal([nil, nil], @by_date_time.strpdatetime({ foo: 'bar' }))
		assert_equal([nil, nil], @by_date_time.strpdatetime(0))
	end
	test 'strpdatetime returns beginning of year and end of year' do
		boy = DateTime.new(2018).beginning_of_year
		eoy = DateTime.new(2018).end_of_year
		assert_equal([boy, eoy], @by_date_time.strpdatetime('2018'))
		assert_equal([boy, eoy], @by_date_time.strpdatetime('2018foo'))
	end
	test 'strpdatetime returns beginning of month and end of month' do
		bom = DateTime.new(2018,02).beginning_of_month
		eom = DateTime.new(2018,02).end_of_month
		assert_equal([bom, eom], @by_date_time.strpdatetime('2018-2'))
		assert_equal([bom, eom], @by_date_time.strpdatetime('2018-02'))
		assert_equal([bom, eom], @by_date_time.strpdatetime('2018-02foo'))
	end
	test 'strpdatetime returns beginning of day and end of day' do
		bod = DateTime.new(2018,02,21).beginning_of_day
		eod = DateTime.new(2018,02,21).end_of_day
		assert_equal([bod, eod], @by_date_time.strpdatetime('2018-2-21'))
		assert_equal([bod, eod], @by_date_time.strpdatetime('2018-02-21'))
		assert_equal([bod, eod], @by_date_time.strpdatetime('2018-02-21foo'))
	end
	test 'strpdatetime returns beginning of hour and end of hour' do
		boh = DateTime.new(2018,02,21,21).beginning_of_hour
		eoh = DateTime.new(2018,02,21,21).end_of_hour
		assert_equal([boh, eoh], @by_date_time.strpdatetime('2018-2-21 21'))
		assert_equal([boh, eoh], @by_date_time.strpdatetime('2018-02-21 21'))
		assert_equal([boh, eoh], @by_date_time.strpdatetime('2018-02-21 21foo'))
	end
	test 'strpdatetime returns beginning of minute and end of minute' do
		bom = DateTime.new(2018,02,21,21,23).beginning_of_minute
		eom = DateTime.new(2018,02,21,21,23).end_of_minute
		assert_equal([bom, eom], @by_date_time.strpdatetime('2018-2-21 21:23'))
		assert_equal([bom, eom], @by_date_time.strpdatetime('2018-02-21 21:23'))
		assert_equal([bom, eom], @by_date_time.strpdatetime('2018-02-21 21:23foo'))
	end
	test 'strpdatetime returns two equal DateTime objects when date and time formatted string is passed' do
		expected = DateTime.new(2018,02,21,21,27,10)
		assert_equal([expected, expected], @by_date_time.strpdatetime('2018-02-21 21:27:10'))
		assert_equal([expected, expected], @by_date_time.strpdatetime('2018-02-21 21:27:10foo'))
	end
end