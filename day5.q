
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
