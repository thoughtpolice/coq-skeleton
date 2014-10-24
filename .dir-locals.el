;; Work around an (apparent) bug in Proof General in which it
;; doesn't properly understand _CoqProject arguments for coqtop.
((coq-mode . ((coq-prog-args .
  ("-emacs-U" "-R" "." "Skeleton")))))
