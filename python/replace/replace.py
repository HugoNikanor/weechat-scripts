import weechat
import unicodedata
import string

weechat.register ("Symbol_Replacer", "Hugo Hörnquist", "0.2", "GPL3", "Replaces some characters", "", "")

"""
:<header> :message
"""

PRINTABLE_CHARS = string.printable + "åäö"

def change(c):
    return ":" + unicodedata.name(c) + ":"

def replace_special (data, modifier, modifier_data, string):
    lst = string.split (":")
    header = ":".join(lst[:2])
    tail = ":".join(lst[2:])
    proctail = "".join ([c if c in PRINTABLE_CHARS \
            else change(c) for c in tail])
    return header + ":" + proctail

weechat.hook_modifier ("irc_in_privmsg", "replace_special", "")
