********** Will Huntington-Whiteley Stata exam - 08/10/2021 **********

// 1. Preliminary steps
cd "C:\Users\willi\OneDrive\___ POSTGRAD\MSc Econ\Econometrics\StataExam"
	* set the working directory to the StataExam folder

dir "C:\Users\willi\OneDrive\___ POSTGRAD\MSc Econ\Econometrics\StataExam"
	* confirms that you are using the right folder

capture log close
log using "C:\Users\willi\OneDrive\___ POSTGRAD\MSc Econ\Econometrics\StataExam\will_whiteley.txt", text replace
	* create and open the log file
	
// 2. Load and inspect the data
use "C:\Users\willi\OneDrive\___ POSTGRAD\MSc Econ\Econometrics\StataExam\mrw1992-exam.dta"

su
br
	* summarising the dataset to see what the variables are, and browsing to get a first look at it 

* (2b)
br if cont == 1 		// to see the dataset for just the African countries
count if cont == 1		// shows that there are 40 African countries in the dataset

su igdp, detail 		// the variable we are interested in is labelled 'avg investment (as % of GDP)'
su igdp if cont == 1	// maximum value is 31.7
	*** the highest average investment rate in Africa was 31.7% of GDP

* (2c)
su gdp85, detail		// variable is labelled 'GDP per worker in 1985'. NOTE: this is not GDP, but there is no way to work this out with the data provided in this dataset

tab nonoil				// to see how many oil-exporting countries there are
help label
label list nonoil_lb 	// shows how the nonoil variable has been labelled. Oil exporters are labelled as 0

su gdp85
su gdp85 if nonoil == 0

list if gdp85 == 25635
	*** The highest GDP in 1985 for oil-exporting countries is in Kuwait, with 25,632 per capita
	
* (2d)
scatter gdp85 gdp60
	* does not look very nice, so will convert into log variables
gen lngdp85 = ln(gdp85)
gen lngdp60 = ln(gdp60)

scatter lngdp85 lngdp60

save "Scatter of GDP in 1985 against GDP in 1960.pdf", replace

	
// 3. Regression analysis
* (3a)
tab school
drop if school < 3

* (3b)
*** Have done this above in part 2d, so they already exist within the dataset

* (3c)
reg igdp lngdp60		// by default regression is done with a constant

* (3d)
*** Coefficient on lngdp60 is = 3.0659 (4dp). This means that for each % increase in GDP in 1960 there is a 3% higher average investment as a proportion of GDP for that observation

* (3e)
*** The H0 says that this coefficient is equal to zero (i.e. gdp in 1960 has no association with average investment). The p-stat of 0.001 says that this is very unlikely, and that we would reject this H0 even at the 1% significance level

* (3f)
*** reported R^2 is the goodness of fit of the model, and it says that this X variable explains 14.7% of the variation in the y-variable (which here is average investment)


// 4. Mata
clear mata 					// to ensure there is no leftover matrices

gen one = 1					// to give a vector of 1's

putmata igdp lngdp60 one
	
mata

y = igdp
X = lngdp60
a = one
***** Ran out of time

end

// 5. Final steps and submission

log close
