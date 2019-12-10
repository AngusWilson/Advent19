.d5.p1:.d5.p2:{  
    //Parse input, set initial values
    x:"I"$"," vs input;
    i:0;
    manualInput:5;
    output:0;
    args:0;
    
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
        ];
    
    output
    };
