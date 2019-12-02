input:"I"$"," vs first read0 `:d2.txt;

//Loop over until 99 is seen
//iterate positional each loop
//functional apply change
//Takes [x;y;z] of (input;noun;verb)
d2p1:{
	x[1]:y;
	x[2]:z;
	op:(1;2)!(sum;prd);
	i:-4;
	
	while[not 99=x i+:4;
		x:@[x;x i+3;:;op[x i] x x i+1 2];
		];
	first x
	};

//Brute force solution, try all combinations of 0-100 and check if it matches desired output
//Takes x (input)
d2p2:{
	vals:d2p1[x;;] ./:combo:raze (til 100),/:\:til 100;
	
	pair:combo first where vals=19690720;
	pair[1]+100*pair[0]
	}




