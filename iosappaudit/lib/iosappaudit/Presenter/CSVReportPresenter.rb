include R18n::Helpers

module Presenter
    class CSVReportPresenter

        def initialize(project_report, complexity_report)
            @project_report = project_report
            @complexity_report = complexity_report
            root = File.expand_path '../../..', File.dirname(__FILE__)
            R18n.default_places = "#{root}/i18n/"
            R18n.set('en')
        end

        def generate_review(options)
            url = options.csv_output.nil? ? "report.csv" : options.csv_output
            CSV.open(url, "wb") do |csv|
                # Project
                csv << section(t.section.project.title)
                csv << valueRow(t.section.project.row.name, @project_report.name)
                csv << valueRow(t.section.project.row.version, @project_report.version)
                csv << valueRow(t.section.project.row.deployment_target, @project_report.deployment_target.first)
                # Settings
                csv << section(t.section.settings.title)
                csv << arrayRow(t.section.settings.row.targets, @project_report.target_names)
                csv << arrayRow(t.section.settings.row.configurations, @project_report.configuration_names)
                # Complexity
                csv << section(t.section.complexity.title)
                csv << arrayRow(t.section.complexity.row.file_count, @project_report.main_target_files, false)
                csv << arrayRow(t.section.complexity.row.swift_file_count, @project_report.main_target_swift_files, false)
                csv << arrayRow(t.section.complexity.row.obj_c_file_count, @project_report.main_target_obj_c_files, false)
                csv << valueRow(t.section.complexity.row.code_line_count, @complexity_report.file_measure.sum_ncss)
                csv << valueRow(t.section.complexity.row.comment_line_count, @complexity_report.file_measure.sum_ccn)
                file_line_count_threshold = options.complexity&.file_line_count_threshold
                if !file_line_count_threshold.nil?
                    files = @complexity_report.files_with_more_than_count_lines file_line_count_threshold
                    csv << arrayRow(t.section.complexity.row.file_count_threshold(file_line_count_threshold), files, false)
                end
                # Resources
                csv << section(t.section.resources.title)
                csv << arrayRow(t.section.resources.row.xib_count, @project_report.xibs, false)
                csv << arrayRow(t.section.resources.row.storyboards, @project_report.storyboards)
                # Tests
                csv << section(t.section.tests.title)
                csv << arrayRow(t.section.tests.row.unit_tests, @project_report.unit_test_target_files)
                csv << arrayRow(t.section.tests.row.ui_tests, @project_report.ui_test_target_files)
            end
        end

        def valueRow(title, value)
            if value.nil?
                return [title]
            end
            [title, value]
        end

        def arrayRow(title, array, verbose=true)
            if array.nil?
                return [title, 0]
            end
            if verbose
                return [title, array.count, array]
            else
                [title, array.count]    
            end
        end

        def section(title)
            return [title]
        end
    end
end