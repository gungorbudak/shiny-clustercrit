require('rsconnect')
source('config.R')
rsconnect::setAccountInfo(name='clustercrit', token=TOKEN, secret=SECRET)
rsconnect::deployApp(getwd(), appName='home')
