import std/[terminal , strutils , options]
import c/time_h

when defined(fileLog):
  import std/[streams , os]

proc print(f:File , msgType , str:string , color:ForegroundColor) =
  when not defined(noLog):
    when defined(fileLog):
      let file = open(getAppDir() / "Log.txt" , FileMode.fmWrite)
    else:
      let file = f
    var now = time(nil)
    let local = localtime(now.addr)
    file.styledWrite(
      fgMagenta ,
      "[",
      intToStr(local.tm_year + 1900) ,
      "/" ,
      intToStr(local.tm_mon + 1) ,
      "/" ,
      intToStr(local.tm_mday + 1) ,
      " " ,
      intToStr(local.tm_hour) ,
      ":" ,
      intToStr(local.tm_min) ,
      ":" ,
      intToStr(local.tm_sec) ,
      "] "
    )
    f.styledWrite(color , msgType)
    f.styledWrite(fgWhite , " > ")
    f.styledWrite(color , str)

proc printErr*(str:string) = stderr.print("Error " , str & " !\a\n" , fgRed)
proc printLog*(str:string) = stdout.print("Log   " , str & "\n" , fgGreen)
proc printInfo*(str:string) = stdout.print("Info  " , str & "\n", fgBlue)
proc printWarn*(str:string) = stdout.print("Warn  " , str & " !\n" , fgYellow)
proc printDbg*(str:string) = stdout.print("Debug " , str & "\n" , fgWhite)

proc printPromptBase(prompt , answer:string):string =
  stdout.print("Prompt" , prompt & "\n" , fgYellow)
  stdout.styledWrite(fgYellow , "Answer " & answer & " ")
  return stdin.readLine

proc printPrompt*(question:string):string = return printPromptBase(question , ">")

const
  yes = "Yes"
  no = "No"

proc printPromptBase_YN(question:string , def:string):Option[bool] =
  var input = printPromptBase(question & "(" & yes & "/" & no & ")" , "[" & def & "] >").toLower.capitalizeAscii
  echo input
  if input == "":
    input = def
  proc compare(str :string):bool =
    return input == str or input == str.substr(0 , 0)
  if compare(yes):
    return option(true)
  if compare(no):
    return option(false)
  return none(bool)

proc printPrompt*(question:string , def:bool):Option[bool] {.inline.} =
  if def == true:
   return printPromptBase_YN(question , yes)
  else:
   return printPromptBase_YN(question , no)