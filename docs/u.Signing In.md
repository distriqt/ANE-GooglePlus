
## Sign in

Signing in and out is a simple process of adding a series of listeners and then 
calling the signIn method. You'll then receive either a `GooglePlusEvent.SIGN_IN_SUCCESS`
or a `GooglePlusEvent.SIGN_IN_FAILED` depending on the success of the sign in operation.


```as3
GooglePlus.service.addEventListener( GooglePlusEvent.SIGN_IN_SUCCESS, signIn_successHandler );
GooglePlus.service.addEventListener( GooglePlusEvent.SIGN_IN_FAILED, signIn_failedHandler );

GooglePlus.service.signIn();
```

On successful sign in the event.user property will contain user information:

```as3
private function signIn_successHandler( event:GooglePlusEvent ):void
{
	trace( "Sign in succeeded" + "::"+event.user.toString() );
	trace( "token: "+event.user.authentication.idToken );
}

private function signIn_failedHandler( event:GooglePlusEvent ):void
{
	trace( "Sign in failed" );
}
```



## Sign out

Similarly, signing out is a call to the signOut function and the appropriate event listener.


```as3
GooglePlus.service.addEventListener( GooglePlusEvent.SIGN_OUT_SUCCESS, signOut_successHandler );

GooglePlus.service.signOut();
```

```as3
private function signOut_successHandler( event:GooglePlusEvent ):void
{
	trace( "Sign out success" );
}
```