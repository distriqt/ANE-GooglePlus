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
 * @file   		Main.as
 * @brief  		
 * @author 		"Michael Archbold (ma&#64;distriqt.com)"
 * @created		08/01/2016
 * @copyright	http://distriqt.com/copyright/license.txt
 */
package com.distriqt.test.googleplus
{
	import com.distriqt.test.googleplus.GooglePlusHelper;
	
	import flash.system.Capabilities;
	
	import feathers.controls.Button;
	import feathers.controls.LayoutGroup;
	import feathers.layout.VerticalLayout;
	import feathers.themes.MetalWorksMobileTheme;
	
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.text.TextField;
	import starling.utils.Color;
	import starling.utils.HAlign;
	import starling.utils.VAlign;
	
	/**	
	 * 
	 */
	public class Main extends Sprite
	{
		////////////////////////////////////////////////////////
		//	CONSTANTS
		//
		
		
		////////////////////////////////////////////////////////
		//	VARIABLES
		//
		
		private var _helper				: GooglePlusHelper;

		
		//	UI
		private var _text				: TextField;
		
		private var _group				: LayoutGroup;
		
		private var _button_signin		: Button;
		private var _button_signout		: Button;
		private var _button_disconnect	: Button;
		private var _button_getPerson	: Button;
		private var _button_share		: Button;
		
		
		
		////////////////////////////////////////////////////////
		//	FUNCTIONALITY
		//
		
		
		/**
		 *  Constructor
		 */
		public function Main()
		{
			super();
			addEventListener( Event.ADDED_TO_STAGE, addedToStageHandler );
		}
		
		
		
		////////////////////////////////////////////////////////
		//	INTERNALS
		//
		
		private function init():void
		{
			_helper = new GooglePlusHelper( message );
		}
		
		
		private function message( text:String ):void
		{
			trace( text );
			if (_text)
				_text.text = text + "\n" + _text.text ;
		}
		
		
		
		////////////////////////////////////////////////////////
		//	EVENT HANDLERS
		//
		
		protected function addedToStageHandler(event:Event):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, addedToStageHandler );

			_text = new TextField( Math.min( 1024, stage.stageWidth), Math.min( 1024, stage.stageHeight ), "", "_typewriter", 18, Color.WHITE );
			_text.hAlign = HAlign.LEFT; 
			_text.vAlign = VAlign.TOP;
			_text.y = 40;
			_text.touchable = false;
			
			
			
			var theme:MetalWorksMobileTheme = new MetalWorksMobileTheme();
			
			Config.scale = 2 * Capabilities.screenDPI / theme.originalDPI;
			
			var layout:VerticalLayout = new VerticalLayout();
			layout.gap = 3 * Config.scale;
			
			_group = new LayoutGroup();
			_group.layout = layout;
			_group.x = 10 * Config.scale;
			_group.y = 5 + 40 * (Config.scale - 1);
			
			_button_signin = new Button();
			_button_signin.label = "Sign In";
			_button_signin.addEventListener( Event.TRIGGERED, button_signin_triggeredHandler );
			
			_button_signout = new Button();
			_button_signout.label = "Sign Out";
			_button_signout.addEventListener( Event.TRIGGERED, button_signout_triggeredHandler );
			
			_button_disconnect = new Button();
			_button_disconnect.label = "Disconnect";
			_button_disconnect.addEventListener( Event.TRIGGERED, button_disconnect_triggeredHandler );
			
			_button_getPerson = new Button();
			_button_getPerson.label = "Get Person";
			_button_getPerson.addEventListener( Event.TRIGGERED, button_getPerson_triggeredHandler );
			
			_button_share = new Button();
			_button_share.label = "Share";
			_button_share.addEventListener( Event.TRIGGERED, button_share_triggeredHandler );
			
			
			_group.addChild( _button_signin );
			_group.addChild( _button_signout );
			_group.addChild( _button_disconnect );
			_group.addChild( _button_getPerson );
			_group.addChild( _button_share );
			
			addChild( _text );
			addChild( _group );
			
			init();
		}
		
		
		private function button_signin_triggeredHandler( event:Event ):void
		{
			_helper.signIn();
		}
		
		private function button_signout_triggeredHandler( event:Event ):void 
		{
			_helper.signOut();
		}
		
		private function button_disconnect_triggeredHandler( event:Event ):void
		{
			_helper.disconnect();
		}
		
		private function button_getPerson_triggeredHandler( event:Event ):void
		{
			_helper.getCurrentPerson();
		}
		
		private function button_share_triggeredHandler( event:Event ):void
		{
			_helper.share();
		}
		
		
	}
}