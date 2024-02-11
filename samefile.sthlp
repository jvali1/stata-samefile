{smcl}
{* 11feb2024}
{title: Title}

{p 4 8}{cmd:samefile} - Stata module to check whether two files (txt, png, pdf, tex, ...) are identical based on their hashes. Uses Pythons hashlib module.

{p 8 17 2}
{cmd:samefile}
{cmd:,} {opt f1}{cmd:(}file_path{cmd:)} [{opt f2}{cmd:(}file_path{cmd:)} {opt graphexport} ]

{title: Description}

{p 4 8}{cmd:samefile} is a command to check if two files specified in f1() and f2() are identical. This is helpful if you want to make sure that tables or figures have not changed.


{synoptset 22 tabbed}{...}
{synopthdr}
{synoptline}

{synopt:{opt graphexport}} assumes f1() specifies an existing figure and checks whether graph in memory is identical that saved figure.


{title:Author}

{p 4}Jean-Victor Alipour{p_end}
{p 4}LMU Munich & ifo Institute{p_end}
{p 4}{browse "https://sites.google.com/view/jv-alipour/"}{p_end}
