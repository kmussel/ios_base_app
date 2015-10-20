# iOS Base Application

A good starting point for an iPhone application

Uses AFNetworking for api calls  
Uses Mantle to map to models  
Uses pods to manage libraries

Has basic login screen that redirects to tabbed application on success.
- The login uses credentials and was test with being passed to my railsapp_api that will authenticate and pass back a token.
-  The token is then added to the header and used in all subsequent request

Multiple tabs that demonstrate very simply how to handle different file types

Audio Tab  
  TableViewController that on click will play the audio file
  
Youtube Video Tab  
  TableViewController that grabs the list of videos from some url on youtube using your api key that you will have to register for.
  On click of the cell it will navigate to a view controller that will play the video using the youtube-ios-player-helper (included in podfile)

Form Tab  
  Simpe TableView that on select of the cell will display the form in a webview


