input:"I"$read0 `:d1.txt;

d1p1:{sum(floor[x]%3)-2}

//An over with input pair of (total,current state)
//iterates over the state until the total no longer changes and the current state remains the same (converge)
//calculates the fuel from p1, excludes any that have dropped below 9, as these will be 0 or less next iteration
d1p2:{first({(sum[m]+x 0;m where 8<m:floor[x[1]%3]-2)}/)(0;x)}
