
require_relative 'complexity_report.rb'
require 'rexml/document'
include REXML

class ComplexityReportParser

    def initialize()
    end

    def parse_file(url)
        file = File.new url
        doc = Document.new file

        function_measure = FunctionMeasure.new
        file_measure = FileMeasure.new

        function_xml = doc.root.elements["measure[@type='Function']"]
        function_measure.average_ncss = function_xml.elements["average[@label=NCSS]"]
        function_measure.average_ccn = function_xml.elements["average[@label=CCN]"]
        function_xml.elements.each("item") do |item|
            values = item.get_elements("value")
            item_name = item.attributes["name"]
            metric = FunctionMetric.new
            metric.file_url = /(?<=( at )).+(?=:)/.match item_name
            metric.function_name = /.+(?=\(...\))/.match item_name
            metric.line_number = /(?<=:)\d+/.match item_name
            metric.ncss = values[1]
            metric.ccn = values[2]
            function_measure.metrics.push metric
        end

        file_xml = doc.root.elements["measure[@type='File']"]
        file_measure.average_ncss = function_xml.elements["average[@label=NCSS]"]
        file_measure.average_ccn = function_xml.elements["average[@label=CCN]"]
        file_measure.average_functions = function_xml.elements["average[@label=Functions]"]
        file_measure.sum_ncss = function_xml.elements["sum[@label=NCSS]"]
        file_measure.sum_ccn = function_xml.elements["sum[@label=CCN]"]
        file_measure.sum_functions = function_xml.elements["sum[@label=Functions]"]
        file_xml.elements.each("item") do |item|
            values = item.get_elements("value")
            metric = FileMetric.new
            metric.file_url = item.attributes["name"]
            metric.ncss = values[1]
            metric.ccn = values[2]
            metric.functions = values[3]
            function_measure.metrics.push metric
        end
        return ComplexityReport.new function_measure, file_measure
    end
end
