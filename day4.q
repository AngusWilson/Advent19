input:"153517-630395"

//Get list of passcodes in range
//Turn into integer representation of the individual characters, as is faster than actual value/int/long cast
//Generate deltas
getDelts:{[input]
    input:"I"$"-" vs input;
    strInput:string input[0]+til input[1]-input 0;
    deltas each `int$strInput
    }

//Get locations that all deltas are zero or positive (number is increasing digits)
//AND there is a zero delta, meaning you have a matching pair in the string
validPassLocs:{[delts]
    where (all each -1<delts) and 0 in/: delts
    }

//Count locations of valid passcodes
.d4.p1:{count validPassLocs getDelts input}

//Look for 0 deltas, giving pairs, but only ones that do not have string of no increase
.d4.p2:{
    delts:getDelts input;
    sum any (raze each string (0=delts validPassLocs delts)) like/:("*010*";"*01")
    }

.d4.p1[]
.d4.p2[]
