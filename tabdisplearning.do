
**learning tabdisp**
**19 June 2017**


**EXAMPLE 1**
sysuse auto2, clear
sort make

*both these commands if the same result
tabdisp make in 1/10 if mpg, c(mpg weight displ rep78) /*hence not the preferred code*/
tabdisp make in 1/10, c(mpg weight displ rep78)
*these commands give the first 10 listings after sorting on 'make'


*table with 'foreign' as row heading, and 'rep78' as column heading, and putting value of 'mpg' for the table
tabdisp foreign rep78, c(mpg)

*to align on center
tabdisp foreign rep78, c(mpg) center

*to get results in a format with 2 decimals
tabdisp foreign rep78, cell(mpg) format(%9.2f) center


sysuse auto, clear /*this is a slightly different dataset from above 'auto2'*/
*to get an ordered list
bysort foreign (nmpg) : gen order = _n 
by foreign: tabdisp order if order <= 10, c(make mpg) 
/*https://www.stata.com/statalist/archive/2002-08/msg00177.html#*/





**EXAMPLE 2**
webuse tabdxmpl3, clear

*three variations will demo how the order of var after tabdisp affects the way table is formed
tabdisp party, c(sex reaction) /*not any useful or corect info*/
tabdisp party sex, c(reaction) /*not any useful or corect info*/

tabdisp agecat sex party, c(reation) center /*'center' allows for neater appearance*/

tabdisp agecat sex party, c(reaction) missing /*'missing' shows the missing values*/


**EXAMPLE 3**
webuse  tabdxmpl5, clear
tabdisp sex response, c(pop) missing /*'missing' shows the missing values*/

tabdisp sex response, c(pop) total /*this gives the same result as the next command, only includes a 'total' for relevant line*/
tabdisp sex response, c(pop)


