proc toString*[T: char|byte](cstr: openArray[T]): string =
  ## Converts a byte sequence to the corresponding string.
  let length = cstr.len
  if length > 0:
    var nstr = newString(length)
    copyMem(nstr.cstring, cstr[0].unsafeAddr, length)
    return nstr
  else:
    return ""