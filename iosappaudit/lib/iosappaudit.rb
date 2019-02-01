require 'optparse'
require 'byebug'
require 'xcodeproj'
require 'rexml/document'
require 'r18n-core'
require 'CSV'
require 'yaml'

require_relative "iosappaudit/Review/complexity_report.rb"
require_relative "iosappaudit/Review/complexity_report_parser.rb"
require_relative "iosappaudit/Review/complexity_reviewer.rb"
require_relative "iosappaudit/Review/project_report.rb"
require_relative "iosappaudit/Review/project_reviewer.rb"
require_relative "iosappaudit/Helper/file_seeker.rb"
require_relative "iosappaudit/Presenter/CSVReportPresenter.rb"

options = {}
OptionParser.new do |parser|
    parser.on("-o", "--option=URL") do |url|
        options[:url] = url
    end
end.parse!

properties = YAML.load_file(options[:url])

project_reviewer = Review::ProjectReviewer.new
project_report = project_reviewer.review_folder properties

complexity_reviewer = Review::ComplexityReviewer.new
complexity_report = complexity_reviewer.review_folder properties

csv_url = "report.csv"
presenter = Presenter::CSVReportPresenter.new(project_report, complexity_report)
presenter.generate_review csv_url
