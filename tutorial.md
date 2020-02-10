<img src="https://images.unsplash.com/photo-1504805572947-34fad45aed93?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=350&q=80" align="center"/>

# Criação de de uma Applicação de Linha de Comandos com Ruby
por: Júlio Papel


O interesse deste tutorial é promover a apredizagem, a curiosidade e o raciocínio lógico ao criar uma aplicaçao de linha de comandos CLI ("Command Line Interface"). Este tutorial baseia-se em uma ideia do meu grande amigo Paulo Pinhal em criar uma aplicaçao para gerir o servidor minetest nas escolas. Este tutorial não implementa as fucionalidades para gerir o servidor minetest, contudo demonstra o processo lógico e estrutura para que possas tu criar o teu proprio CLI, quer seja do minetest ou outro.
Ainda em esta applicação de Ruby os comando a executar são representados com o metodo ``` puts ``` e apenas imprimem no terminal a composição e estrutura de um possivél comando, verbo ou opção.

_Nome_: minetest-cli

_comandos a executar_:

```
$ minetest-cli server [ start | stop | restart ] [ [-m --map] with_map_name ]
$ minetest-cli generate [ map | template ] [ map_name ] [ [-f --from] from_map_name ]
$ minetest-cli edit [ map | template ] [ map_name / map_template_name ]
$ minetest-cli backup [list | create | restore ] [map_name] [-L back_number_levels]
$ minetest-cli remove 
$ minetest-cli help
```

## 1- Criar o esqueleto para minetest-cli
 
Começamos por criar um directório para a nossa applicação. 

```
$ mkdir minetest-cli
```

No meu caso uso o TextMate -> `mate` como editor de código, podes usar outro editor como `Atom`, `VIM`, `VS Code`, ...

```
$ mate minetest-cli
```

Agora como tenho intalado o gestor de versões de ruby `RVM` (Podia também ser `RBEnv`) injectamos em um novo ficheiro a versão do ruby que esta actualmente activa.

```
$ echo $RUBY_VERSION > minetest-cli/.ruby-version
```

E criamos o esqueleto GEM no Bundler.

```
$ bundle gem minetest-cli
```

E mudamos para o directório da aplicação. Todos os comandos descritos são executados em este directório salvo explicitamente indicado.

Agora é uma boa altura para criar o repositório no GitHub. Este exemplo pode ser encontrado já criado em:
  https://github.com/JulioPapel/minetest-cli.git

