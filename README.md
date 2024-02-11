# samefile.ado
`samefile` is a command to check whether two files (png, pdf, tex, txt,...) are identical based on their hashes.
Module uses Python's `hashlib` module.

## Example 
```stata
samefile, f1("C:/figure1.pdf") f2("C:/figure1_new.pdf")
```

## Installation
To install from Github, type:

```stata
net install samefile, from("https://raw.githubusercontent.com/jvali1/stata-samefile/master/") replace
```

For questions and suggestions, please contact:  
Jean-Victor Alipour  
LMU Munich & ifo Institute  
alipour@ifo.de 
