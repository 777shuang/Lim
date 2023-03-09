import liblim/os

if cmdParamCount == 0:
    echo "DEBUG"
else:
    for i in 1..(cmdParamCount - 1):
        let
            file = open(cmdParams[i])