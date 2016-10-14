require "bundler/gem_tasks"
require 'yard'
require "rake/testtask"
require 'fileutils'
p base_path = File.expand_path('..', __FILE__)
p basename = File.basename(base_path)

task :default do
  system 'rake -T'
end

desc "make documents by yard"
task :yard => [:hiki2md] do
  YARD::Rake::YardocTask.new
end

desc "transfer hikis/*.hiki to wiki"
task :hiki2md do
  files = Dir.entries('hikis')
  files.each{|file|
    name=file.split('.')
    case name[1]
    when 'hiki'
      p command="hiki2md hikis/#{name[0]}.hiki > #{basename}.wiki/#{name[0]}.md"
      system command
    when 'gif','png','pdf'
      p command="cp hikis/#{file} #{basename}.wiki/#{file}"
#      system command
      FileUtils.cp("hikis/#{file}","#{basename}.wiki/#{file}",:verbose=>true)
      FileUtils.cp("hikis/#{file}","doc/#{file}",:verbose=>true)
    end
  }
  readme_en="#{basename}.wiki/README_en.md"
  readme_ja="#{basename}.wiki/README_ja.md"
  if File.exists?(readme_en)
    FileUtils.cp(readme_en,"./README.md",:verbose=>true)  
  elsif File.exists?(readme_ja)
    FileUtils.cp(readme_ja,"./README.md",:verbose=>true)
    FileUtils.cp(readme_ja,"#{basename}.wiki/Home.md",:verbose=>true)
  end
end

desc "transfer hikis/*.hiki to latex"
task :latex do
  target = 'handout_sample'
  command = "hiki2latex --pre latexes/handout_pre.tex hikis/#{target}.hiki > latexes/#{target}.tex"
  system command
  command = "open latexes/#{target}.tex"
  system command
end

desc "install hiki-mode in emacs"
task :hiki do
  emacs_dir =File.join(ENV['HOME'],'.emacs.d')
  p target = File.join(emacs_dir,"hiki-mode")
  FileUtils.mkdir_p(target)
  command = "cp lib/hiki-mode.el  #{target}"
  system command
p  cont = <<EOS

;; =========
;; hiki mode
;; =========
(setq load-path (cons "#{target}" load-path))
(require 'hiki-mode)
(autoload 'hiki-mode "hiki-mode" "hiki mode" t)
(add-to-list 'auto-mode-alist '("\\.hiki$" . hiki-mode))
(setq-default indent-tabs-mode t)
(setq tab-width 2)
EOS

  p init_el = File.join(emacs_dir,"init.el")
  begin
    file = File.open(init_el,'a+')
  rescue => eval
    p eval
    exit
  end
  if file.read.include?("hiki mode") then
    exit
  else
    file.print cont
    file.close
  end
end

