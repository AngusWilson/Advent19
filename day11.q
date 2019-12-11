input:"3,8,1005,8,310,1106,0,11,0,0,0,104,1,104,0,3,8,1002,8,-1,10,101,1,10,10,4,10,1008,8,0,10,4,10,1001,8,0,29,1,2,11,10,1,1101,2,10,2,1008,18,10,2,106,3,10,3,8,1002,8,-1,10,1001,10,1,10,4,10,1008,8,1,10,4,10,102,1,8,67,2,105,15,10,3,8,1002,8,-1,10,101,1,10,10,4,10,1008,8,0,10,4,10,1001,8,0,93,2,1001,16,10,3,8,102,-1,8,10,1001,10,1,10,4,10,1008,8,1,10,4,10,102,1,8,119,3,8,1002,8,-1,10,1001,10,1,10,4,10,1008,8,1,10,4,10,101,0,8,141,2,7,17,10,1,1103,16,10,3,8,1002,8,-1,10,101,1,10,10,4,10,108,0,8,10,4,10,102,1,8,170,3,8,1002,8,-1,10,1001,10,1,10,4,10,1008,8,1,10,4,10,1002,8,1,193,1,7,15,10,2,105,13,10,1006,0,92,1006,0,99,3,8,1002,8,-1,10,101,1,10,10,4,10,108,1,8,10,4,10,101,0,8,228,1,3,11,10,1006,0,14,1006,0,71,3,8,1002,8,-1,10,101,1,10,10,4,10,1008,8,0,10,4,10,101,0,8,261,2,2,2,10,1006,0,4,3,8,102,-1,8,10,101,1,10,10,4,10,108,0,8,10,4,10,101,0,8,289,101,1,9,9,1007,9,1049,10,1005,10,15,99,109,632,104,0,104,1,21101,0,387240009756,1,21101,327,0,0,1105,1,431,21101,0,387239486208,1,21102,1,338,0,1106,0,431,3,10,104,0,104,1,3,10,104,0,104,0,3,10,104,0,104,1,3,10,104,0,104,1,3,10,104,0,104,0,3,10,104,0,104,1,21102,3224472579,1,1,21101,0,385,0,1106,0,431,21101,0,206253952003,1,21102,396,1,0,1105,1,431,3,10,104,0,104,0,3,10,104,0,104,0,21102,709052072296,1,1,21102,419,1,0,1105,1,431,21102,1,709051962212,1,21102,430,1,0,1106,0,431,99,109,2,21202,-1,1,1,21102,1,40,2,21102,462,1,3,21102,452,1,0,1105,1,495,109,-2,2105,1,0,0,1,0,0,1,109,2,3,10,204,-1,1001,457,458,473,4,0,1001,457,1,457,108,4,457,10,1006,10,489,1101,0,0,457,109,-2,2105,1,0,0,109,4,2102,1,-1,494,1207,-3,0,10,1006,10,512,21101,0,0,-3,22101,0,-3,1,21202,-2,1,2,21102,1,1,3,21101,531,0,0,1105,1,536,109,-4,2106,0,0,109,5,1207,-3,1,10,1006,10,559,2207,-4,-2,10,1006,10,559,21202,-4,1,-4,1105,1,627,22102,1,-4,1,21201,-3,-1,2,21202,-2,2,3,21102,1,578,0,1105,1,536,21202,1,1,-4,21102,1,1,-1,2207,-4,-2,10,1006,10,597,21101,0,0,-1,22202,-2,-1,-2,2107,0,-3,10,1006,10,619,21201,-1,0,1,21102,1,619,0,106,0,494,21202,-2,-1,-2,22201,-4,-2,-4,109,-5,2106,0,0"

    
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
        ((0;1);{[x;i;y;z;p] (@[x;p;:;sum z];i+4;y)});
        //2 - multiply the args
        ((0;2);{[x;i;y;z;p] (@[x;p;:;prd z];i+4;y)});
        //3 - save input to postion
        ((0;3);{[x;i;y;z;p] (@[x;p;:;y];i+2;y)});
        //4 - output value as position
        ((0;4);{[x;i;y;z;p] (x;i+2;x p)});      
        //5 - jump func, no op
        ((0;5);{[x;i;y;z;p] (x;$[0<>z 0; z 1 ;i+3];y)});
        //6 - jump func, no op
        ((0;6);{[x;i;y;z;p] (x;$[0=z 0; z 1 ;i+3];y)});
        //7 - if arg[0]<arg[1] then store 1 in position otherwise 0
        ((0;7);{[x;i;y;z;p] (@[x;p;:;] $[z[0]<z[1];1;0];i+4;y)});
        //8 - if arg[0]=arg[1] then store 1
        ((0;8);{[x;i;y;z;p] (@[x;p;:;] $[z[0]=z[1];1;0];i+4;y)});
        //9 - modify the relative base
        ((0;9);{[x;i;y;z;p] .rel.base+:z 0;(x;i+2;y)})
        );
        /((0;9);{[x;i;y;z] .rel.base+:x i+1;(x;i+2;y)})

   
    //Dict for the number of args in each operation. Used to select argument set 
    opNumArgs:((0;1);(0;2);(0;3);(0;4);(0;5);(0;6);(0;7);(0;8);(0;9))!(4 4 2 2 4 4 4 4 2);
 
    opArgPostions:((0;1);(0;2);(0;3);(0;4);(0;5);(0;6);(0;7);(0;8);(0;9))!(1 2;1 2;0N;0N;1 2;1 2;1 2;1 2;1);
    opPositionPositions:((0;1);(0;2);(0;3);(0;4);(0;5);(0;6);(0;7);(0;8);(0;9))!(3 3 1 1 3 3 3 3 0N);
    
    //Mode of execution, positional vs immediate
    posIm:(0 1 2)!({x y};{y};{x .rel.base+y});
    
    posImSave:(0 1 2)!({x};{x};{.rel.base+x});
    
    //Func used to split mode from operation code
    opSplit:{-5#0 0 0 0,10 vs x};
    
    


intcode:{[x;i;userInputs];
    //Parse input, set initial values
    manualInput:userInputs;
    output:0;
    args:0;

    //Loop over opperations until 99 code for termination.
    while[not (9;9)~mode:-2#parameters:opSplit x i;
        
        //pick out args, if op doesn't use them it doesn't matter
        opSet:x i+til opNumArgs[mode];
        if[any not null p:opArgPostions[mode];
            args:(posIm  (count p)#reverse -2_parameters).' enlist[x],/: enlist each opSet p;
            ];
        if[not null p:opPositionPositions[mode];
            position:@[posImSave[(2_reverse parameters) p-1];opSet p];
            /show position;
            ];
      
        //Execute opperation, capture out
        out:.[op[mode];(x;i;manualInput;args;position)];
            x:out 0;
            i:out 1;
            output:out 2;
       
        //If we have an output, return full system state
        if[mode~(0;4);
            show opSet;
            if[1=(2_reverse parameters) p-1;
                output:x i-1;
                ];
            if[2=(2_reverse parameters) p-1;
                output:x (x i-1)+.rel.base;
                ];
            if[0=(2_reverse parameters) p-1;  
                output:x x i-1;
                ];
            /show output;
            :(x;i;output);
            ];

        /show x;
        ];
    :(`halt;output)
    };




//use day 7 - always on amp a
    intInput:"J"$"," vs input; 
    intInput:intInput,10000#`long$0;
    out:0;
    counter:0;
    state:intInput;
    iState:0;
    sqColour:1;
    .rel.base:0;
    moves:();
    colours:();
    position:0 0;    
    direction:0;
    sqColours:(`u#(0 0 ;0 1))!1 0 ;
    coord:(0 2 3 1)!(0 1;0 -1;-1 0;1 0);

    movement:(1 0)!({x+1};{x-1});
    colourTab:([]position:enlist 0 0;colour:1;turn:0);    

    /show setting;
    while[not `halt~first out:intcode[state;iState;0^sqColours position];
        //get colours
        state:out 0;
        iState:out 1;
        paint:out 2;
        /colours,:paint;
        

        sqColours[prevPos:position]:paint;
        //get moves
        out:intcode[state;iState;0^sqColours position];
        state:out 0;
        iState:out 1;
        turn:out 2;
        /moves,:turn;
    
        position+:coord direction:(movement[turn][direction mod 4] mod 4);
        /show position;
         `colourTab insert (enlist prevPos;paint;turn);

        show counter+:1;
        /draw colourTab;
        ];

    lastOut`e
    }    



.d11.p1:select count distinct position from colourTab


draw:{[colourTab]
    rebase:abs min each flip exec position from colourTab;
    maxSize:rebase+ max each flip exec position from colourTab;
    image::(maxSize[1]+1)#enlist (1+maxSize[0])#" ";
    colourTab:select position:position+\:rebase,colour from 1_colourTab;
    {.[`image;x;:;"#"]}each reverse each exec position where colour=1 from colourTab;
    -1 reverse each flip reverse each flip reverse each image;
    system"sleep 0.025";
    }

.d11.p2:draw each (1_til count colourTab)#\: colourTab;
