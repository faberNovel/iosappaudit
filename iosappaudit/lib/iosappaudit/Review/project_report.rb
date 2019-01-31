module Review
    class ProjectReport
        attr_accessor :name, :version, :deployment_target, :target_names, :configuration_names, :main_target_name, :main_target_files, :main_target_resources, :ui_test_target_name, :unit_test_target_name, :ui_test_target_files, :unit_test_target_files

        def initialize
            @name = ""
            @version = ""
            @deployment_target = ""
            @target_names = ""
            @configuration_names = ""
            @main_target_name = ""
            @main_target_files = []
            @main_target_resources = []
            @ui_test_target_name = ""
            @unit_test_targe_name = ""
            @ui_test_target_files = []
            @unit_test_target_files = []
        end

        def has_swift_files?
            main_target_files.any? { |file| file.include?(".swift") }
        end

        def has_obj_c_files?
            main_target_files.any? { |file| file.include?(".h") }
        end

        def xibs
            main_target_resources.select { |file| file.include?(".xib") }
        end

        def storyboards
            main_target_resources.select { |file| file.include?(".storyboard") }
        end
    end
end