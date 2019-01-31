require 'optparse'
require 'byebug'
require 'xcodeproj'
require 'rexml/document'

require_relative "iosappaudit/Review/complexity_report.rb"
require_relative "iosappaudit/Review/complexity_report_parser.rb"
require_relative "iosappaudit/Review/complexity_reviewer.rb"
require_relative "iosappaudit/Review/project_report.rb"
require_relative "iosappaudit/Review/project_reviewer.rb"
require_relative "iosappaudit/Helper/file_seeker.rb"

options = {}
OptionParser.new do |parser|
    parser.on("-u", "--url=URL") do |url|
        options[:url] = url
    end
end.parse!

project_reviewer = Review::ProjectReviewer.new
project_report = project_reviewer.review_folder options[:url]

complexity_reviewer = Review::ComplexityReviewer.new
complexity_report = complexity_reviewer.review_folder options[:url]
