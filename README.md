# shiny-optimalclusters

## Guide to develop

```
# get the repository (if exist just do git pull)
git clone https://github.com/gungorbudak/shiny-optimalclusters.git

# edit app.R or create new scripts and refer to them

# make a config.R file and add TOKEN and SECRET variables
# as shown below
# ACCOUNT_NAME <- 'optimalclusters'
# APP_NAME <- 'home'
# TOKEN <- '<TOKEN from shinyapps.io>'
# SECRET <- '<SECRET from shinyapps.io>'

# deploy the modified app
Rscript deploy.R
```
