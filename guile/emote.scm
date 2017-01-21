(weechat:register
  "Emote_displayer"
  "Hugo Hörnquist"
  "1.0"
  "GPL3"
  "Adds /emote command"
  ""
  "")

(define emotes
  '(("shrug" .  "¯\\_(ツ)_/¯")
    ("lenny" . "(͡° ͜ʖ ͡°)")
    ("table-flip" . "(╯°□°）╯︵ ┻━┻")
    ("table-return" .  "┬──┬ ノ( ゜-゜ノ)")
    ("deal" . "•_•)\n( •_•)>⌐■-■\n(⌐■_■)")
    ("donger" . "ヽ༼ຈل͜ຈ༽ﾉ")))

(define (emote_displayer data buffer command)
  (let* ((arg (cadr (string-split command #\space))))
    (if (string= arg "help")
      (for-each (lambda (emote)
                  (weechat:print "" (format #f "~s: ~s"
                                            (car emote)
                                            (cdr emote))))
                emotes)
      (let ((emote (assoc-ref emotes arg)))
        (weechat:command buffer emote)))
    weechat:WEECHAT_RC_OK_EAT))

(weechat:hook_command_run "/emote" "emote_displayer" "")

