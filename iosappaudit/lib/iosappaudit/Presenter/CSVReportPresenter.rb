include R18n::Helpers

module Presenter
    class CSVReportPresenter

        def initialize(options, project_report, complexity_report)
            @project_report = project_report
            @complexity_report = complexity_report
            @options = options
            root = File.expand_path '../../..', File.dirname(__FILE__)
            R18n.default_places = "#{root}/i18n/"
            R18n.set('en')
        end

        def generate_review
            puts "Generating csv review..."
            url = @options[:csv_output]
            CSV.open(url, "wb") do |csv|
                # Project
                csv << section(t.section.project.title)
                csv << value_row(t.section.project.row.name, @project_report.name)
                csv << value_row(t.section.project.row.version, @project_report.version)
                csv << value_row(t.section.project.row.deployment_target, @project_report.deployment_target.first)
                # Settings
                csv << section(t.section.settings.title)
                csv << array_row(t.section.settings.row.targets, @project_report.target_names)
                csv << array_row(t.section.settings.row.configurations, @project_report.configuration_names)
                # Complexity
                csv << section(t.section.complexity.title)
                csv << array_row(t.section.complexity.row.file_count, @project_report.main_target_files)
                csv << array_row(t.section.complexity.row.swift_file_count, @project_report.main_target_swift_files)
                csv << array_row(t.section.complexity.row.obj_c_file_count, @project_report.main_target_obj_c_files)
                csv << value_row(t.section.complexity.row.code_line_count, @complexity_report.file_measure.sum_ncss)
                file_line_count_threshold = @options[:complexity][:file_line_count_threshold]
                metrics_ncss = @complexity_report.file_metrics_with_more_than_count_lines @options[:complexity][:file_line_count_threshold]
                csv << array_row(t.section.complexity.row.file_count_threshold(file_line_count_threshold), format_ncss(metrics_ncss))
                metrics_ccn = @complexity_report.file_metrics_sorted_by_ccn
                csv << value_row(t.section.complexity.row.ccn_line_count, @complexity_report.file_measure.sum_ccn, format_ccn(metrics_ccn))
                # Resources
                csv << section(t.section.resources.title)
                csv << array_row(t.section.resources.row.xib_count, @project_report.xibs)
                csv << array_row(t.section.resources.row.storyboards, @project_report.storyboards)
                # Tests
                csv << section(t.section.tests.title)
                csv << array_row(t.section.tests.row.unit_tests, @project_report.unit_test_target_files)
                csv << array_row(t.section.tests.row.ui_tests, @project_report.ui_test_target_files)
            end
            puts "Report #{url} created 🎉".colorize(:green)
        end

        def section(title)
            return [title]
        end

        def value_row(title, value, detail=[])
            if value.nil?
                return format_row [title, detail]
            end
            format_row [title, value, format_array(detail)]
        end

        def array_row(title, array)
            if array.nil?
                return [title, 0]
            end
            return format_row [title, array.count, format_array(array)]
        end

        def format_row(array)
            if @options[:output_format][:adds_row_padding]
                array.unshift("")
            end
            array
        end

        def format_array(array)
            size = @options[:output_format][:size]
            output = array.first(size).join("\n")
            if array.count > size
                output += "\n..."
            end
            output
        end

        def format_ncss(metrics)
            metrics.map { |metric| "(#{metric.ncss}) #{metric.file_url}" }
        end

        def format_ccn(metrics)
            metrics.map { |metric| "(#{metric.ccn}) #{metric.file_url}" }
        end
    end
end