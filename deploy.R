require('rsconnect')
source('config.R')
rsconnect::setAccountInfo(name=ACCOUNT_NAME, token=TOKEN, secret=SECRET)
rsconnect::deployApp(getwd(), appName=APP_NAME, account=ACCOUNT_NAME)
