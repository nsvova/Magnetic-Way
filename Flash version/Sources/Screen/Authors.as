package Screen 
{
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.display.SimpleButton;
	import flash.events.MouseEvent;
	import flash.events.StatusEvent;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	/**
	 * ...
	 * @author Other
	 */
	public class Authors extends GameScreen
	{
		
		var back:Sprite;
		var authors:Sprite;
		
		var _menu:SimpleButton;
		
		private var between:MovieClip;
		private var between2:MovieClip;
		
		public function Authors() 
		{
			
		}
		
		override public function Start():void 
		{
			super.Start();
			
			back = new gBackBeforeMenu();
			authors = new gAuthorsScreen();
			_menu = new mainMenu_button();
			
			authors.x = 50;
			authors.y = 30;
			
			_menu.x = 320;
			_menu.y = 450;
			
			addChild(back);
			addChild(authors);
			addChild(_menu);
			
			between2 = new gWonBack2();
			addChild(between2);
			
			_menu.addEventListener(MouseEvent.CLICK, clickMenu);
			
		}
		
		private function clickMenu(e:MouseEvent):void 
		{
			var timer:Timer = new Timer(500, 1);
			timer.addEventListener(TimerEvent.TIMER_COMPLETE, timerClickMenu);
			
			
			between = new gWonBack();
			addChild(between);
			
			timer.start();
			
		}
		
		private function timerClickMenu(e:TimerEvent):void 
		{
			dispatchEvent(new StatusEvent(StatusEvent.STATUS, false, false, "", "GoToMenu"));
		}
		
		override public function Stop():void 
		{
			super.Stop();
			
			if (between2)
			{
				between2.stop();
				removeChild(between2);
				between2 = null;
			}
			if (between)
			{
				between.stop();
				removeChild(between);
				between = null;
			}
			
			removeChild(back);
			removeChild(authors);
			
			authors = null;
			back = null;
		}
		
	}

}