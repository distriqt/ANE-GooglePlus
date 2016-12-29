
## Add the Extension

First step is always to add the extension to your development environment. 
To do this use the tutorial located [here](http://airnativeextensions.com/knowledgebase/tutorial/1).



## Required ANEs

### Core ANE

The Core ANE is required by this ANE. You must include this extension in your application and 
call the initialisation function at some point, generally at the same time as the initialisation 
of this extension. If you are using other extensions that also require the Core ANE, you only 
need to initialise it once, generally before initialising the other extensions.

```as3
Core.init();
```

The Core ANE doesn't provide any functionality in itself but supports some of our other extensions. 
It's a centralised location for some common actions that can cause issues if they are implemented 
in each individual extension.

You can access this extension here: [https://github.com/distriqt/ANE-Core](https://github.com/distriqt/ANE-Core).


### Android Support ANE

Due to several of our ANE's using the Android Support library the library has been separated 
into a separate ANE allowing you to avoid conflicts and duplicate definitions.
This means that you need to include the some of the android support native extensions in 
your application along with this extension. 

You will add these extensions as you do with any other ANE, and you need to ensure it is 
packaged with your application. There is no problems including this on all platforms, 
they are just required on Android.

This ANE requires the following Android Support extensions:

- [com.distriqt.androidsupport.V4.ane](https://github.com/distriqt/ANE-AndroidSupport/raw/master/lib/com.distriqt.androidsupport.V4.ane)

You can access these extensions here: [https://github.com/distriqt/ANE-AndroidSupport](https://github.com/distriqt/ANE-AndroidSupport).

>
> **Note**: if you have been using the older `com.distriqt.AndroidSupport.ane` you should remove that
> ANE and replace it with the equivalent `com.distriqt.androidsupport.V4.ane`. This is the new 
> version of this ANE and has been renamed to better identify the ANE with regards to its contents.
>


### Google Play Services

This ANE requires usage of certain aspects of the Google Play Services client library. The client library 
is available as a series of ANEs that you add into your applications packaging options. Each separate ANE 
provides a component from the Play Services client library and are used by different ANEs. These client 
libraries aren't packaged with this ANE as they are used by multiple ANEs and separating them will avoid 
conflicts, allowing you to use multiple ANEs in the one application.

This ANE requires the following Google Play Services:

- [com.distriqt.playservices.Base.ane](https://github.com/distriqt/ANE-GooglePlayServices/raw/master/lib/com.distriqt.playservices.Base.ane)
- [com.distriqt.playservices.Auth.ane](https://github.com/distriqt/ANE-GooglePlayServices/raw/master/lib/com.distriqt.playservices.Auth.ane)
- [com.distriqt.playservices.Plus.ane](https://github.com/distriqt/ANE-GooglePlayServices/raw/master/lib/com.distriqt.playservices.Plus.ane)

You must include the above native extensions in your application along with this extension, and you need 
to ensure they are packaged with your application.

You can access the Google Play Services client library extensions here: [https://github.com/distriqt/ANE-GooglePlayServices](https://github.com/distriqt/ANE-GooglePlayServices).





## Android: Manifest Additions

Making requests and accessing the G+ API requires the some additional permissions, 
so these must also be declared in the manifest. Additionally you will need to add 
the activities to the manifest as in the section below


```xml
<manifest android:installLocation="auto">
	<uses-permission android:name="android.permission.INTERNET"/>
	<uses-permission android:name="android.permission.GET_ACCOUNTS" />
	<uses-permission android:name="android.permission.USE_CREDENTIALS" />
	<uses-permission android:name="android.permission.WRITE_EXTERNAL_STORAGE" />
	
	<application>
		<meta-data 
			android:name="com.google.android.gms.version"
			android:value="@integer/google_play_services_version" />
		<activity 
			android:name="com.distriqt.extension.googleplus.activities.GooglePlusActivity" 
			android:theme="@android:style/Theme.Translucent.NoTitleBar" />
		<activity 
			android:name="com.google.android.gms.auth.api.signin.internal.SignInHubActivity" 
			android:windowSoftInputMode="stateAlwaysHidden|adjustPan" 
			android:theme="@android:style/Theme.Translucent.NoTitleBar" />
				
	</application>

</manifest>
```


## iOS Info Additions

Accessing the Google+ API requires some additions to the InfoAdditions on iOS. 
This allows callbacks from external applications that may handle logins and posts. 
You should replace the `URL_SCHEME` and `URL_NAME` in the additions with the ones 
you created when setting up your application in the Google developer console.

```xml
<InfoAdditions><![CDATA[
	<key>UIDeviceFamily</key>
	<array>
		<string>1</string>
	</array>
	
	<key>CFBundleURLTypes</key>
	<array>
		<dict>
			<key>CFBundleURLSchemes</key>
			<array>
				<string>URL_SCHEME</string>
			</array>
			<key>CFBundleURLName</key>
			<string>URL_NAME</string>
		</dict>
	</array>
	
)></InfoAdditions>
```
