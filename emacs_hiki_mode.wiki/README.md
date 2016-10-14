
# 概要
emacs hiki mode

# 
```lisp
bob% cat lib/hiki-mode.el 
(defun hiki-mode ()
  "Hiki Mode "
  (interactive)
  (kill-all-local-variables)
  (setq mode-name "Hiki")
  (setq major-mode 'hiki-mode)
 
  (run-hooks 'hiki-mode-hook))
 
(provide 'hiki-mode)
```

```ruby
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
```