1.  No canto superior direito em qualquer página, usa o <svg version="1.1" width="12" height="16" viewBox="0 0 12 16" class="octicon octicon-plus" aria-hidden="true"><path fill-rule="evenodd" d="M12 9H7v5H5V9H0V7h5V2h2v5h5v2z"></path></svg> do menu drop-down e sececciona **New repository**. 

    ![Drop-down with option to create a new repository](https://github.com/JulioPapel/minetest-cli/blob/master/docs/img/github0.png)

2.  Digite um nome pequeno, fácil de memorizar para o repositório. por exemplo, "minetest-cli". 

    ![Campo para inserir um nome de repositório](https://github.com/JulioPapel/minetest-cli/blob/master/docs/img/github1.png)

3.  Escolhe se o repositório é publico ou privado. Repositórios privados requerem uma subscrição no Github.Para obter mais informações, consulta "[Configurar visibilidade do repositório](https://help.github.com/pt/articles/setting-repository-visibility)". 

    ![Botões de opção para selecionar status privado ou público](https://github.com/JulioPapel/minetest-cli/blob/master/docs/img/github2.png)

5.  Não selecione **Initialize this repository with a README** (Inicializar este repositório com um LEIAME). 

    ![Caixa de seleção para criar um LEIAME quando o repositório é criado](https://github.com/JulioPapel/minetest-cli/blob/master/docs/img/github3.png)

6.  Clique em **Create Repository** (Criar repositório).

7.  Copia o endereço do teu repositório.
    
    ![Copiar o endereço do repositório ](https://github.com/JulioPapel/minetest-cli/blob/master/docs/img/github4.png)
    
    e no terminal usando o teu repositório executa: 


```
$ cd minetest-cli
$ git status
$ git add .
$ git commit -am "Initial commit"
$ git tag -a v0.1 -m "beta version 0.1"
$ git remote add origin https://github.com/JulioPapel/minetest-cli.git
```

## 2- Alterar os TODO's na gemspec
 
No editor de código (no meu caso o TextMate mas pode ser o VIM, Microsoft Code, ou outro) abrir a pasta do projecto:
(ex. "vi .", "code .", "textedit .", ... )

```
$ mate .
```

alterar todos os valores onde aparece "TODO" no ficheiro ```minetest-cli.gemspec```

```ruby
...
  spec.summary       = "A Minetest Server Custom tool"
  spec.description   = "Minetest Server CLI tool to manage the Server, worlds maps, etc.."
  spec.homepage      = "http://mywebsite.com/minetest-cli" # website da tua applicação
...
  spec.metadata["allowed_push_host"] = "http://rubygems.org" # Servidor para publicar a gem.
...
  spec.metadata["source_code_uri"] = "https://github.com/JulioPapel/minetest-cli"
  spec.metadata["changelog_uri"] = "https://github.com/JulioPapel/minetest-cli/CHANGELOG.md"
```


Atenção ao servidor onde publicam as gems, Se usares o http://rubygems.org a tua aplicação sera compilada em uma gem e fica publica, livre e accessivéel por todas as pessoas e computadores. Podes optar por publicar em outro servidor ou usar um servidor privado.

Adicionar e enviar as alterações para o repositório github:

```
$ git status
$ git commit -am "Initial gem Skeleton"
$ git push -u origin master
$ git push --tags
```

## 3- Preparar o CHANGELOG
Adicionar uma nova gem "Github_Changelog_Generator". Esta libraria detecta as versões e os commits no github e adiciona as no ficheiro CHANGELOG.md

Adicionar no final do ficheiro ```minetest-cli.gemspec``` a depdencia no gemspec
```ruby
...
  spec.add_development_dependency "github_changelog_generator"
end
```

```
$ bundle install
ou
$ gem install github_changelog_generator

$ github_changelog_generator --user JulioPapel --project minetest-cli
$ git add .
$ git commit -m "auto updated changelog"
$ git push
```

Alterar o ficheiro ```Rakefile``` para requerer 'github_changelog_generator/task' e criar uma tarefa
   "Rake task" apenas para facilitar a utilização do "github_changelog_generator" no ambiente de desenvolvimento.

```ruby
require "bundler/gem_tasks"
require 'github_changelog_generator/task'
task :default => :spec

GitHubChangelogGenerator::RakeTask.new :changelog_gen do |config|
    config.user = 'JulioPapel'
    config.project = 'minetest-cli'
    # config.token = "YOUR GITHUB TOKEN"
    config.future_release = 'v1.0'
    config.release_branch = "master"
    config.date_format = "%d-%m-%Y"
    config.header = "# Minetest Changes Log."
    config.simple_list = true
  
end
``` 


O token pode ser omitido em este caso já que o repositório não é privado.

Continuando no ficheiro ```Rakefile``` Vamos modificar a tarefa predefinida do changelog escondendo a tarefa da lista de tarefas ```Rake -T``` para isso adicionamos depois da tarefa:

```ruby
...
Rake::Task['changelog_gen'].clear_comments
```

Usando esta tarefa vamos agora modificar o ficheiro ```CHANGELOG.md``` e substituir a ultima linha. Para isso vamos criar e incluir uma nova classe de ruby com o nome "FileHelper" e ajudar a fazer as alterações na tarefa:

```
$ mkdir lib/helpers
$ touch lib/helpers/file_helper.rb 
```

 E addicionamos ao ```file_helper.rb```:
 
 ```ruby
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
```

Agora voltamos e modificamos o ficheiro ```Rakefile``` para adicionar uma tarefa update_log personalizada que utiliza o novo FileHelper:
```ruby
...
desc 'Compile the changelog file from github commits, issues, etc..'
task :changelog do
  Rake::Task['changelog_gen'].invoke
  helper = Minetest::Helpers::FileHelper.new
  helper.remove_lines("CHANGELOG.md", 9, 1)
  helper.append_lines("CHANGELOG.md", "Copyright © 2020 Júlio Papel")
end
```  

Agora para atualizar o CHANGELOG com as alterações da nossa aplicação usamos a nova tarefa changelog que criamos no Rake, sempre que precisar-mos e no final de adicionar uma nova funcionalidade ou correcção, assim atualizar e enviar para o github:

```
$ rake changelog
```

e mandamos para o github

```
$ git add .
$ git commit -am "Added changelog rake task"
$ git log --pretty=oneline
$ git tag -fa v0.1 fae9ed... 

```

substituir o fae9ed... com o último commit id do comando anterior "git log"

```
$ git push
$ git push --tags -f
```

## 4 - modificar a localização do executavél 
em ```minetest-cli.gemspec``` de ```exe``` para ```bin```
```ruby
...
spec.bindir        = "bin"
spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
...
```

e addicionar ao mesmo ficheiro ```minetest-cli.gemspec``` as novas dependencias externas e as dependencias de desenvolvimento que vamos usar:
```ruby
...
spec.add_dependency 'thor'
spec.add_dependency 'httparty'
spec.add_dependency 'highline'

spec.add_development_dependency "bundler"
spec.add_development_dependency "rake"
spec.add_development_dependency "github_changelog_generator"
...
```

#### Criar o binario executavél

```
$ touch bin/minetest-cli
```

Addicionar ao ```bin/minetest-cli``` 
```ruby
#!/usr/bin/env ruby -wU

require 'minetest/cli'

puts "Hello, world!"
```

#### Alterar as permissões do executavél

```
$ chmod +x bin/minetest-cli
$ bundle install
$ bundle exec bin/minetest-cli
```

## 5 - Criar a interface de comandos 
```lib/minetest/command_interface.rb```

```
$ touch lib/minetest/command_interface.rb
```

Utilizando a gem "thor" vamos criar o hello world no modulo para os comandos:
```ruby
require 'thor'

module Minetest
  class CommandInterface < Thor
    desc "hello NAME", "This will greet you"
    long_desc <<-HELLO_WORLD

    `hello NAME` will print out a message to the person of your choosing.

    Brian Kernighan actually wrote the first "Hello, World!" program
    as part of the documentation for the BCPL programming language
    developed by Martin Richards. BCPL was used while C was being
    developed at Bell Labs a few years before the publication of
    Kernighan and Ritchie's C book in 1972.
    
    HELLO_WORLD
    
    option :upcase
    def hello( name )
      greeting = "Hello, #{name}"
      greeting.upcase! if options[:upcase]
      puts greeting
    end
  end
end
```

 Incluir a clase CommandInterface no ficheiro ```lib/minetest/cli.rb```
```ruby
...
require "minetest/command_interface"
```

Alterar o ```bin/minetest-cli``` para inicializar com a clase CommandInterface
```ruby
#!/usr/bin/env ruby -wU

require 'minetest/cli'

Minetest::CommandInterface.start( ARGV )
```

Testamos se tudo funciona sem problemas. Qualquer problema deve ser resolvido antes de continuar.
O ```bundle exec``` grante que estamos a testar esta applicação e não uma versão instalada préviamente no sistema.

```
$ bundle exec bin/minetest-cli
$ bundle exec bin/minetest-cli hello
$ bundle exec bin/minetest-cli hello world
$ bundle exec bin/minetest-cli hello world --upcase
$ bundle exec bin/minetest-cli help
$ bundle exec bin/minetest-cli help hello
```

## 6- O irb do ruby 
Este pode ser usado para testar as funcionalidades desta applicação, no entanto o irb não sabe quais as novas classes Rake
  que usamos na nossa aplicação. Para que possamos aceder as classes vamos criar uma nova tarefa Rake
  no ficheiro ```Rakefile``` :
  ```ruby
  ...
  task :console do
    require 'irb'
    require 'irb/completion'
    require 'minetest/cli' # point to your application start file.

    def reload!

      files = $LOADED_FEATURES.select { |feat| feat =~ /\/my_gem\// }
      files.each { |file| load file }
    end

    ARGV.clear
    IRB.start
  end
  ```

Agora podemos testar o comando hello dentro do irb assim como outras definições e como verificar os valores de retorno, o conteudo das variaveis e a execuçao das classes. Usando o irb Também facilita ver que metodos ou implementações existem em classes provenientes de gems de terceiros e usadas nesta applicação.

```
$ rake console
```

```sh
:001 > ci = Minetest::CommandInterface.new
 => #<Minetest::CommandInterface:0x00007fb1b9928598 @_invocations={}, @_initializer=[[], {}, {}], @options={}, @args=[], @shell=#<Thor::Shell::Color:0x00007fb1ba897308 @base=#<Minetest::CommandInterface:0x00007fb1b9928598 ...>, @mute=false, @padding=0, @always_force=false>> 
:002 > ci.hello("world")
Hello, world
 => nil 
```

Para sair do irb, escreva "exit"

## 7- Implementar os comandos
Agora que tudo esta parece bem, podemos começar a implementar os comandos da applicaçao. No ficheiro ```command_interface.rb``` removemos a definição ```hello``` e adicionamos o primeiro comando ```server```

```rb
require "thor"
require "highline/import"
```
```sh
  $VERBOSE = true
  $thor_runner = nil
```
```rb
module Minetest
  class CommandInterface < Thor
    check_unknown_options!
        
    # The Server Command
    desc "server [ start | stop | restart ] [-m --map]", "Operates the Minetest Server Service"
    long_desc <<-DESC
    The server commnad is used to control the basic operations of the minetest server.
    this commnad needs a local minetest server installed configured.
    DESC
```
```rb
    map %w[-m --map] => :map, :desc => "map name Start with custom map.", :banner => " map_name"
    
    def server( sub_command )
      
      if ["start", "stop", "restart"].include? sub_command.downcase
        command = "systemctl service #{sub_command} minetest-server"
        command << " --config=#{options[:map]}.conf " if options[:map]
        puts command
      else
        help("server")
      end 
    end
    # End of Server Command
	
    private
    
    def self.exit_on_failure?
      ci = CommandInterface.new
      ci.help
    end
    
  end
end
```

Testamos o comando e as opções

```
$ bundle exec bin/minetest-cli server start
  systemctl service start minetest-server

$ bundle exec bin/minetest-cli server stop
  systemctl service stop minetest-server

$ bundle exec bin/minetest-cli server restart
  systemctl service restart minetest-server
  
$ bundle exec bin/minetest-cli server start --map black_castle
  systemctl service start minetest-server --config=black_castle.conf 
  
$ bundle exec bin/minetest-cli server stop --map black_castle
  systemctl service stop minetest-server
  
$ bundle exec bin/minetest-cli server restart --map black_castle
  systemctl service restart minetest-server --config=black_castle.conf 
  
$ bundle exec bin/minetest-cli server start -m black_castle
  systemctl service start minetest-server --config=black_castle.conf 
  
$ bundle exec bin/minetest-cli server stop -m black_castle
  systemctl service stop minetest-server
  
$ bundle exec bin/minetest-cli server restart -m black_castle
  systemctl service restart minetest-server --config=black_castle.conf
  
$ bundle exec bin/minetest-cli help server
  Usage:
    minetest-cli server [ start | stop | restart ] [-m --map]

  Options:
    -m, [--map= map_name]  # map name Start with custom map.

  Description:
    The server commnad is used to control the basic operations of the minetest server. this commnad needs a
    local minetest server installed configured.
```

Os comandos funcionam como esperado.

## 8 - Implementar o comando generate. 
vamos inserir o comando depois do server command, mas antes da palavra reservada ```private``` (daqui para baixo so devem haver metodos accessiveis apenas a esta classe)
  ```ruby
  ...
  # the Generate Command
  desc 'generate [ map | template ] [ map_name ] ', 'Generates a new map configuration'
  long_desc "The generate commnad is used to a create new maps / templates that can be used on the minetest server."
  option :from_map, :aliases => '-f', type: :array, :desc => "map name From existing custom map/template.", :banner => " map_name"
  def generate(sub_command, *map_name)
    
    if (["map", "template"].include? sub_command.downcase) && map_name.to_s.empty?
      if "map".include? sub_command.downcase
        
        input = ask "Provide the new map name: "
        command = "cp white_castle.template #{input.to_s.downcase.split.join('_')}.conf"
        puts command
        
      elsif "template".include? sub_command.downcase
        
        input = ask "Provide the new map template name: "
        command = "cp white_castle.template #{input.to_s.downcase.split.join('_')}.conf"
        puts command
        
      end
      
    elsif (["map", "template"].include? sub_command.downcase) && !map_name.to_s.empty?
      
      puts sub_command.downcase + " " + map_name.join('_').downcase + " " + options.from_map.join('_').downcase
      
    else
      help("generate")
    end
   
  end
  # End of Generate Command
  ...
  ``` 
   Testamos o comando e as opções

```
$ bundle exec bin/minetest-cli generate
  ERROR: "minetest-cli generate" was called with no arguments
  Usage: "minetest-cli generate [ map | template ] [ map_name ]"
  Commands:
    minetest-cli backup [ list | create ] [ restore ]                  # Manipulates backups of map configur...
    minetest-cli edit [ map | template ] [ map_name / template_name ]  # Edits your configuration map
    minetest-cli generate [ map | template ] [ map_name ]              # Generates a new map configuration
    minetest-cli get_data                                              # Deletes an existing map configurations
    minetest-cli help [COMMAND]                                        # Describe available commands or one ...
    minetest-cli remove                                                # Deletes an existing map configurations
    minetest-cli server [ start | stop | restart ] [-m --map]          # Operates the Minetest Server Service

$ bundle exec bin/minetest-cli generate map
  Provide the new map name:  mynewmap
  cp white_castle.template mynewmap.conf

$ bundle exec bin/minetest-cli generate template
  Provide the new map template name:  mynewtemplate
  cp white_castle.template mynewtemplate.template

$ bundle exec bin/minetest-cli generate map frommap
  cp white_castle.conf frommap.conf

$ bundle exec bin/minetest-cli generate template newtemplatemap
  cp white_castle.template newtemplatemap.template

```

os comandos funcionam como esperado.

## 9 -  Implementar o comando edit. 
vamos inserir o comando depois do generate command, mas antes da palavra reservada ```private``` (daqui para baixo so devem haver metodos accessiveis apenas a esta classe)
```ruby
...
# the Edit Command
desc 'edit [ map | template ] [ map_name / template_name ] ', 'Edits your configuration map'
long_desc " The edit commnad is used to edit the contents of a map to be used on the minetest server."
def edit(sub_command, *map_name)
  
  if (["map", "template"].include? sub_command.downcase) && map_name.to_s.empty?
    if "map".include? sub_command.downcase
      
      input = ask "Provide the map name to edit: "
      command = "vi #{input.to_s.downcase.split.join('_')}.conf"
      puts command
   	  
    elsif "template".include? sub_command.downcase
      
      input = ask "Provide the map template name to edit: "
      command = "vi #{input.to_s.downcase.split.join('_')}.template"
      puts command
   	  
    end
    
  elsif (["map", "template"].include? sub_command.downcase) && !map_name.to_s.empty?
    
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
...
``` 
   
   Testamos o comando e as opções

```
$ bundle exec bin/minetest-cli edit 
    ERROR: "minetest-cli edit" was called with no arguments
    Usage: "minetest-cli edit [ map | template ] [ map_name / template_name ]"
    Commands:
      minetest-cli backup [ list | create ] [ restore ]                  # Manipulates backups of map configur...
      minetest-cli edit [ map | template ] [ map_name / template_name ]  # Edits your configuration map
      minetest-cli generate [ map | template ] [ map_name ]              # Generates a new map configuration
      minetest-cli get_data                                              # Deletes an existing map configurations
      minetest-cli help [COMMAND]                                        # Describe available commands or one ...
      minetest-cli remove                                                # Deletes an existing map configurations
      minetest-cli server [ start | stop | restart ] [-m --map]          # Operates the Minetest Server Service

$ bundle exec bin/minetest-cli edit map
    Provide the map name to edit:  white_castle
    vi white_castle.conf

$ bundle exec bin/minetest-cli edit template
    Provide the map template name to edit:  White_castle
    vi white_castle.template
```

os comandos funcionam como esperado.

## 10 - Implementar o comando backup. 
vamos inserir o comando depois do comando edit, mas antes da palavra reservada ```private``` (daqui para baixo so devem haver metodos accessiveis apenas a esta classe)
   
```ruby
...
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
      existing_files = Dir.glob("#{backup_directory_name}/*.backup	  
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
      existing_files = Dir.glob("#{conf_directory_name}/*.conf	  
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
...
``` 
   
Testamos o comando e as opções

```
$ bundle exec bin/minetest-cli backup 
ERROR: "minetest-cli backup" was called with no arguments
Usage: "minetest-cli backup [ list | create ] [ restore ]"
Commands:
  minetest-cli backup [ list | create ] [ restore ]                  # Manipulates backups of map co...
  minetest-cli edit [ map | template ] [ map_name / template_name ]  # Edits your configuration map
  minetest-cli generate [ map | template ] [ map_name ]              # Generates a new map configura...
  minetest-cli get_data                                              # Deletes an existing map confi...
  minetest-cli help [COMMAND]                                        # Describe available commands o...
  minetest-cli remove                                                # Deletes an existing map confi...
  minetest-cli server [ start | stop | restart ] [-m --map]          # Operates the Minetest Server ...

$ bundle exec bin/minetest-cli backup list
      -[white_castle] : backup Level N.2
      -[black_castle] : backup Level N.1
      -[white_castle] : backup Level N.1
      -[white_castle] : backup Level N.3
      -[black_castle] : backup Level N.2

$ bundle exec bin/minetest-cli backup create
Available maps for backup:
   [1]-> white_castle
   [2]-> black_castle
Select the map number you want to backup: 1
cp ./custom-maps/white_castle.conf ./backup-files/white_castle.template

$ bundle exec bin/minetest-cli backup restore
for you to implement, and do not forget the backup levels option ...
```

Os comandos funcionam como esperado.

## 11 - Implementar o comando remove. 
vamos inserir o comando depois do comando backup, mas antes da palavra reservada ```private``` (daqui para baixo so devem haver metodos accessiveis apenas a esta classe)
   
```ruby
...
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
...
``` 
   
Testamos o comando

```
$ bundle exec bin/minetest-cli remove
Available files to remove:
   [1]-> white_castle.conf
   [2]-> black_castle.conf
   [3]-> white_castle-2.backup
   [4]-> black_castle-1.backup
   [5]-> white_castle-1.backup
   [6]-> white_castle-3.backup
   [7]-> black_castle-2.backup
Select the file number you want to remove: 3
are you sure? [Y/N] y
rm ./backup-files/white_castle-2.backup
```

Os comandos funcionam como esperado.



Editar o ficheiro ```minetest/cli/version.rb```
e atualizar a versão da nossa applicação:
```rb
module Minetest
  module Cli
    VERSION = "0.2.0"
  end
end
```
E Atualizar no github:

```
$ git add .

$ git commit -am "update version"

$ git push

$ git log --pretty=oneline
c24c8f4... (HEAD -> master, origin/master) update version
bdd12c8... update version
b5887f1... update commands
b3b6361... Added changelog rake task
320f79b... (tag: v0.1) Added changelog rake task
fae9ed2... Added changelog rake task
d71a03a... Update Changelog
7df3602... Initial gem Skeleton

$ git tag -fa v0.2 c24c8f4...

$ git push --tags -f
Enumerating objects: 1, done.
Counting objects: 100% (1/1), done.
Writing objects: 100% (1/1), 165 bytes | 165.00 KiB/s, done.
Total 1 (delta 0), reused 0 (delta 0)
To https://github.com/JulioPapel/minetest-cli.git
 * [new tag]         v0.2 -> v0.2

$ rake changelog

$ git add .

$ git commit -am "update CHANGELOG"

$ git push
```

## 12 - Gerar o ficheiro gem
Agora que temos um código fantastico, vamos compilar tudo em um só ficheiro .gem utitlizando o comando "gem" no terminal.
no directório minitest-cli:

```
$ gem build minetest-cli.gemspec
```

Este comando constroi a gem e o nome do ficheiro inclui o número da versão. minetest-cli-0.2.0. 
You should see the following output and some warnings about missing attributes:

Successfully built RubyGem
  Name: awesome_gem
  Version: 0.0.0
  File: awesome_gem-0.0.0.gem
But you don’t care about warnings, because you are living on the edge and you are “awesome”. So you decide to move on and install this gem on your system. Notice that the gem file was created in your current directory.

E assim está concluído este exemplo de uma aplicação de linha de comandos em Ruby. Espero que tenham gostado e que a partir deste exemplo possam criar novas aplicações CLI para gerir, configurar, modificar ou automatizar tarefas nos vossos computadores e servidores. Muitos exemplos de manipulação e edição de ficheiros, para um ou outro Sistema Operativo podem facilmente ser encontrados na web. 


