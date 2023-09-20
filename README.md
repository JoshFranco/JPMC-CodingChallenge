# JPMC-CodingChallenge

Coding Challenge: Weather

Summary
Below are the details needed to construct a weather based app where users can look up weather for a city. The team would like to move forward to the next round, congrats! This coding challenge is meant to take 3-4 hours, and be completed within 1 week from receiving this email (9/19/23). Once finished, please upload your solution to Github or Gitlab, and reply with the link to this email. The team will review your work, and the next round would be going over how you approached the problem. 
Details
    Below are the details needed to construct a weather based app where users can look up weather for a city.

Public API
    Create a free account at openweathermap.org. Just takes a few minutes. Full documentation for the service below is on their site, be sure to take a few minutes to understand it.

Source Website 
openweathermap.org
API Key
https://api.openweathermap.org/data/2.5/weather?lat=44.34&lon=10.99&appid=


Built-in Geocoding
    Please use Geocoder API if you need to automatically convert city names and zip-codes to geo coordinates and the other way around.

NOTE - API requests by city name, zip-codes and city id have been deprecated. Although they are still available for use, bug fixing and updates are no longer available for this functionality.

Geocoder API
Geocoder API
City Name Documentation 
API requests by city name
Zip Code Documentation 
zip-codes
City ID Documentation 
city id

Built-in API Request by City Name Example
    You can call by city name, state code or country code. Please note that searching by state codes is only for the USA locations.

API Call Example:
https://api.openweathermap.org/data/2.5/weather?q={city name}&appid={API key}

https://api.openweathermap.org/data/2.5/weather?q={city name},{country code}&appid={API key}

https://api.openweathermap.org/data/2.5/weather?q={city name},{state code},{country code}&appid={API key}


UI/UX Considerations 
Icons should be sourced from the following:
http://openweathermap.org/weather-conditions

Requirements
    These requirements are rather high-level and vague. If there are details that have been omitted, it is because the team would be happy with any of a wide variety of solutions. Don't worry about finding "the" solution.

Create a browser or native-app-based application to serve as a basic weather app.
Search Screen
Allow customers to enter a US city
Call the openweathermap.org API and display the information you think a user would be interested in seeing. Be sure to have the app download and display a weather icon as the app icon.
Have image cache if needed
NOTE: We can use kingfisher for reliable image caching 
Auto-load the last city searched upon app launch.
NOTE: Will need some sort of persistence, if its as simple as just the last city search then User Defaults should suffice 
Ask the User for location access, If the User gives permission to access the location, then retrieve weather data by default
Will need location perms 
Will need a grateful fallback if the user declines the permission 

Prioritization List
What's Important: 
Proper function – requirements met.
Well-constructed, easy-to-follow, commented code 
especially comment hacks or workarounds made in the interest of expediency
i.e. // given more time I would prefer to wrap this in a blah blah blah pattern blah blah
Proper separation of concerns and best-practice coding patterns.
NOTE: I want to go with a CLEAN arch so will have to clearly define the layers and how they interact with each-other 
NOTE: https://github.com/hmlongco/Factory would be a good SDK for dep injection 
Defensive code that graciously handles unexpected edge cases.

What’s Less Important 
UI design
generally, design is handled by a dedicated team in our group.
Demonstrating technologies or techniques you are not already familiar with 
i.e. if you aren't comfortable building a single-page app, please don't feel you need to learn how for this

iOS Specific 
For applications that include CocoaPods with their project code, having the Pods included in the code commits as the source is recommended.
 Even though it goes against the CocoaPod's general rules
Be sure to use safe area insets 
Using Sizeclass wisely for landscape and portrait  
Make sure to use UIKit, we would love to see a combination of both UIKit and SwiftUI if you desire.
