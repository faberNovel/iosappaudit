module Review
    class ProjectReviewer

        def initialize()
        end

        def review_folder(options)
            file_seeker = Helper::FileSeeker.new
            url = options.project
            project_name = options.xcodeproj&.name
            urls = []
            if !project_name
                urls = file_seeker.find_files_with_extension url, "xcodeproj"
            else
                urls = file_seeker.find_files url, project_name, "xcodeproj"
            end
            if urls.empty?
                raise "Xcode project not found"
            end
            report = ProjectReport.new
            project = Xcodeproj::Project.open urls.first
            root_object = project.root_object
            if root_object.targets.empty?
                raise "Xcode project #{root_object.name} has no target"
            end
            report.name = root_object.name
            report.version = project.object_version
            report.deployment_target = root_object.targets.map { |target| target.deployment_target }.uniq
            report.target_names = root_object.targets.map &:name
            report.configuration_names = root_object.targets.flat_map { |target| target.build_configurations.map(&:name) }.uniq
            main_target_name = options.xcodeproj&.main_target_name
            main_target = nil
            if !main_target_name
                main_target = root_object.targets[0]
            else
                main_target = root_object.targets.detect { |target| target.name == main_target_name }
                if main_target.nil?
                    raise "Xcode target named #{main_target_name} not found"
                end
            end
            ui_test_target = root_object.targets.detect { |target| target.build_configurations.any? { |config| !config.build_settings["TEST_TARGET_NAME"].nil? }  }
            unit_test_target = root_object.targets.detect { |target| target.build_configurations.any? { |config| !config.build_settings["TEST_HOST"].nil? }  }
            report.main_target_name = main_target&.name
            report.main_target_files = main_target&.source_build_phase&.files&.map { |file| file.display_name }
            report.main_target_resources = main_target&.resources_build_phase&.files&.map { |file| file.display_name }
            report.ui_test_target_name = ui_test_target&.name
            report.unit_test_target_name = unit_test_target&.name
            report.ui_test_target_files = ui_test_target&.source_build_phase&.files&.map { |file| file.display_name }
            report.unit_test_target_files = unit_test_target&.source_build_phase&.files&.map { |file| file.display_name }
            return report
        end
    end
end