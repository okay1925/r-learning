**learning frmttable**
**help frmttable** 

matrix A = (100, 50\0, 50)
matrix list A /*lists the values of Mat A in their correct Row and Col positions*/

/*another way to list the matrix A*/
frmttable, statmat(A)

/*now the real use - by figuring out how to output table into Word*/
frmttable using xmp15, statmat(A) sdec(0) title("Payoffs") ctitle("", "Game 1", "Game 2") ///
rtitle("Player1"\"Player2")

matrix B = (25\75)	
frmttable, statmat(B) sdec(0) ctitle("","Game 3") rtitle("Player1" \"Player3") merge


matrix C= (90\10)
frmttable, statmat(C) sdec(0) ctitle("","Game 4") rtitle("Player2"\"Player4") merge

matrix D = (100, 100, 100, 100) 
frmttable, statmat(D) sdec(0) rtitle("Total") append        

*Can use addrows or addcols 



***svret in long form****DONT WASTE TIME ON THIS***
sysuse auto
summ price
return list

svret, long format(%8.2fc)/*it seems that it requires 'clear all' and 'sysuse auto' each time!*/
list
*export?

***svret in wide form***
sysuse auto
summ price
svret, all
*this is such a shit command*

 
regsave


**learning regsave, and svret**
