import
  os,
  osproc,
  sequtils,
  strformat,
  strutils,
  tables,
  times

const
  STATUS_CODE_FILE = "/tmp/9033289e.tmp"
  prompt = "$"

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

proc getCurrentTime*(): string =
  let
    now = times.now()
    (h, m, s) = (now.hour, now.minute, now.second)

  &"{h:02}:{m:02}:{s:02}"

func hr*(letter = '=', width = 78): string =
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

# proc horizontalRule*(c: char = '-'): string =
  # let width = terminalWidth()
  # for i in countup(1, width):
    # result &= c
  # result &= zeroWidth("\n")

proc tilde*(path: string): string =
  let home =    # without trailing '/'
    block:
      let dname = getHomeDir()
      if dname.endswith("/"): dname[0 ..< ^1] else: dname

  if path.startsWith(home):
    result = "~" & path.lchop(home)    # replace the first occurrence only
  else:
    result = path

proc getCwd*(): string =
  try:
    result = getCurrentDir() & " "
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
    color(&"({name}) ", green, b=true)

proc nimProjectInfo*(): string =
  let files = toSeq(walkFiles("*.nimble"))
  if files.len > 0:
    "$1$2$3 ".format(
      color("(", blue, b=true),
      color("♛", yellow, b=true),
      color(")", blue, b=true)
    )
  else:
    ""

proc coloredPrompt*(): string =
  try:
    let retCode = readFile(STATUS_CODE_FILE).strip.parseInt
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
