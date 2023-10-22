# SED

The `sed` command can be used to replace characters and patterns in text.

It looks like this:

`sed s/<regex_pattern_to_replace>/<characters_to_replace_with>/<regex_flags`

The command below _pipes_ a string `(28 | Mountain)` to the `sed` command, where it replaces all the spaces with `=`

  `echo '28 | Mountain' | sed 's/ /=/g'`
  
The command below replaces all the spaces with nothing

  `echo '28 | Mountain' | sed 's/ //g'`

The `g` regex flag stands for _global_. It will replace all instance of the pattern. In this case, it replaced all the spaces
