include REXML

module Review
  class ComplexityReportParser

    def initialize()
    end

    def parse_file(url)
      file = File.new url
      doc = Document.new file

      function_measure = FunctionMeasure.new
      file_measure = FileMeasure.new

      function_xml = doc.root.elements["measure[@type='Function']"]
      function_measure.average_ncss = function_xml.elements["average[@label='NCSS']"]["value"].to_s.to_f
      function_measure.average_ccn = function_xml.elements["average[@label='CCN']"]["value"].to_s.to_f
      function_xml.elements.each("item") do |item|
        values = item.get_elements("value")
        item_name = item.attributes["name"]
        metric = FunctionMetric.new
        metric.file_url = /(?<=( at )).+(?=:)/.match(item_name).to_s
        metric.function_name = /.+(?=\(...\))/.match(item_name).to_s
        metric.line_number = /(?<=:)\d+/.match(item_name).to_s.to_i
        metric.ncss = values[1].text.to_i
        metric.ccn = values[2].text.to_i
        function_measure.metrics.push metric
      end

      file_xml = doc.root.elements["measure[@type='File']"]
      file_measure.average_ncss = file_xml.elements["average[@label='NCSS']"]["value"].to_s.to_f
      file_measure.average_ccn = file_xml.elements["average[@label='CCN']"]["value"].to_s.to_f
      file_measure.average_functions = file_xml.elements["average[@label='Functions']"]["value"].to_s.to_f
      file_measure.sum_ncss = file_xml.elements["sum[@label='NCSS']"]["value"].to_s.to_i
      file_measure.sum_ccn = file_xml.elements["sum[@label='CCN']"]["value"].to_s.to_i
      file_measure.sum_functions = file_xml.elements["sum[@label='Functions']"]["value"].to_s.to_i
      file_xml.elements.each("item") do |item|
        values = item.get_elements("value")
        metric = FileMetric.new
        metric.file_url = item.attributes["name"].to_s
        metric.ncss = values[1].text.to_i
        metric.ccn = values[2].text.to_i
        metric.functions = values[3].text.to_i
        file_measure.metrics.push metric
      end
      ComplexityReport.new function_measure, file_measure
    end
  end
end