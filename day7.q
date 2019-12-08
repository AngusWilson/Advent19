input:"3,8,1001,8,10,8,105,1,0,0,21,42,51,60,77,94,175,256,337,418,99999,3,9,1001,9,4,9,102,5,9,9,1001,9,3,9,102,5,9,9,4,9,99,3,9,102,2,9,9,4,9,99,3,9,1001,9,3,9,4,9,99,3,9,101,4,9,9,1002,9,4,9,101,5,9,9,4,9,99,3,9,1002,9,5,9,101,3,9,9,102,2,9,9,4,9,99,3,9,1001,9,1,9,4,9,3,9,1002,9,2,9,4,9,3,9,102,2,9,9,4,9,3,9,102,2,9,9,4,9,3,9,102,2,9,9,4,9,3,9,101,2,9,9,4,9,3,9,101,2,9,9,4,9,3,9,101,2,9,9,4,9,3,9,1001,9,1,9,4,9,3,9,101,1,9,9,4,9,99,3,9,1001,9,2,9,4,9,3,9,101,1,9,9,4,9,3,9,102,2,9,9,4,9,3,9,1001,9,1,9,4,9,3,9,101,2,9,9,4,9,3,9,1002,9,2,9,4,9,3,9,1001,9,1,9,4,9,3,9,101,1,9,9,4,9,3,9,1001,9,2,9,4,9,3,9,1002,9,2,9,4,9,99,3,9,101,2,9,9,4,9,3,9,102,2,9,9,4,9,3,9,101,2,9,9,4,9,3,9,102,2,9,9,4,9,3,9,1002,9,2,9,4,9,3,9,102,2,9,9,4,9,3,9,102,2,9,9,4,9,3,9,101,2,9,9,4,9,3,9,1001,9,2,9,4,9,3,9,101,2,9,9,4,9,99,3,9,101,2,9,9,4,9,3,9,1002,9,2,9,4,9,3,9,1001,9,1,9,4,9,3,9,101,1,9,9,4,9,3,9,1001,9,1,9,4,9,3,9,1002,9,2,9,4,9,3,9,1002,9,2,9,4,9,3,9,101,1,9,9,4,9,3,9,102,2,9,9,4,9,3,9,101,2,9,9,4,9,99,3,9,1001,9,2,9,4,9,3,9,101,2,9,9,4,9,3,9,1002,9,2,9,4,9,3,9,101,2,9,9,4,9,3,9,101,2,9,9,4,9,3,9,102,2,9,9,4,9,3,9,1002,9,2,9,4,9,3,9,102,2,9,9,4,9,3,9,1002,9,2,9,4,9,3,9,101,1,9,9,4,9,99"


input:"3,52,1001,52,-5,52,3,53,1,52,56,54,1007,54,5,55,1005,55,26,1001,54,-5,54,1105,1,12,1,53,54,53,1008,54,0,55,1001,55,1,55,2,53,55,53,4,53,1001,56,-1,56,1005,56,6,99,0,0,0,0,10"
input:"3,26,1001,26,-4,26,3,27,1002,27,2,27,1,27,26,27,4,27,1001,28,-1,28,1005,28,6,99,0,0,5"
intcode:{[x;i;userInputs];
    //Parse input, set initial values
    /i:0;
    show userInputs;
    manualInput:userInputs inpCounter:0;
    output:0;
    args:0;
    if[i>0;manualInput: userInputs 1];
    //Each opperation takes:
    //x - full list
    //i - index of operation
    //y - input
    //z - arguments for opperation
    //
    //Returns
    //(new list,new index, output)
    op:(!) . flip (
        //1 - sum the args
        ((0;1);{[x;i;y;z] (@[x;x i+3;:;sum z];i+4;y)});
        //2 - multiply the args
        ((0;2);{[x;i;y;z] (@[x;x i+3;:;prd z];i+4;y)});
        //3 - save input to postion
        ((0;3);{[x;i;y;z] (@[x;x i+1;:;y];i+2;y)});
        //4 - output value as position
        ((0;4);{[x;i;y;z] (x;i+2;x x i+1)});      
        //5 - jump func, no op
        ((0;5);{[x;i;y;z] (x;$[0<>z 0; z 1 ;i+3];y)});
        //6 - jump func, no op
        ((0;6);{[x;i;y;z] (x;$[0=z 0; z 1 ;i+3];y)});
        //7 - if arg[0]<arg[1] then store 1 in position otherwise 0
        ((0;7);{[x;i;y;z] (@[x;x i+3;:;] $[z[0]<z[1];1;0];i+4;y)});
        //8 - if arg[0]=arg[1] then store 1
        ((0;8);{[x;i;y;z] (@[x;x i+3;:;] $[z[0]=z[1];1;0];i+4;y)})
        );

   
    //Dict for the number of args in each operation. Used to select argument set 
    opNumArgs:((0;1);(0;2);(0;3);(0;4);(0;5);(0;6);(0;7);(0;8))!(4 4 2 2 4 4 4 4);
 
    //Mode of execution, positional vs immediate
    posIm:(0 1)!({x y};{y});
    
    //Func used to split mode from operation code
    opSplit:{-5#0 0 0 0,10 vs x};
    
    
    //Loop over opperations until 99 code for termination.
    while[not (9;9)~mode:-2#parameters:opSplit x i;
        
        //pick out args, if op doesn't use them it doesn't matter
        opSet:x i+til opNumArgs[mode];
        args:(posIm -1_ reverse -2_parameters).' enlist[x],/: enlist each opSet 1 2;
      
        //Execute opperation, capture out
        out:.[op[mode];(x;i;manualInput;args)];
            x:out 0;
            i:out 1;
            output:out 2;

        //If we have an output, return full system state
        if[mode~(0;4);
            /show"hit a 4 - returning output";
            :(x;i;output);
            ];
            
        if[mode~(0;3);
            /show"hit a 3 - inputing",string manualInput;
            manualInput:userInputs 1;
            ];
        /show x;
        ];
    :(`halt;output)
    };


perm:{[s] $[(count s)=1;s;[p:(rotate[1]\)s;raze(( first each p),/:'perm each 1_/:p)]]}


.d7.p1:{
    thrust:{[setting]
        out:0;

        i:0;
        do[5;
            out:intcode[(setting[i];out)];
            show out;
            i+:1;
            ];
        out
        }

    thrusts:thrust each perm til 5

    max thrusts
    }


part2:{[setting]
    intInput:"I"$"," vs input;   
    ampI:0;
    out:0;
    amp:`a;
    
    state:`a`b`c`d`e!5#enlist intInput;
    iState:`a`b`c`d`e!5#0;
    ampMode:`a`b`c`d`e!setting;
    lastOut:`a`b`c`d`e!5#0;
    /show setting;
    while[not `halt~first out:intcode[state amp;iState amp;(ampMode amp;last out)];
        /show amp;
        state[amp]:out 0;
        iState[amp]:out 1;
        lastOut[amp]:out 2;


        ampI+:1;
        amp:key[state] ampI mod 5;
        ];

    lastOut`e
    }    

.d7.p2:{
    thrusts:part2 each perm 5+til 5;

    (perm 5+ til 5)where thrusts = max thrusts
    }
