(use-package ligature
  :config
  (ligature-set-ligatures 't '("{{" "}}" "{{--" "--}}" "{|" "|}" "[|" "|]" "//" "///" "/*" "/**" "++" "+++" ".?" ".." "..." "..<" "<!--" "<<-" "<-" "<#--" "<>" "<:" "<:<" ">:>" "<=>" "<->" "<|||" "<||" "<|" "<|>" "||>" "|>" "-|" "->>" "-->" "->" ">=" "<=" "<<=" "<==" "!=" "!!" "!==" "=!=" "=>" "==" "=:=" ":=:" ":=" ":>" ":<" "::" ";;" ";;;" ":?" ":?>" "::=" "||-" "||=" "|-" "|=" "||" "--" "---" "<--" "??" "???" "?:" "?." "&&" "__" "=/=" "<-<" "<=<" "<==>" "==>" "=>>" ">=>">>=">>" ">>-" "-<" "-<<" "<-|" "<=|" "|=>" ">-" "<~" "~~" "<~>" "<~~" "-~" "~~>" "~>" "~-" "~@" "<+>" "<+" "+>" "<*>" "<*" "*>" "</>" "</" "/>" "<<" "<<<" ">>" ">>>" "#{" "#[" "#(" "#?" "#_" "#__" "#:" "#=" "#_(" "]#" "0x12" "[TRACE]" "[DEBUG]" "[INFO]" "[WARN]" "[ERROR]" "[FATAL]" "[TODO]" "todo))" "[FIXME]" "fixme))" "########" "<!---->"))
  (global-ligature-mode 't))