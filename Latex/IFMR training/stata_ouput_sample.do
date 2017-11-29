*****************************************
*** LaTeX Exercise - IFMR Summit 2015 ***
*****************************************

/* This do-file generates two sets of STATA output to be placed into our LaTeX 
 exercise file. */
 
	cd "C:\Users\Sakshi\Dropbox\IFMR Summit\"
	
	* Use pre-loaded STATA dataset on cross-country life expectancy
		sysuse lifeexp, clear
	
	* 1) Regression Example
	*-----------------------
		est clear
		eststo:reg popgrowth lexp gnppc 
		eststo:reg popgrowth lexp gnppc i.region
		esttab using latex_reg_sample.tex, replace title(Sample regression) mtitles("Without regional dummies" ///
			"Including regional dummies") p scalars(N F r2) star(* .10 ** .05 *** .01) ///
			addnote("This is a sample regression.")
			
	* 2) Data Matrix Example
	*------------------------
		gen region_dum = 0 
		replace region_dum = 1 if region == 1
		
			mat T = J(3,4,.)
			
		* GNP per capita
			ttest gnppc, by(region_dum)
			mat T[1,1] = r(mu_1)
			mat T[1,2] = r(mu_2)
			mat T[1,3] = r(mu_1) - r(mu_2)
			mat T[1,4] = r(p)
			
		* Life Expectancy	
			ttest lexp, by(region_dum)
			mat T[2,1] = r(mu_1)
			mat T[2,2] = r(mu_2)
			mat T[2,3] = r(mu_1) - r(mu_2)
			mat T[2,4] = r(p)
			
			* No. of observations
			mat T[3,1] = r(N_1)
			mat T[3,2] = r(N_2)
			 

		mat rownames T = "GNP per capita" "Life expectancy" "(n)"

		frmttable using mat_example.tex, statmat(T) tex varlabels replace ///
		ctitle("", N. and S. America, Europe and C. Asia, Difference, "(p-value)")
		
		
	* 3) Graph
	*----------
		twoway scatter lexp gnppc, title(Life Expectancy & GNP per capita)
		graph export lexp_gnp1.eps, replace		
