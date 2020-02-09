require 'thor'
require "highline/import"

$VERBOSE = true
$thor_runner = nil

module Minetest
  class CommandInterface < Thor
    check_unknown_options!
        
    # The Server Command
    desc "server [ start | stop | restart ] [-m --map]", "Operates the Minetest Server Service"
    long_desc <<-DESC
    The server commnad is used to control the basic operations of the minetest server.
    this commnad needs a local minetest server installed configured.
    DESC
    option :map, :aliases => '-m', type: :string, :desc => "map name Start with custom map.", :banner => " map_name"
    def server( sub_command )
      
      if ["start", "stop", "restart"].include? sub_command.downcase
        command = "systemctl service #{sub_command} minetest-server"
        command += " --config=#{options[:map]} " if (options[:map] && (sub_command.downcase != "stop"))
        puts command
      else
        help("server")
      end 
    end
    # End of Server Command
    
    # the Generate Command
    desc 'generate [ map | template ] [ map_name ] ', 'Generates a new map configuration'
    long_desc "The generate commnad is used to a create new maps / templates that can be used on the minetest server."
    option :from_map, :aliases => '-f', type: :array, :desc => "map name From existing custom map/template.", :banner => " map_name"
    def generate(sub_command, *map_name)
      
      if (["map", "template"].include? sub_command.downcase) && map_name.empty?
        if "map".include? sub_command.downcase
          
          input = ask "Provide the new map name: "
          command = "cp white_castle.template #{input.to_s.downcase.split.join('_')}.conf"
          command.gsub!("white_castle", options.from_map.join("_")) if options[:from_map]
          puts command
          
        elsif "template".include? sub_command.downcase
          
          input = ask "Provide the new map template name: "
          command = "cp white_castle.template #{input.to_s.downcase.split.join('_')}.conf"
          command.gsub!("white_castle", options.from_map.join("_")) if options[:from_map]
          command.gsub!(".conf", ".template") if ["template"].include? sub_command.downcase
          puts command
          
        end
        
      elsif (["map", "template"].include? sub_command.downcase) && !map_name.empty?
        
        command = "cp white_castle.TTT BBB.conf"
        command.gsub!("white_castle", options.from_map.join("_").downcase) if options[:from_map]
        command.gsub!("BBB", map_name.join("_").downcase) if !map_name.empty?
        command.gsub!("TTT", "conf") if ["map"].include? sub_command.downcase
        command.gsub!("TTT", "template") if ["template"].include? sub_command.downcase
        command.gsub!(".conf", ".template") if ["template"].include? sub_command.downcase
        puts command
        #puts sub_command.downcase + " " + map_name.join('_').downcase + " " + options.from_map.join('_').downcase
        
      else
        help("generate")
      end
     
    end
    # End of Generate Command
    
    # the Edit Command
    desc 'edit [ map | template ] [ map_name / template_name ] ', 'Edits your configuration map'
    long_desc " The edit commnad is used to edit the contents of a map to be used on the minetest server."
    def edit(sub_command, *map_name)
      
      if (["map", "template"].include? sub_command.downcase) && map_name.empty?
        if "map".include? sub_command.downcase
          
          input = ask "Provide the map name to edit: "
          command = "vi #{input.to_s.downcase.split.join('_')}.conf"
          puts command

        elsif "template".include? sub_command.downcase
          
          input = ask "Provide the map template name to edit: "
          command = "vi #{input.to_s.downcase.split.join('_')}.template"
          puts command

        end
        
      elsif (["map", "template"].include? sub_command.downcase) && !map_name.empty?
        
        if "map".include? sub_command.downcase
          
          command = "vi #{map_name.join('_').downcase}.conf"
          puts command

        elsif "template".include? sub_command.downcase
          
          command = "vi #{map_name.join('_').downcase}.template"
          puts command

        end
        
      else
        help("edit")
      end
     
    end
    # End of edit Command
    
    # the Backup Command
    desc 'backup [ list | create ] [ restore ] ', 'Manipulates backups of map configurations'
    long_desc "The backup commnad is used to backup and restore maps / templates that can be used on the minetest server."
    option :levels, :aliases => '-l', type: :numeric, :desc => "Number of backups to keep.", :banner => " map_name"
    def backup(sub_command, *map_name)
      
      if (["list", "create", "restore"].include? sub_command.downcase)
        
        backup_directory_name = "./backup-files"
        conf_directory_name = "./custom-maps"
        backup_list = []
        
        if "list".include? sub_command.downcase
          
          Dir.mkdir(backup_directory_name) unless File.exist?(backup_directory_name)
          existing_files = Dir.glob("#{backup_directory_name}/*.backup")

          if !existing_files.empty?
            existing_files.each do |file|
              backup_list << File.basename(file, '.backup')
            end
              
            backup_list.each do |e|
              e = e.split("-")
              puts "      -[#{e[0]}] : backup Level N.#{e[1]}"
            end
            
          else
            puts "No backups found in " + backup_directory_name
          end
          
        elsif "create".include? sub_command.downcase
          
          Dir.mkdir(conf_directory_name) unless File.exist?(conf_directory_name)
          existing_files = Dir.glob("#{conf_directory_name}/*.conf")

          if !existing_files.empty?
            existing_files.each do |file|
              backup_list << File.basename(file, '.conf')
            end
            
            puts "Available maps for backup:"
            n = 0
            backup_list.each do |e|
              n += 1
              puts "   [#{n}]-> #{e}"
            end
            pick = ask "Select the map number you want to backup:"
            pick = pick.chomp.to_i 
            
            if pick <= n && !pick.nil? && !pick.zero?
              puts "cp #{conf_directory_name}/#{backup_list[pick - 1]}.conf #{backup_directory_name}/#{backup_list[pick - 1]}.template"
            else
              puts "Operation aborted. The user did not select a proper number."
            end
          else
            puts "No Maps where found in " + conf_directory_name
          end
        
        elsif "restore".include? sub_command.downcase
          
          puts "for you to implement, and do not forget the backup levels option ..."
          
        end
        
      else
        help("backup")
      end
     
    end
    # End of Backup Command
    
    # the remove Command
    desc 'remove', 'Deletes an existing map configurations'
    long_desc "The remove commnad is used to remove maps & backups used on the minetest server."
    def remove
      
      backup_directory_name = "./backup-files"
      conf_directory_name = "./custom-maps"
      files_list = []
      
      begin
        
        Dir.mkdir(conf_directory_name) unless File.exist?(conf_directory_name)
        Dir.mkdir(conf_directory_name) unless File.exist?(backup_directory_name)
        
        existing_files = (Dir.glob("#{conf_directory_name}/*.conf"))
        existing_files += (Dir.glob("#{conf_directory_name}/*.template"))
        existing_files += (Dir.glob("#{backup_directory_name}/*.backup"))
        
        if !existing_files.empty?
          existing_files.each do |file|
            files_list << File.basename(file)
          end
          
          puts "Available files to remove:"
          n = 0
          files_list.each do |e|
            n += 1
            puts "   [#{n}]-> #{e}"
          end
          pick = ask "Select the file number you want to remove:"
          pick = pick.chomp.to_i 
          
          if pick <= n && !pick.nil? && !pick.zero?
            confirmed = ask "are you sure? [Y/N]"
            confirmed = confirmed[0].chomp.downcase
            
            if confirmed == "y"
              puts "rm #{existing_files[pick - 1]}"
            end
            
          else
            puts "Operation aborted. The user did not select a proper number."
          end
        else
          puts "No Maps or backups where found. Plase check your paths."
        end
        
      rescue
        help("remove")
      end
     
    end
    # End of Remove Command
    
    private
    
    def self.exit_on_failure?
      ci = CommandInterface.new
      ci.help
    end
    
  end
end