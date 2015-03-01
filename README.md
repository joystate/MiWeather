#WiWeather app

This is a prototype app with the purpose of detecting weather conditions, which can cause migraine.
##Description of v1.0:
###iPhone app
When app is run, it fetches the weather from [OpenWeahterMap](http://openweathermap.org) API.
If migraine conditions are detected, the app sends notification to inform the user.
###WatchKit app
When the notification is received, the dynamic notification is presented. Glance interface is present.

##Screenshots
<img src="https://cloud.githubusercontent.com/assets/3505021/6429744/97298276-bfb4-11e4-806b-8651850cb36f.png" width="200" height="357" />
<img src="https://cloud.githubusercontent.com/assets/3505021/6429746/99bc8e84-bfb4-11e4-9b65-a2bddacc78d2.png" width="100" height="100" />
<img src="https://cloud.githubusercontent.com/assets/3505021/6429747/9c6de1a0-bfb4-11e4-811c-a55095bd53cb.png" width="100" height="100" />

##To run the app
To run the app, Constants.swift file has to be added to the project with the following contents:
```
class Constants: NSObject {
    let baseURL: String! = "http://api.openweathermap.org/data/2.5"
    let weatherAPIKey: String! = "OPENWEATHERMAP_API_KEY"
    let kLocationUpdatedNotification: String! = "locationUpdatedNotification"
}
```






