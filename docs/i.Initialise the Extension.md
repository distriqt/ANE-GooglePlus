

## Initialising the Extension

You should perform this once in your application. This initialises the extension using your application key. 
Note you should always check whether the extension is supported before making calls. 
This allows you to react to whether the functionality is available on the device.


```as3
try
{
	GooglePlus.init( APPLICATION_KEY );
	if (GooglePlus.isSupported)
	{
		//	Functionality here
	}
}
catch (e:Error)
{
	trace( e );
}
```

You generate your application keys here: [/user/applications](http://airnativeextensions.com/user/applications)

If you have any issues with the application key, check this [FAQ](http://airnativeextensions.com/knowledgebase/faq/10)


