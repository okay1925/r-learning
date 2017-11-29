
**eststo learning**
/*http://repec.org/bocode/e/estout/eststo.html */

sysuse auto

quietly reg price weight mpg
eststo model1
quietly reg price weight mpg foreign
eststo model2
estimate tabel model1 model2
eststo clear

*you dont have to [name] the eststo
quietly reg price weight mpg
eststo 
quietly reg price weight mpg foreign
eststo 
esttab
eststo clear

*can use a function after eststo
eststo: reg price weight mpg
esttab
eststo clear

*if we want to use (by) feature with eststo
by(foreign): eststo: quietly reg price weight mpg
esttab, label nodepvar nonumbers /*gives a clean table compared to a pure 'esttab'*/
eststo clear





