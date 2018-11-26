import
  os,
  osproc,
  sequtils,
  strformat,
  strutils,
  tables,
  times

let light_mode = (getEnv("ZSH_THEME_MODE") == "light")

const
  prompt = "$"
  separator = "="
  # separator = "─"    # Unicode, no little space between two such characters

  magenta* = "magenta"
  yellow* = "yellow"
  green* = "green"
  blue* = "blue"
  red* = "red"

func lchop(s, sub: string): string =
  ## Remove ``sub`` from the beginning of ``s``.
  if s.startsWith(sub):
    s[sub.len .. s.high]
  else:
    s

func rchop(s, sub: string): string =
  ## Remove ``sub`` from the end of ``s``.
  if s.endsWith(sub):
    s[0 ..< ^sub.len]
  else:
    s

proc getCurrentTime*(): string =
  let
    now = times.now()
    (h, m, s) = (now.hour, now.minute, now.second)

  &"{h:02}:{m:02}:{s:02}"

func hr*(letter = separator, width = 78): string =
  letter.repeat(width)

func zeroWidth*(s: string): string =
  return fmt"%{{{s}%}}"

func foreground*(s, color: string): string =
  const colors = {
    "black":"\x1b[30m",
    "red": "\x1b[31m",
    "green": "\x1b[32m",
    "yellow": "\x1b[33m",
    "blue": "\x1b[34m",
    "magenta": "\x1b[35m",
    "cyan": "\x1b[36m",
    "white": "\x1b[37m",
  }.toTable
  return fmt"{zeroWidth(colors[color])}{s}"

func background*(s, color: string): string =
  const colors = {
    "black":"\x1b[40m",
    "red": "\x1b[41m",
    "green": "\x1b[42m",
    "yellow": "\x1b[43m",
    "blue": "\x1b[44m",
    "magenta": "\x1b[45m",
    "cyan": "\x1b[46m",
    "white": "\x1b[47m",
  }.toTable
  return fmt"{zeroWidth(colors[color])}{s}"

func bold*(s: string): string =
  const b = "\x1b[1m"
  return fmt"{zeroWidth(b)}{s}"

func underline*(s: string): string =
  const u = "\x1b[4m"
  return fmt"{zeroWidth(u)}{s}"

func reverse*(s: string): string =
  const rev = "\x1b[7m"
  return fmt"{zeroWidth(rev)}{s}"

func reset*(s: string): string =
  const res = "\x1b[0m"
  return fmt"{s}{zeroWidth(res)}"

func color*(s: string, fg: string = "", bg: string = "",
  b: bool = false, u: bool = false, r = false): string =
  result = s
  if s.len == 0:
    return s
  if fg.len != 0:
    result = foreground(result, fg)
  if bg.len != 0:
    result = background(result, bg)
  if b:
    result = bold(result)
  if u:
    result = underline(result)
  if r:
    result = reverse(result)
  result = reset(result)

proc tilde*(path: string): string =
  let home = getHomeDir().rchop("/")    # without trailing '/'

  if path.startsWith(home):
    result = "~" & path.lchop(home)    # replace the first occurrence only
  else:
    result = path

proc getWorkingDir(): string =
  # v1. If I enter a symbolic link that points on a folder, it'll show
  #     the real path without the symbolic link (like `/bin/pwd`).
  # getCurrentDir()
  # v2. If you enter a symbolic link that points on a folder, you'll
  #     see the name of the symbolic link in the path. I prefer it.
  # execProcess("pwd").strip
  getEnv("PWD")    # same result as calling `pwd`

proc getCwd*(): string =
  try:
    result = getWorkingDir() & " "
  except OSError:
    result = "[not found]"

proc virtualenv*(): string =
  let env = getEnv("VIRTUAL_ENV")
  if env.len == 0:
    result = ""
  else:
    result = "($1) ".format(extractFilename(env))

proc getBranchName(): string =
  let
    gitCmd = "git symbolic-ref --short -q HEAD"
    (output, errorCode) = execCmdEx(gitCmd)

  if errorCode == 0:
    output.strip
  else:
    ""

proc isDirty(): bool =
  let
    gitCmd = "git status --porcelain --ignore-submodules -unormal"
    output = execProcess(gitCmd)

  output.len != 0

proc coloredBranchName*(): string =
  let name = getBranchName()

  if name.len == 0:
    return ""

  if isDirty():
    color(&"({name}) ", red, b=true)
  else:
    let bold = if light_mode: false else: true
    color(&"({name}) ", green, b=bold)

proc nimProjectInfo*(): string =
  let col = if light_mode: blue else: yellow

  for fname in walkFiles("*.nimble"):
    return "$1$2$3 ".format(
      color("(", blue, b=true),
      color("♛", col, b=true),
      color(")", blue, b=true)
    )
  # if no .nimble file was found
  ""

proc virtualEnvInfo*(): string =
  color(virtualenv(), blue, b=true)

proc timeInfo*(): string =
  let bold = if light_mode: false else: true

  color("[$1]".format(getCurrentTime()), green, b=bold)

proc coloredPrompt*(): string =
  try:
    let retCode = paramStr(1).parseInt
    if retCode == 0:
      result = prompt
    else:
      result = color(prompt, red, b=true)
  except:
    result = prompt

# proc user*(): string =
  # result = getEnv("USER")

# proc host*(): string =
  # result = getEnv("HOST")

# proc horizontalRule*(c: char = '-'): string =
  # let width = terminalWidth()
  # for i in countup(1, width):
    # result &= c
  # result &= zeroWidth("\n")
