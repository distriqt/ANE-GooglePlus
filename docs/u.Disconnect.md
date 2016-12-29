
## Disconnect 

Google's [developer policies](https://developers.google.com/+/policies) also require you to 
provide the ability for a user to disconnect your application from their account. This means 
your app must provide a way to delete the association between your app and their account. 
By adding this capability to your app, you can respond to the event and trigger any appropriate 
logic such as deleting any information you have stored about the user.

```as3
GooglePlus.service.addEventListener( GooglePlusEvent.DISCONNECT_SUCCESS, disconnect_successHandler );
GooglePlus.service.addEventListener( GooglePlusEvent.DISCONNECT_FAILED,	 disconnect_failedHandler );

GooglePlus.service.disconnect();
```


```as3
private function disconnect_successHandler( event:GooglePlusEvent ):void
{
	trace( "Disconnect success" );
	//
	//	You should delete any user data here
}

private function disconnect_failedHandler( event:GooglePlusEvent ):void
{
	trace( "Disconnect failed" );
	// You should try again in a small time interval
}
```


