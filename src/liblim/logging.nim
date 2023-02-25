import std/[terminal , strutils]
import c/time_h

when defined(fileLog):
  import std/[streams , os]

proc print(f:File , msgType , str:string , color:ForegroundColor) =
  when not defined(noLog):
    when defined(fileLog):
      let file = openFileStream(os.getAppDir() / "Log.txt" , fmWrite)
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
    f.write("\n")

proc printErr*(str:string) = stderr.print("Error" , str & " !\a" , fgRed)
proc printLog*(str:string) = stdout.print("Log  " , str , fgGreen)
proc printInfo*(str:string) = stdout.print("Info " , str , fgBlue)
proc printWarn*(str:string) = stdout.print("Warn " , str & " !" , fgYellow)
proc printDbg*(str:string) = stdout.print("Debug" , str , fgWhite)
