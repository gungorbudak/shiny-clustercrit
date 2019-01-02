source('config.R')
options(repos = BiocManager::repositories())
rsconnect::setAccountInfo(name=ACCOUNT_NAME, token=TOKEN, secret=SECRET)
rsconnect::deployApp(getwd(), appName=APP_NAME, account=ACCOUNT_NAME, forceUpdate=TRUE)
