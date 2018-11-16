import strformat
import functions

let
  line1 = &"{hr()}\n"
  line2 = &"{nimProjectInfo()}{color(virtualenv(), blue, b=true)}{color('[' & getCurrentTime() & ']', green, b=true)} [nim] {color(tilde(getCwd()), magenta, b=true)}{coloredBranchName()}{coloredPrompt()} "
  result = line1 & line2

echo result
