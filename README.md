1. comment check... failed... succeeded, put require at init.el

# 概要
emacs hiki mode 

# 参考資料
- ![](http://ergoemacs.org/emacs/elisp_syntax_coloring.html), ほとんどこれでできそう．だめや．
- ![](https://www.emacswiki.org/emacs/SampleMode),samplemodeが載っています．動きません．(hiki-mode_1.el)
- ![](http://jblevins.org/projects/markdown-mode/),markdown-modeを参照して作ってみます．ぜんぜんだめ．
- ![](https://www.emacswiki.org/emacs/DerivedMode),derived-modeを参照して作ってみます．(hiki-mode.el)
  - お．動いた．

# 初期設定
以下にhiki-modeのひな形を示す．
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
以上のファイルをlib/hiki-mode.elとして用意しておく．
次のRakefileにしたがって，'rake hiki'によってemacsがhiki-modeをautoloadしてくれる．
```ruby
desc "install hiki-mode in emacs"
task :hiki do
  emacs_dir =File.join(ENV['HOME'],'.emacs.d') #never use ~ for homedir.
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
