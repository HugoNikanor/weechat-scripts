(weechat:register
  "Emote_displayer"
  "Hugo Hörnquist"
  "1.2"
  "GPL3"
  "Adds /emote command"
  ""
  "")

(define emotes
  (with-input-from-file
    (string-append (getenv "HOME")
                   "/.weechat/guile/data/emotes")
    (lambda () (read))))

(define (emote_displayer data buffer command)
  (let* ((arg (cadr (string-split command #\space))))
    (if (string= arg "help")
      (for-each (lambda (emote)
                  (weechat:print "" (format #f "~a : ~a"
                                            (car emote)
                                            (cdr emote))))
                emotes)
      (let ((emote (assoc-ref emotes arg)))
        (weechat:command buffer emote)))
    weechat:WEECHAT_RC_OK_EAT))

(weechat:hook_command_run "/emote" "emote_displayer" "")

