input:read0 `:d6.txt


//Create dict of key orbiting value
orbitMap:{(!) . reverse flip  `$")" vs/: input}


//Run over with (current number of orbits;bodies that still are orbiting something else
//Drop of `COM at top of list highlighting reached end of chain
//Sum up count of bodies still left
.d6.p1:{`orbits set orbitMap[];
	  first ({(x[0]+count n;n:(orbits x 1) except `COM)}/) (count key orbits;key orbits)
    }


//Generate orbit trees with scan repeated lookup in orbits dict
//inter lists for first commonality 
//lookup position in each list and sum
//-2 to account for empty keys at end of orbTrees
.d6.p2:{
    orbTrees:({orbits x}\)each `YOU`SAN;
    -2+sum {x?y}[;first (inter) . orbTrees] each orbTrees
    }
