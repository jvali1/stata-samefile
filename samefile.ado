*! version 1.0.0 Jean-Victor Alipour, 02/2024

cap program drop samefile 
program samefile

syntax, f1(string) [f2(string)] [graphexport]

	/*
		
		* Calls python to check if 2 files (pdf, tex, txt, png, ...) are identical using hashing (hashlib)
		returns error if not the case
		
		* graphexport: assumes f1 is path to an existing figure and checks
			graph in memory against that figure
	*/
	
	// file1 must exist 
	confirm file "`f1'"
	
	// if file2 specified ignore graphexport
	if "`f2'"!="" {
		confirm file "`f2'"
		local graphexport =""
	}
	else {
		cap assert "`graphexport'"!=""
		if _rc {
			di as error "Specify second file or graphexport."
			exit(9)
		}
	}
	
	// if graphexport specified save graph in memory and set f2=testgraph.xxx
	if "`graphexport'"!="" {
		
		// extract file type 
		local typ = substr("`f1'",strrpos("`f1'","."),.)
		qui graph export "testgraph`typ'", replace
		
		local f2="testgraph`typ'"
	}
	
	// check if identical using python => returns r(res) = 1 or 0
	sspython, ff1("`f1'") ff2("`f2'")	

	// erase testgraph.xxx 
	cap erase "testgraph`typ'"
	
	// report result
	if `r(res)'==1 {
		di as text "Files are identical."
	}
	else {
		di as err "Files are different."
		exit(1)
	}
	
end 	


* program: takes files as input and calls python programs
*	returns local r(res): 1= identical; 0= different
cap program drop sspython
program sspython

	syntax, ff1(string) ff2(string)

	python: import hashlib
	python: from difflib import SequenceMatcher
	python: from sfi import Data, Scalar
    	python: result = compare_files("`ff1'", "`ff2'")
	python: Scalar.setValue("r(res)", result) // pass value to stata (stores in r(res))

end 

* define python functions to create hashes of files and compare them
python:
import hashlib

def hashfile(fileName):
    h = hashlib.sha1()
    with open(fileName, "rb") as file:
        k= 0
        while k!= b'':
            k= file.read(1024)
            h.update(k)
    return h.hexdigest()

def compare_files(file1, file2):
    hash1 = hashfile(file1)
    hash2 = hashfile(file2)
    return 1 if hash1 == hash2 else 0
end 





