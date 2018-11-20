import strformat
import functions

let
  line1 = &"{hr()}\n"
  line2 = &"{nimProjectInfo()}{virtualEnvInfo()}{timeInfo()} [nim] {color(tilde(getCwd()), magenta, b=true)}{coloredBranchName()}{coloredPrompt()} "
  result = line1 & line2

echo result
