# --------------------------------------------------------------
# in R
file = "./PSL/script.R"
fmt = "Rscript %s"
command <- sprintf(fmt, file)
system(command, intern = TRUE)

# --------------------------------------------------------------
# in Powershell
file = "./PSL/script.ps1"
fmt = "powershell -ExecutionPolicy Bypass -File %s"
command <- sprintf(fmt, file)
system(command, intern = TRUE)

# --------------------------------------------------------------
# in Python
file = "./PSL/script.py"
fmt = "python %s"
command <- sprintf(fmt, file)
system(command, intern = TRUE)
