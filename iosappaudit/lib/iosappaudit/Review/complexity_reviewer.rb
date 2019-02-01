module Review
    class ComplexityReviewer

        def initialize()
        end

        def review_folder(url)
            lizard_report = "lizard-report.xml"
            `lizard --xml #{url} > #{lizard_report}`
            parser = ComplexityReportParser.new
            report = parser.parse_file lizard_report
            FileUtils.rm lizard_report
            report
        end
    end
end