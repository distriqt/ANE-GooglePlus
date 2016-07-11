/**
 *        __       __               __ 
 *   ____/ /_ ____/ /______ _ ___  / /_
 *  / __  / / ___/ __/ ___/ / __ `/ __/
 * / /_/ / (__  ) / / /  / / /_/ / / 
 * \__,_/_/____/_/ /_/  /_/\__, /_/ 
 *                           / / 
 *                           \/ 
 * http://distriqt.com
 *
 * @file   		GoogleIdentityHelper.as
 * @brief  		
 * @author 		"Michael Archbold (ma&#64;distriqt.com)"
 * @created		08/01/2016
 * @copyright	http://distriqt.com/copyright/license.txt
 */
package com.distriqt.test.googleplus
{
	import com.distriqt.extension.core.Core;
	import com.distriqt.extension.googleplus.GooglePlus;
	import com.distriqt.extension.googleplus.GooglePlusOptions;
	import com.distriqt.extension.googleplus.Person;
	import com.distriqt.extension.googleplus.Post;
	import com.distriqt.extension.googleplus.events.GooglePlusEvent;
	import com.distriqt.extension.googleplus.events.GooglePlusShareEvent;
	
	import flash.display.Bitmap;
	
	/**	
	 */
	public class GooglePlusHelper
	{
		
		[Embed("/assets/image.png")]
		public var Image:Class;
		
		private var _messageCallback : Function;
		private function message( text:String ):void
		{
			if (_messageCallback != null) 
			{
				_messageCallback( text );
			}
		}
		
		
		
		////////////////////////////////////////////////////////
		//	FUNCTIONALITY
		//
		
		public function GooglePlusHelper( message:Function )
		{
			_messageCallback = message;
			try
			{
				Core.init();
				GooglePlus.init( Config.distriqtApplicationKey );
				message( "GooglePlus.isSupported:     "+GooglePlus.isSupported );
				message( "GooglePlus.service.version: "+GooglePlus.service.version );
				if (GooglePlus.isSupported)
				{
					
					GooglePlus.service.addEventListener( GooglePlusEvent.SETUP_COMPLETE, 		setupCompleteHandler );
					GooglePlus.service.addEventListener( GooglePlusEvent.SIGN_IN_SUCCESS, 		signInHandler );
					GooglePlus.service.addEventListener( GooglePlusEvent.SIGN_OUT_SUCCESS, 		signOutHandler );
					GooglePlus.service.addEventListener( GooglePlusEvent.DISCONNECT_SUCCESS,	disconnectHandler );

					GooglePlus.service.addEventListener( GooglePlusEvent.SIGN_IN_FAILED,		errorHandler );
					GooglePlus.service.addEventListener( GooglePlusEvent.DISCONNECT_FAILED,		errorHandler );
					GooglePlus.service.addEventListener( GooglePlusEvent.ERROR,					errorHandler );
	
					GooglePlus.service.addEventListener( GooglePlusShareEvent.SHARE_SUCCESS,	shareHandler );
					GooglePlus.service.addEventListener( GooglePlusShareEvent.SHARE_FAILED,		shareHandler );
					GooglePlus.service.addEventListener( GooglePlusShareEvent.SHARE_CANCELLED,	shareHandler );

					
					var options:GooglePlusOptions = new GooglePlusOptions( Config.clientID_Android, Config.clientID_iOS );
					options.requestIdToken = true;
					options.requestServerAuthCode = true;
					
					GooglePlus.service.setup( options );
				}
			}
			catch (e:Error)
			{
				trace( e );
			}
		}
		
		
		
		public function signIn():void
		{
			if (GooglePlus.isSupported)
			{
				GooglePlus.service.signIn();
			}
		}
		
		
		
		public function signOut():void
		{
			if (GooglePlus.isSupported)
			{
				GooglePlus.service.signOut();
			}
		}
		
		
		public function disconnect():void
		{
			if (GooglePlus.isSupported)
			{
				GooglePlus.service.disconnect();
			}
		}
		
		
		public function getCurrentPerson():void
		{
			if (GooglePlus.isSupported)
			{
				var p:Person = GooglePlus.service.getPerson();
				message( "Person.displayName = " + p.displayName );
				message( "Person.imageUrl    = " + p.imageUrl );
			}
		}
		
		
		
		public function share():void
		{
			if (GooglePlus.isSupported)
			{
				var image:Bitmap = new Image() as Bitmap;
				
				var post:Post = new Post();
				post.text 	= "This was posted using the GooglePlus #ANE";
				post.url 	= "http://airnativeextensions.com/extension/com.distriqt.GooglePlus";
				post.image 	= image.bitmapData;
				
				GooglePlus.service.share( post );
			}
		}
		
		
		//
		//
		//	GOOGLE IDENTITY HANDLERS
		//
		//		
		
		private function setupCompleteHandler( event:GooglePlusEvent ):void
		{
			message( event.type );
			GooglePlus.service.signInSilently();
		}
				
		private function signInHandler( event:GooglePlusEvent ):void
		{
			message( event.type + "::"+event.user.toString() );
			message( "email: " + GooglePlus.service.getUserEmail() );
			message( "userid: " + GooglePlus.service.getUserId() );
			
			message( "token: "+event.user.authentication.idToken );
			message( "serverAuthToken: " +event.user.authentication.serverAuthToken );
		}
		
		private function signOutHandler( event:GooglePlusEvent ):void
		{
			message( event.type );
		}
		
		private function disconnectHandler( event:GooglePlusEvent ):void
		{
			message( event.type );
		}
		
		private function errorHandler( event:GooglePlusEvent ):void
		{
			message( event.type +"::["+event.errorCode+"] "+event.error );
		}
		
		private function shareHandler( event:GooglePlusShareEvent ):void
		{
			message( event.type );
		}
		
		
	}
}
