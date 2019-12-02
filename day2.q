//Day 2 - not particularly elegant solution for so early on. 

//Load file, set the noun and verb
init:{
	input:"I"$"," vs first read0 `:d2.txt;
	.aoc.flat:input;
	.aoc.flat[1]:x;
	.aoc.flat[2]:y;
	};

//Function that will be looped.
//r is current working set to opperate
//conditionals for modifying overall "flat" list
//return true for continue, false exit
f:{
	r:4#(.aoc.current+:4)_.aoc.flat;
	if[1=first r;
		@[`.aoc.flat;last r;:;sum .aoc.flat[r[1 2]]];
		:1b;
	];
	if[2=first r;		
		@[`.aoc.flat;last r;:;prd .aoc.flat[r[1 2]]];
		:1b;
	];
	if[99=first r;
		:0b;
	];	
	};

//run f on while loop as conditional so will terminate when 99 is hit
d1p1:{
	init[12;2];
	.aoc.current:-4;
	while[f[];()];
	first .aoc.flat

	};

//Brute force solution, try all combinations of 0-100 and check if it matches desired output
d2p2:{
	vals:{show (x;y);
		init[x;y];
		.aoc.current:-4;
		while[f[];()];
		first .aoc.flat
		}./:combo:raze (til 100),/:\:til 100;

	pair:combo first where vals=19690720;
	pair[1]+100*pair[0]
	};


