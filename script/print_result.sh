# COLOURIZED TERMINAL OUTPUT
textreset=$(tput sgr0) # reset the foreground colour
red=$(tput setaf 1)
green=$(tput setaf 2)
yellow=$(tput setaf 3)

# print_result func
# params: message, status_code
# echo: OK message if status_code=0
print_result()
{
    if [ $2 -eq 0 ]; then 
        echo "$1... [ ${green}OK${textreset} ]"
    else
        echo "$1... [ ${red}FAILED${textreset} ]"
    fi
}