require('rsconnect')
source('config.R')
rsconnect::setAccountInfo(name='optimalclusters', token=TOKEN, secret=SECRET)
rsconnect::deployApp(getwd(), appName='home')
