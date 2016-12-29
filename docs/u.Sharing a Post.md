
## Sharing a Post

The Share dialog provides a means for users to share rich content from your app 
into the Google+ stream, including text, image, and URLs.

```as3
GooglePlus.service.addEventListener( GooglePlusShareEvent.SHARE_SUCCESS,   share_successHandler );
GooglePlus.service.addEventListener( GooglePlusShareEvent.SHARE_CANCELLED, share_cancelledHandler );
GooglePlus.service.addEventListener( GooglePlusShareEvent.SHARE_FAILED,    share_failedHandler );

// Create the post and set the prefilled information
var post:Post = new Post();
post.text 	= "This was posted using the GooglePlus #ANE";
post.url 	= "http://airnativeextensions.com/extension/com.distriqt.GooglePlus";

GooglePlus.service.share( post );
```


```as3
private function share_successHandler( event:GooglePlusShareEvent ):void
{
	trace( "Post shared successfully" );
}

private function share_cancelledHandler( event:GooglePlusShareEvent ):void
{
	trace( "Post sharing was cancelled by the user" );
}

private function share_failedHandler( event:GooglePlusShareEvent ):void
{
	trace( "Post sharing failed" );
}
```

