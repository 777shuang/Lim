import std/time_t as tt

{.push header:"<time.h>".}

type
  time_t* = Time
  tm* = object
    tm_sec*: cint # [0-61]
    tm_min*: cint # [0-59]
    tm_hour*: cint # [0-23]
    tm_mday*: cint # [1-31]
    tm_mon*: cint # [0-11]
    tm_year*: cint
    tm_wday*: cint # [0-6]
    tm_yday*: cint # [0-365]
    tm_isdst*: cint

proc difftime*(time1 , time0 :time_t) :float
proc mktime*(timeptr :ptr tm) :time_t
proc time*(timer :ptr time_t) :time_t
proc asctime*(timeptr :ptr tm) :cstring
proc ctime*(timer :ptr time_t) :cstring
proc gmtime*(timer :ptr time_t) :ptr tm
proc localtime*(timer :ptr time_t) :ptr tm