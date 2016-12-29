
## Setup the extension

You should perform this once in your application. This initialises the platform 
using your Google API client ID. 


```as3
GooglePlus.service.addEventListener( GooglePlusEvent.SETUP_COMPLETE, setupCompleteHandler );

var options:GooglePlusOptions = new GooglePlusOptions( ANDROID_CLIENTID, IOS_CLIENTID );

GooglePlus.service.setup( options );
```

Then wait for the setup complete handler:

```as3
private function setupCompleteHandler( event:GooglePlusEvent ):void
{
	// Google Plus is now setup
}
```


You can also check whether a user has the Google+ application installed.

```as3
if (GooglePlus.service.isGooglePlusAppInstalled())
{
	trace( "The Google+ application is installed on this device" );
}
```

