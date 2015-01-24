This is the README file for the programming assignment Week 3, Data Cleaning

The script reads the different data files available and combines them into a single table
It selects the columns which contain the term mean or std in front of ()
It uses an efficient way of creating the mean() of each column by using .SD:
.SD is a data.table containing the Subset of x’s Data for each group, excluding
any columns used in by (or keyby)

Reference:
http://cran.r-project.org/web/packages/data.table/data.table.pdf
