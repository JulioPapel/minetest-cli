module Minetest
  module Helpers
    class FileHelper
      require 'tempfile'
 
        def remove_lines(filename, start, num)
          tmp = Tempfile.open(filename) do |fp|
            File.foreach(filename) do |line|
              
              if $. >= start and num > 0
                num -= 1
              else
                fp.puts line
              end
            end
            fp
          end
          
          puts "Warning: EOF" if num > 0
          FileUtils.copy(tmp.path, filename)
          tmp.unlink
        end
        
        def append_lines(filename, content)
          File.open(filename, 'a') do |io|
            io.puts content
          end
        end
              
    end
  end
end