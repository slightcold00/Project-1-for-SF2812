sets
   i   destructarea    /Arboga, Fagersta, Ludvika, Nykoping/
   j   demandarea      /Eskilstuna, Falun, Gavle, Norrkoping, Stockholm, Uppsala, Vasteras, Orebro/;

table  dist(i,j)   the distance between the wood-floor producing sites and the destruction sites
         Eskilstuna Falun Gavle Norrkoping Stockholm Uppsala Vasteras Orebro 
Arboga         45   165   195     110       156       129      52      40 
Fagersta       95    88   126     187       176       117      66     103
Ludvika       137    63   150     220       222       163     112     112
Nykoping       82   260   257      59       106       168     128     135     ;

parameters
    dem(j)   demand
    /Eskilstuna        2000
     Falun             2000
     Gavle             4000
     Norrkoping        3000
     Stockholm         9000
     Uppsala           6000
     Vasteras          3000
     Orebro            2000 /;

parameters
    ca(i)     capacity
    /Arboga           7000
     Fagersta         8000
     Ludvika          9000
     Nykoping         8000/  ;

scalar c0 cost of transporting a kilo of the waste in kronors /1/;

scalar c1 cost of transporting a kilo of the waste over weight limit in kronors /1.4/;

scalar inc income of service a kilo of the waste in kronors /250/;

scalar dec cost of destructing a kilo of the waste in kronors /100/;

scalar upli the upper limit of weight without additional extra /1500/;


variables  x(i,j)      shipments
           z           totalprofit;

positive variable x;

equations
    satdem(j)    fullfillment of the waste to be handled
    capac(i)     donnot exceed capacities
    totalprofit     totalprofit;

satdem(j)  .. sum((i),x(i,j)) =g= dem(j);

capac(i)  .. sum((j),x(i,j)) =l= ca(i);

totalprofit  .. z =e= sum((i,j),x(i,j)*(inc-dec-dist(i,j)*c0))

model project1 /all/;

solve project1 using dnlp maximizing z;

display x.l, z.l;
