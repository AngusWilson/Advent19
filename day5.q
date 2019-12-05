
.d5.p1:{
    x:"I"$"," vs input;
    
    opSplit:{-5#0 0 0 0,10 vs x};   
    //Each opperation takes:
    //x - full list
    //i - index of operation
    //y - input
    //z - arguments for opperation
    //
    //Returns
    //(new list;new index;output)
    
	op:(!) . flip (
        //1 - sum the args
        ((0;1);{[x;i;y;z] @[x;x i+3;:;sum z]});
        //2 - multiply the args
        ((0;2);{[x;i;y;z] @[x;x i+3;:;prd z]});
        //3 - save input to postion
        ((0;3);{[x;i;y;z] @[x;x i+1;:;y]});
        //4 - output value as position
        ((0;4);{[x;i;y;z] x x i+1})
        );
    
    opNumArgs:((0;1);(0;2);(0;3);(0;4))!(4 4 2 2);
    
    posIm:(0 1)!({x y};{y});
	i:0;
	manualInput:1;
    output:0;
    args:0;
    
	while[not (9;9)~mode:-2#parameters:opSplit x i;

        //if it's 1/2 lookup based on mode type        
        if[mode in ((0;1);(0;2));
            opSet:x i+til opNumArgs[mode];
            args:(posIm -1_ reverse -2_parameters).' enlist[x],/: enlist each opSet 1 2;
 
            ];
	    out:.[op[mode];(x;i;manualInput;args)];
		
        $[mode in ((0;1);(0;2);(0;3));
            x:out;
            output:out
            ];
        
        i+:opNumArgs[mode];
        ];
	output
	};
	
	
	
	
	
	
	
.d5.p2:{
     
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
    //Overall list, or output, function dependent
	op:(!) . flip (
        //1 - sum the args
        ((0;1);{[x;i;y;z] @[x;x i+3;:;sum z]});
        //2 - multiply the args
        ((0;2);{[x;i;y;z] @[x;x i+3;:;prd z]});
        //3 - save input to postion
        ((0;3);{[x;i;y;z] @[x;x i+1;:;y]});
        //4 - output value as position
        ((0;4);{[x;i;y;z] x x i+1});      
        //5 - jump func, no op
        ((0;5);{[x;i;y;z] x});
        //6 - jump func, no op
        ((0;6);{[x;i;y;z] x});
        //7 - if arg[0]<arg[1] then store 1 in position otherwise 0
        ((0;7);{[x;i;y;z] @[x;x i+3;:;] $[z[0]<z[1];1;0]});
        //8 - if arg[0]=arg[1] then store 1
        ((0;8);{[x;i;y;z] @[x;x i+3;:;] $[z[0]=z[1];1;0]})
        );

    //operation step dictionary To account for the jump functions 
    //Keep args same as above ops dict for ease of execution
    opStep:(!) . flip (
         //1 - normal
        ((0;1);{[x;i;y;z] i+4});
        //2 - normal
        ((0;2);{[x;i;y;z] i+4});
        //3 - normal
        ((0;3);{[x;i;y;z] i+2});
        //4 - normal 
        ((0;4);{[x;i;y;z] i+2});     
        //5 - jump
        ((0;5);{[x;i;y;z] $[0<>z 0; z 1 ;i+3]});
        //6 - jump
        ((0;6);{[x;i;y;z] $[0=z 0; z 1 ;i+3]});
        //7 - jump
        ((0;7);{[x;i;y;z] i+4});
        //8 - if arg[0]=arg[1] then store 1
        ((0;8);{[x;i;y;z] i+4})
        );
    
    //Dict for the number of args in each operation. Used to select argument set 
    opNumArgs:((0;1);(0;2);(0;3);(0;4);(0;5);(0;6);(0;7);(0;8))!(4 4 2 2 4 4 4 4);
 
    //Mode of execution, positional vs immediate
    posIm:(0 1)!({x y};{y});
    
    //Func used to split mode from operation code
    opSplit:{-5#0 0 0 0,10 vs x};
    
    
    //Loop over opperations until 99 code for termination.
	while[not (9;9)~mode:-2#parameters:opSplit x i;
        //If in set that requres arguments, get args.
        if[mode in ((0;1);(0;2);(0;5);(0;6);(0;7);(0;8));
            opSet:x i+til opNumArgs[mode];
            args:(posIm -1_ reverse -2_parameters).' enlist[x],/: enlist each opSet 1 2;
            ];
        
        //Execute opperation, capture out
	    out:.[op[mode];(x;i;manualInput;args)];

        
        //Assign the out to either new overall list, or output
        $[mode in ((0;1);(0;2);(0;3);(0;5);(0;6);(0;7);(0;8));
            x:out;
            output:out
            ];
        
        //Increment pointer by required set (account for jump functions)    
        i:.[opStep[mode];(x;i;manualInput;args)];
        
        ];
    
	output
	};
	
	
	
	
	
	
