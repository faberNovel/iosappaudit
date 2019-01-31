module Helper
    class FileSeeker

        def initialize()
        end

        def find_files_with_extension(url, extension)
            Dir.glob("#{url}/**/*.#{extension}")
        end

        def find_file_names_with_extension(url, extension)
            find_files_with_extension(url, extension).map { |url| File.basename(url) }
        end
    end
end