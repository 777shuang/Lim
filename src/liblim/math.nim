proc `^`*(left , right:int):int =
    var rtn = left
    for i in 1..right:
        rtn *= left
    return rtn