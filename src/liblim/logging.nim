import std/[terminal , strutils]
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
proc printInfo*(str:string) = stdout.print("Info  " , str , fgBlue)
proc printWarn*(str:string) = stdout.print("Warn  " , str & " !\n" , fgYellow)
proc printDbg*(str:string) = stdout.print("Debug " , str & "\n" , fgWhite)

proc printPromptBase(prompt , answer:string) =
  stdout.print("Prompt" , prompt & "\n" , fgYellow)
  stdout.styledWrite(fgYellow , "Answer " & answer & " ")
proc printPrompt*(str:string):string =
  printPromptBase(str , ">")
  return stdin.readLine()
proc printPrompt*(str , def :string):string =
  printPromptBase(str , "[" & def & "] >")