//Format of solution to be tested
// - Data is only accessible as read0 `:d1.txt, d2.txt, d3.txt etc from local directory
// - Data may only be loaded outside the functions. Sanitisation and parsing must be done within
// - Functions should be in the .d*day* namespace and function p*part* (.e.g. .d1.p1)
// - Function should take no args

//Using the test script
// - The script executes in same directory as the data `d1.txt
// - Solutions are in folder day1 etc
// - Solutions should be named person.q

//Execution
// 	testDay[day;p1Loops;p2Loops]
// 	- day - int - day of advent
//  - p1Loops - number of times to test part 1 over
//  - p2Loops - number of times to test part 2 over

//Output
// - Will print the outputs of each persons solution (to verify correct)
// - Will return table of results, with execution time, memory usage, and percentage of speed of the fastest

/Name  status  speedP1      memP1  speedP2      memP2   p1ratio p2ratio
/----------------------------------------------------------------------
/Bill Success 00:00:00.608 2,624  00:00:00.624 676,960 100     100
/Bob  Success 00:00:00.994 10,624 00:00:00.796 781,264 61.2    78.4

intFormat:{reverse "," sv 3 cut reverse string x}

\P 3

testDay:{[day;p1Loops;p2Loops]
	.p1.loops:p1Loops;
	.p2.loops:p2Loops;
  
	toRun:f where (f:key `$":day",string[day]) like "*.q";
  
	.results.tab:([]Name:`$();status:`$();speedP1:`time$();memP1:`$();speedP2:`time$();memP2:`$());
	.output.tab:([]Name:`$();p1:();p2:());
  
	benchmarkSolution[day;] each toRun;
  
	.results.tab:`p1ratio xdesc update p1ratio:100*(min speedP1)%speedP1,p2ratio:100*(min speedP2)%speedP2 from .results.tab;
	
  show .output.tab;
	.results.tab
	};
  
benchmarkSolution:{[day;file]
	.p1.exErr:.p2.exErr:0b;
  
	name:`$first "." vs string file;
	loadOut:@[system;"l day",string[day],"/",string file;{"LoadError - ",x}];
  
	//If loading file failed then return failure
	if[1<count loadOut;
		`.results.tab upsert (name;`$loadOut;`time$0;`$"fail";`time$0;`$"fail");
		:()
		];
    
	show"running part one for ",string name;
	p1:@[system;"ts:",string[.p1.loops]," .p1.result:.d",string[day],".p1[]";{.p1.exErr:1b;(`time$0;`$"fail")}];
  
	show"running part two for ",string name;
	p2:@[system;"ts:",string[.p2.loops]," .p2.result:.d",string[day],".p2[]";{.p2.exErr:1b;(`time$0;`$"fail")}];
	
  status:$[.p1.exErr;
			`$"Error part 1";
			.p2.exErr;
			`$"Error part 2";
			`Success
			];
      
	if[status=`Success;
		`.output.tab upsert (name;-3!.p1.result;-3!.p2.result);
		];
    
	`.results.tab upsert (name;status;`time$p1 0;`$intFormat p1 1;`time$p2 0;`$intFormat p2 1)
	};
