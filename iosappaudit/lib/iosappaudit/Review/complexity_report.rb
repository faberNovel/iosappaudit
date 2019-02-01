module Review
    class FunctionMetric

        attr_accessor :file_url, :function_name, :line_number, :ncss, :ccn

        def initialize(file_url = "", function_name = "", line_number = 0, ncss = 0, ccn = 0)
            @file_url = file_url
            @function_name = function_name
            @line_number = line_number
            @ncss = ncss
            @ccn = ccn
        end
    end

    class FileMetric

        attr_accessor :file_url, :ncss, :ccn, :functions

        def initialize(file_url = "", ncss = 0, ccn = 0, functions = 0)
            @file_url = file_url
            @ncss = ncss
            @ccn = ccn
            @functions = functions
        end
    end

    class FunctionMeasure

        attr_accessor :metrics, :average_ncss, :average_ccn

        def initialize(metrics = [], average_ncss = 0, average_ccn = 0)
            @metrics = metrics
            @average_ncss = average_ncss
            @average_ccn = average_ccn
        end
    end

    class FileMeasure

        attr_accessor :metrics, :average_ncss, :average_ccn, :average_functions, :sum_ncss, :sum_ccn, :sum_functions

        def initialize(metrics = [], average_ncss = 0, average_ccn = 0, average_functions = 0, sum_ncss = 0, sum_ccn = 0, sum_functions = 0)
            @metrics = metrics
            @average_ncss = average_ncss
            @average_ccn = average_ccn
            @average_functions =  average_functions
            @sum_ncss = sum_ncss
            @sum_ccn = sum_ccn
            @sum_functions =  sum_functions
        end
    end

    class ComplexityReport

        attr_accessor :function_measure, :file_measure

        def initialize(function_measure  = [], file_measure = [])
            @function_measure = function_measure 
            @file_measure = file_measure
        end

        def files_with_more_than_count_lines(count)
            file_measure.metrics.select { |metric| metric.ncss >= count  }.map { |metric| metric.file_url } 
        end
    end
end