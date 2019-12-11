.d10.p1:{
    asPos::raze (til count input),/:' where each "#"=input;

    max {count distinct rel%' max each rel:x-/:asPos} each asPos
    }

.d10.p2:{
    asPos::raze (where each "#"=input),\:'(til count input);
    stationCoords:first asPos where los=max los:{count distinct rel%' max each rel:x-/:asPos} each asPos; 
    rel:asPos-\:stationCoords;

    //Calculate  polar coord angle (1.570796 is pi/2)
    t:([]angle:({atan[abs[y]%abs[x]]})./: rel;relative:rel);
    modDict:(1 1i;-1 1i;-1 -1i;1 -1i)!({x};{(2*1.570796)-x};{(2*1.570796)+x};({neg[x]+1.570796*4}));
    nullModDict:(1 0i;0 1i;-1 0i;0 -1i)!(0;1.570796;1.570796*2;3*1.570796);
   
    t:`angle xasc update angle:(modDict signum relative)@'angle from t;
    t:update angle:`float$ nullModDict `int$0^`int$ relative%'abs first each {x where x<>0}each  relative from t where 0 in/: relative;
    t:0!1_`angle xgroup `angle xasc t;
    
    //adjust for lazer starting at 270
    t:`angle xasc update angle: angle+1.570796*4 from t where angle<3*1.570796;

    stationCoords+first (t 199)`relative
    }
    
    
    

input:("#.#....#.#......#.....#......####.";
    "#....#....##...#..#..##....#.##..#";
    "#.#..#....#..#....##...###......##";
    "...........##..##..##.####.#......";
    "...##..##....##.#.....#.##....#..#";
    "..##.....#..#.......#.#.........##";
    "...###..##.###.#..................";
    ".##...###.#.#.......#.#...##..#.#.";
    "...#...##....#....##.#.....#...#.#";
    "..##........#.#...#..#...##...##..";
    "..#.##.......#..#......#.....##..#";
    "....###..#..#...###...#.###...#.##";
    "..#........#....#.....##.....#.#.#";
    "...#....#.....#..#...###........#.";
    ".##...#........#.#...#...##.......";
    ".#....#.#.#.#.....#...........#...";
    ".......###.##...#..#.#....#..##..#";
    "#..#..###.#.......##....##.#..#...";
    "..##...#.#.#........##..#..#.#..#.";
    ".#.##..#.......#.#.#.........##.##";
    "...#.#.....#.#....###.#.........#.";
    ".#..#.##...#......#......#..##....";
    ".##....#.#......##...#....#.##..#.";
    "#..#..#..#...........#......##...#";
    "#....##...#......#.###.#..#.#...#.";
    "#......#.#.#.#....###..##.##...##.";
    "......#.......#.#.#.#...#...##....";
    "....##..#.....#.......#....#...#..";
    ".#........#....#...#.#..#....#....";
    ".#.##.##..##.#.#####..........##..";
    "..####...##.#.....##.............#";
    "....##......#.#..#....###....##...";
    "......#..#.#####.#................";
    ".#....#.#..#.###....##.......##.#.")
    
    
    .d10.p1[]
    .d10.p2[]



//A little bit of code to play about with to animate the lazer
/full:update absolute:relative+\:\:stationCoords from t

/`list set reverse each exec absolute from full


/`stationCoords set stationCoords


/vis:{
/    .aoc.image:.[ssr[;".";" "]each input ;reverse stationCoords;:;"0"]
/    {
/        show .aoc.image:.[.aoc.image;reverse x;:;"X"];
/        .aoc.image::.[.aoc.image;reverse x;:;" "];
/        system"sleep 0.05";
/        } each (raze flip list[;til max count each list ]) except enlist `long$();
/    }

/vis[]
