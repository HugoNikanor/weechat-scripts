#!/usr/bin/guile \
-e main -s
!#

(weechat:register
  "Symbol_Replacer"
  "Hugo Hörnquist"
  "0.1"
  "GPL3"
  "Replaces some characters"
  ""
  "")

#|
 | This is a program which replaces any unwanted character
 | with its full Unicode name. Currently surrounded by two
 | colon characters (`:').
 |     The development plan is to make it into a WeeChat
 | plugin which will replace all charecters not printable
 | in the terminal with a description of them. This is since
 | if the user is using a codepage which doesn't render wide
 | charecters then the entire layout of WeeChat get's messed
 | up.
 | --
 | Hugo Hörnquist 2018-01-02
 |#

(use-modules (srfi srfi-1))

#|
(use-modules (ice-9 unicode)
             (ice-9 streams)
             (ice-9 rdelim))

(define *cs* char-set:ascii)

(define (disprepl)
  "Reads characters from STDIN one by one and replaces any
   not in the charset *cs* with it's Unicode name."
  (display
    (string-concatenate
      (stream->list
        (stream-map
          (lambda (char)
            (if (char-set-contains? *cs* char)
              (string char)
              (string-append "::" (char->formal-name char) "::")))
          (port->stream (current-input-port) read-char))))))


(define (main args)
  (if (null? (cdr args))
    (disprepl)
    (with-input-from-string
      (string-concatenate (cdr args))
      (lambda ()
        (disprepl)))))
|#

;;(define (process str)
;;  (string-append str "..."))

(define (process str) str)

(define (replace_special data modifier modifier_data string)
  (let* ((lst (string-split string #\:))
         (header (drop-right lst 1))
         (str (last lst)))
    (string-join (append header (list (process str)))
                 ":")))


(weechat:hook_modifier "irc_in_privmsg" "replace_special" "")

