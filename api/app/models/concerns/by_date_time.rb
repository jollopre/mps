require 'active_support/concern'

module ByDateTime
	extend ActiveSupport::Concern

	included do
		# Returns objects whose created_at match the datetime string formatted passed. 
		# The string formats accepted are:
		# '%Y'
		# '%Y-%m'
		# '%Y-%m-%d'
		# '%Y-%m-%d %H'
		# '%Y-%m-%d %H:%M'
		# '%Y-%m-%d %H:%M:%S'
		# Note if it returns nil (e.g. not a valid datetime string passed) an all scope is returned instead
		scope :by_created_at, -> (str_date) {
			start_date, end_date = strpdatetime(str_date)
			if start_date.present?
				where('created_at >= :start_date AND created_at <= :end_date', { start_date: start_date, end_date: end_date })
			end
		}
		# Functions similar to by_created_at but uses updated_at attribute instead
		scope :by_updated_at, -> (str_date) {
			start_date, end_date = strpdatetime(str_date)
			if start_date.present?
				where('updated_at >= :start_date AND updated_at <= :end_date', { start_date: start_date, end_date: end_date })
			end
		}
	end

	class_methods do
		# Parses a string formatted date to its DateTime objects extremes respectively, i.e. if only a year
		# string 2017 is passed, the resultant object would be two DateTime objects
		# [Mon, 01 Jan 2018 00:00:00 +0000, Mon, 31 Dec 2018 23:59:59 +0000]
		def strpdatetime(str_datetime)
			date_ranges = [
				lambda{ |str| date = DateTime.strptime(str, '%Y-%m-%d %H:%M:%S'); return date, date },
				lambda{ |str| date = DateTime.strptime(str, '%Y-%m-%d %H:%M'); return date.beginning_of_minute, date.end_of_minute },
				lambda{ |str| date = DateTime.strptime(str, '%Y-%m-%d %H'); return date.beginning_of_hour, date.end_of_hour },
				lambda{ |str| date = DateTime.strptime(str, '%Y-%m-%d'); return date.beginning_of_day, date.end_of_day },
				lambda{ |str| date = DateTime.strptime(str, '%Y-%m'); return date.beginning_of_month, date.end_of_month },
				lambda{ |str| date = DateTime.strptime(str, '%Y'); return date.beginning_of_year, date.end_of_year }
			]
			r = nil, nil
			date_ranges.each do |l|
				begin
					r = l.call(str_datetime)
					break
				rescue ArgumentError
				rescue # Any other StandardError breaks the loop immediately
					break
				end
			end
			return r
		end
	end
end
