# Adda (আড্ডা)
An iOS wireframe app that lists available meeting spaces in an organisation for the next hour
This app assumes that you work in an organisation that uses outlook 365. 

# Setup
1. Sign into the [App Registration Portal](https://apps.dev.microsoft.com/) using either your personal or work or school account.
2. Select Add an app.
3. Enter a name for the app, and select Create application.The registration page displays, listing the properties of your app.
4. Under Platforms, select Add platform.Select Native platform.
6. Copy the Client Id to the clipboard. You'll need to enter this value into the sample app.The app id is a unique identifier for your app.
7. Select Save.

# Configuration

Use the application client id & redirect URI from the app registration portal in OutlookService.swift. For the redirect URI, the app name refers to the name of your app from the app registration portal.

~~~~
"client_id" : "{YOUR_APP_CLIENT_ID}"
"redirect_uris": ["{YOUR_APP_NAME}://oauth2/callback"]
~~~~
