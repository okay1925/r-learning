
***learning estpost***

sysuse auto, clear

estpost sum price mpg rep78 foreign

esttab, cells("mean sd count") noobs


estpost tab price mpg rep78, by(foreign)
