



findit sjlatex
/*install latex into stata*/

sjlatex install using "C:\Users\Pratibha Joshi\Documents\Latex\tex\latex\sjlatex"


sysuse cancer, clear


la var stime "To died or exp. end"

recode studytime (min/10 = 1 "10 or less months") (11/20 = 2 "11 to 20 months") (21/30 = 3 "21 to 30 months")(31/max = 4 "31 or more months"), gen(stime)


tabout stime died using table1.txt, cells(freq col cum) format(0 1) clab(No. Col_% Cum_%) replace 
style(tex) bt cl1(2-10) cl2(2-4 5-7 8-10) font(bold) topf(top.tex) botf(bot.tex) topstr(14cm) botstr(cancer.dta)


***second possible***
use http://www.ats.ucla.edu/stat/stata/notes/hsb2
sjlog using desc_hsb2
describe
sjlog close
sjlog type desc_hsb2.log.tex

/*this has created the tex files at: C:\Users\Pratibha Joshi\Documents\Latex\tex\latex\sjlatex*/

/*http://www.ats.ucla.edu/stat/stata/latex/list_variables.htm*/
list write read math ses if female ==0 & prog ==1


#delimit ;
listtex write read math ses if female ==0 & prog ==1 using list1.tex,
rstyle(tabular) head("\begin{tabular}{rrrr}""
\textit{Write} &\textit{Read}&\textit{Math}&\textit{Ses}\\\\")
foot("\end{tabular}");
#delimit cr
/*we can find the list1.tex file at C:\Users\Pratibha Joshi\Documents\Latex\tex\latex\sjlatex*/

#delimit;
listtex write read math ses if female ==0 & prog ==1 ,
type rstyle(tabular)
head("\begin{tabular}{rrrr}""\textit{Write}
&\textit{Read}&\textit{Math}&\textit{Ses}\\\\")
foot("\end{tabular}");
#delimit cr
/*this option does not create a tex file*/

*YET TO FIGURE HOW TO GET THE LATEX TO A PDF OUTPUT

*findit latabstat 

tabstat math write read, by(female)
latabstat math write read, by(female)

latabstat math write read, by(female) cap(Scores by Gender)
/*still not getting how the Latex code is created, and nor how to create a PDF*/



