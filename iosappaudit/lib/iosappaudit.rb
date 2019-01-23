require 'optparse'
require_relative "iosappaudit/complexity_report_parser.rb"

options = {}
OptionParser.new do |parser|
    parser.on("-u", "--url=URL") do |url|
        options[:url] = url
    end
end.parse!

complexity_parser = ComplexityReportParser.new

complexity_report = complexity_parser.parse_file options[:url]
