//test case 1
input:("<x=-1, y=0, z=2>";
    "<x=2, y=-10, z=-7>";
    "<x=4, y=-8, z=8>";
    "<x=3, y=5, z=-1>")

//test case 2
input:("<x=-8, y=-10, z=0>";
    "<x=5, y=5, z=10>";
    "<x=2, y=-7, z=3>";
    "<x=9, y=-8, z=-3>")

//my input
input:("<x=0, y=4, z=0>";
    "<x=-10, y=-6, z=-14>";
    "<x=9, y=-16, z=-3>";
    "<x=6, y=-1, z=2>")




moons:`Io`Europa`Ganymede`Callisto

//Func to return velocity changes given a set of positions in one axis
velAdjust:{
    {neg sum sum each 1_/:(x[0]>x;neg x[0]<x)
        } each rotate[;x]each r:til count x
    }

//Given tab of positions and current velocities, calculate new velocities and positions - append to table
stepState:{[tab]
    workingSet:select from tab where step=max step;
    workingSet:update step:step+1,xVel:xVel+velAdjust xPos,yVel:yVel+velAdjust yPos,zVel:zVel+velAdjust zPos from workingSet;
    tab upsert update xPos:xPos+xVel,yPos:yPos+yVel,zPos:zPos+zVel from workingSet
    }

.d12.p1:{
    //Initialise state table
    pos:"I"$3_/:/:"," vs/: -1_/: input;
    tab:flip update step:0 from `moon`xPos`yPos`zPos`xVel`yVel`zVel!flip (moons,'pos),\:0 0 0;
    
    //loop 1000 times to find new state
    do[1000;tab:stepState tab];

    //Calculate energy
    tab:update energy:(sum abs (xPos;yPos;zPos))*sum abs (xVel;yVel;zVel) from tab ;
    select sum energy from tab where step=1000
    }


.d12.p2:{

        //Opperate on one axis at a time, continually run velAdjust until we hit initial state
       numRepeats:{
            i:0;
            pos:"I"$3_/:/:"," vs/: -1_/: input;
            tab:flip update step:0 from `moon`xPos`yPos`zPos`xVel`yVel`zVel!flip (moons,'pos),\:0 0 0;
            
            start:new:0 0 0 0i,tab x;
            v:4#new;
            new:v,p+v+:velAdjust p:4_new;
          
            while[not new~start;
                new:v,p+v+:velAdjust p:4_new;  
                i+:1;
                ];
            1+i

            };
    
    //Run for each axis to see period of hitting intial state
    //every n steps the state will be initial for each, so need to find where all are together
    n:asc numRepeats each `xPos`yPos`zPos;

    //Given two numbers, find minimum number that is divisble by both
    commonFactor:{
            m:1;
            while[0<>(l:x*m) mod y;
                m+:1;
                ];
            l
            };
   //Find common factor of largest and smallest, then common factor of that and the remaining number
   //- gives first total state that matches initia;
   c:commonFactor[n 2;n 0];
   commonFactor[c; n 1]
   }
