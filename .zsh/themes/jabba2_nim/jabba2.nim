import strformat
import functions

# func fg(text: string, n: int): string =
  # &"\x1b[38;5;{n}m{text}\x1b[0m"
#
# echo fg("hello", 153)

# echo color("laci", bg="green"), reset("")

let
  line1 = &"{hr()}\n"
  line2 = &"{nimProjectInfo()}{virtualEnvInfo()}{timeInfo()} [nim] {color(tilde(getCwd()), magenta, b=true)}{coloredBranchName()}{coloredPrompt()} "
  result = line1 & line2

echo result
