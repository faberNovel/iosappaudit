module Review
    class ProjectReport
        attr_accessor :name, :version, :deployment_target, :target_names, :configuration_names, :main_target_name, :main_target_files, :main_target_resources, :ui_test_target_name, :unit_test_target_name, :ui_test_target_files, :unit_test_target_files, :localizations

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
            @localizations = []
        end

        def main_target_swift_files
            main_target_files.select { |file| file.include?(".swift") } 
        end

        def main_target_obj_c_files
            main_target_files.select { |file| file.include?(".m") } 
        end

        def has_swift_files?
            main_target_swift_files.empty?
        end

        def has_obj_c_files?
            main_target_obj_c_files.empty?
        end

        def xibs
            main_target_resources.select { |file| file.include?(".xib") }
        end

        def storyboards
            main_target_resources.select { |file| file.include?(".storyboard") }
        end
    end
end