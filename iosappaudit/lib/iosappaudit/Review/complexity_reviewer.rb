module Review
    class ComplexityReviewer

        def initialize()
        end

        def review_folder(options)
            lizard_report = "lizard-report.xml"
            source = options[:sources_url]
            `lizard -m --xml #{source} > #{lizard_report}`
            parser = ComplexityReportParser.new
            report = parser.parse_file lizard_report
            FileUtils.rm lizard_report
            report
        end
    end
end