sets
   i   plant    /Arboga, Fagersta, Ludvika, Nykoping/
   j   factory      /Eskilstuna, Falun, Gavle, Norrkoping, Stockholm, Uppsala, Vasteras, Orebro/;

table  dist(i,j)   distance in kilometers from factory j to plant i
         Eskilstuna Falun Gavle Norrkoping Stockholm Uppsala Vasteras Orebro 
Arboga         45   165   195     110       156       129      52      40 
Fagersta       95    88   126     187       176       117      66     103
Ludvika       137    63   150     220       222       163     112     112
Nykoping       82   260   257      59       106       168     128     135     ;

parameters
    dem(j)   demand of factory j in kilos
    /Eskilstuna        2000
     Falun             2000
     Gavle             4000
     Norrkoping        3000
     Stockholm         9000
     Uppsala           6000
     Vasteras          3000
     Orebro            2000 /;

parameters
    ca(i)     destruction capacity of plant i in kilos
    /Arboga           7000
     Fagersta         8000
     Ludvika          9000
     Nykoping         8000/  ;

scalar c0 original transportation cost per kilo per kilometer in kr /1/;

scalar c1 increased transportation cost per kilo per kilometer in kr /1.4/;

scalar inc income of service a kilo of the waste in kronors /250/;

scalar dec cost of destructing a kilo of the waste in kronors /100/;



variables  x(i,j)      kilos of waste transported from factory j to plant i that less than uper limit
           e(i,j)      overparts of waste transported from factory j to plant i
           z           totalprofit;
           
x.up(i,j) = 1500; 
x.lo(i,j) = 0;

positive variable            e(i,j);

equations
    satdem(j)    fullfillment of the waste to be handled
    capac(i)     donnot exceed capacities
    totalprofit     totalprofit;

satdem(j)  .. sum((i),x(i,j)+e(i,j)) =e= dem(j);

capac(i)  .. sum((j),x(i,j)+e(i,j)) =l= ca(i);

totalprofit  .. z =e= sum((i,j),(x(i,j)+e(i,j))*(inc-dec)-dist(i,j)*(c0*x(i,j)+c1*e(i,j)));



model project1 /all/;

solve project1 using lp maximizing z;

display x.l,e.l,z.l;



