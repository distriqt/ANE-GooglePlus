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
 * This is a test application for the distriqt extension
 * 
 * @author Michael Archbold & Shane Korin
 * 	
 */
package
{
	import com.distriqt.extension.core.Core;
	import com.distriqt.extension.googleplus.GooglePlus;
	import com.distriqt.extension.googleplus.GooglePlusOptions;
	import com.distriqt.extension.googleplus.Person;
	import com.distriqt.extension.googleplus.Post;
	import com.distriqt.extension.googleplus.events.GooglePlusEvent;
	import com.distriqt.extension.googleplus.events.GooglePlusShareEvent;
	
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.text.TextFormat;
	
	
	/**	
	 * Sample application for using the GooglePlus Native Extension
	 * 
	 * @author	Michael Archbold
	 */
	public class TestGooglePlus extends Sprite
	{
		public static var APP_KEY 	: String = "APPLICATION_KEY";
		public static var CLIENT_ID 	: String = "YOUR_GOOGLE_API_CLIENT_ID";

		
		[Embed("test.png")]
		public var Icon:Class;
		
		
		/**
		 * Class constructor 
		 */	
		public function TestGooglePlus()
		{
			super();
			create();
			init();
		}
		
		
		//
		//	VARIABLES
		//
		
		private var _text		: TextField;
		
		
		//
		//	INITIALISATION
		//	
		
		private function create( ):void
		{
			stage.align = StageAlign.TOP_LEFT;
			stage.scaleMode = StageScaleMode.NO_SCALE;
			
			var tf:TextFormat = new TextFormat( "_typewriter", 16 );
			_text = new TextField();
			_text.y = 40;
			_text.defaultTextFormat = tf;
			addChild( _text );

			stage.addEventListener( Event.RESIZE, stage_resizeHandler, false, 0, true );
			stage.addEventListener( MouseEvent.CLICK, mouseClickHandler, false, 0, true );
		}
		
		
		private function init( ):void
		{
			try
			{
				Core.init();
				GooglePlus.init( APP_KEY );
				
				message( "GooglePlus Supported: " + GooglePlus.isSupported );
				
				if (GooglePlus.isSupported)
				{
					message( "GooglePlus Version:   " + GooglePlus.service.version );
					
					if (!GooglePlus.service.isGooglePlusAppInstalled())
					{
						message( "Google Plus Application not installed" );
					}
	
					{
						GooglePlus.service.addEventListener( GooglePlusEvent.SIGN_IN_SUCCESS, 	signIn_successHandler, false, 0, true );
						GooglePlus.service.addEventListener( GooglePlusEvent.SIGN_IN_FAILED, 	signIn_failedHandler, false, 0, true );
						GooglePlus.service.addEventListener( GooglePlusEvent.SIGN_OUT_SUCCESS,	signOut_successHandler, false, 0, true );
						GooglePlus.service.addEventListener( GooglePlusEvent.DISCONNECT_SUCCESS,	disconnect_successHandler, false, 0, true );
						GooglePlus.service.addEventListener( GooglePlusEvent.DISCONNECT_FAILED,		disconnect_failedHandler, false, 0, true );
						
						GooglePlus.service.addEventListener( GooglePlusShareEvent.SHARE_SUCCESS,	share_successHandler, false, 0, true );
						GooglePlus.service.addEventListener( GooglePlusShareEvent.SHARE_CANCELLED,	share_cancelledHandler, false, 0, true );
						GooglePlus.service.addEventListener( GooglePlusShareEvent.SHARE_FAILED,		share_failedHandler, false, 0, true );
						
						var options:GooglePlusOptions = new GooglePlusOptions( CLIENT_ID );
						
						GooglePlus.service.setup( options );
					}
				}
				
			}
			catch (e:Error)
			{
				message( "ERROR::"+e.message );
			}
		}
		
		
		//
		//	FUNCTIONALITY
		//
		
		private function message( str:String ):void
		{
			trace( str );
			_text.appendText(str+"\n");
		}
		
		
		//
		//	EVENT HANDLERS
		//
		
		private function stage_resizeHandler( event:Event ):void
		{
			_text.width  = stage.stageWidth;
			_text.height = stage.stageHeight - 100;
		}
		
		
		private var _state	: int = 0;
		
		private function mouseClickHandler( event:MouseEvent ):void
		{
			//
			//	Do something when user clicks screen?
			//	
			
			if (GooglePlus.isSupported)
			{
				switch (_state)
				{
					case 0:
						message( "signIn" );
						GooglePlus.service.signIn();
						break;
					
					case 1:
						message( "attempting a post" );
						if (GooglePlus.service.isSignedIn())
						{
							var icon:Bitmap = new Icon() as Bitmap;

							var post:Post = new Post();
							post.text 	= "Example post content";
							post.url 	= "http://airnativeextensions.com";
							post.image 	= icon.bitmapData;
							
							GooglePlus.service.share( post );
						}
						break;
					
					case 2:
						message( "disconnect" );
						GooglePlus.service.disconnect();
						break;
					
					case 3: 
						message( "signOut" );
						GooglePlus.service.signOut();
						break;
				}
			
				_state++; if (_state > 3) _state = 0;
			}		
		}
		
		
		
		//
		//	EXTENSION HANDLERS
		//
		
		private function signIn_successHandler( event:GooglePlusEvent ):void
		{
			message( event.type );
			
			var person:Person = GooglePlus.service.getPerson();
			if (person != null)
			{
				message( "Signed in as : " + person.displayName );
			}
		}
		
		private function signIn_failedHandler( event:GooglePlusEvent ):void
		{
			message( event.type );
		}
		
		private function signOut_successHandler( event:GooglePlusEvent ):void
		{
			message( event.type );
		}
		
		private function disconnect_successHandler( event:GooglePlusEvent ):void
		{
			message( event.type );
		}
		
		private function disconnect_failedHandler( event:GooglePlusEvent ):void
		{
			message( event.type );
		}
		
		
		
		private function share_successHandler( event:GooglePlusShareEvent ):void
		{
			message( event.type );
		}
		
		private function share_cancelledHandler( event:GooglePlusShareEvent ):void
		{
			message( event.type );
		}

		private function share_failedHandler( event:GooglePlusShareEvent ):void
		{
			message( event.type );
		}
		

	}
}

