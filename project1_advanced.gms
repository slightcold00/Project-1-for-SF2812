sets
   i   plant    /Arboga, Fagersta, Ludvika, Nykoping/
   j   factory       /Eskilstuna, Falun, Gavle, Norrkoping, Stockholm, Uppsala, Vasteras, Orebro/;

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

scalar exc additional cost in excess of the nominal capacities in kr /100/;



variables  x(i,j)      waste lighter than upper limit
           e(i,j)      overparts of waste transported from factory j to plant i
           ex(i)       waste beyond destruction capacity
           z           totalprofit;
           
x.up(i,j) = 1500; 
x.lo(i,j) = 0;

positive variable            e,ex;

equations
    satdem(j)    fullfillment of the waste to be handled
    capac(i)     donnot exceed capacities
    totalprofit     totalprofit;

satdem(j)  .. sum(i,x(i,j)+e(i,j)) =g= dem(j);

capac(i)  .. sum(j,x(i,j)+e(i,j)) =l= ca(i)+ex(i);

totalprofit  .. z =e= sum(j,dem(j))*(inc-dec)-sum((i,j),dist(i,j)*(c0*x(i,j)+c1*e(i,j)))-exc*sum(i,ex(i));



model project1_1 /all/;

file emp / '%emp.info%' /; put emp '* problem %gams.i%'/;
$onput
randvar dem('Eskilstuna') normal 2000 50
randvar dem('Falun') normal 2000 50
randvar dem('Gavle') normal 4000 50
randvar dem('Norrkoping') normal 3000 50
randvar dem('Stockholm') normal 9000 50
randvar dem('Uppsala') normal 6000 50
randvar dem('Vasteras') normal 3000 50
randvar dem('Orebro') normal 2000 50
stage 2 dem e ex
stage 2 satdem capac
$offput
putclose emp;

Set scen      scenarios / s1*s100 /;

Parameter
 s_dem(scen,j) demand realization by scenario
 s_e(scen,i,j) extra shipment per scenario
 s_s(scen) scenarios
 s_ex(scen,i) extra waste to destruction per scenario;

Set dict / scen .scenario.''
 dem .randvar .s_dem
 e .level .s_e
 ex .level .s_ex/;

Option emp = lindo

Solve project1_1 using emp maximizing z scenario dict;

Display s_dem,s_e,s_ex,x.l,z.l;


