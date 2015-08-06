package Screen 
{
	import fl.livepreview.LivePreviewParent;
	import flash.display.MovieClip;
	import flash.display.SimpleButton;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.StatusEvent;
	import flash.utils.Timer;
	import flash.events.TimerEvent;
	/**
	 * ...
	 * @author Other
	 */
	public class HelpScreen extends GameScreen
	{
		
		var back:Sprite;
		var finish:Sprite
		
		var _menu:SimpleButton;
		var clear:SimpleButton;
		
		
		var between:MovieClip;
		var between2:MovieClip;
		
		
		public function HelpScreen() 
		{
			
		}
		
		override public function Start():void 
		{
			super.Start();
			
			back = new gBackBeforeMenu;
			addChild(back);
			
			finish = new gFinish();
			finish.x = 50;
			finish.y = 50;
			addChild(finish);
			
			_menu = new mainMenu_button();
			_menu. x = 200;
			_menu. y = 400;
			addChild(_menu);
			
			clear = new Help();
			clear.x = 440;
			clear.y = 400;
			addChild(clear);
			
			
			
			
			between2 = new gWonBack2();
			addChild(between2);
			
			
			clear.addEventListener(MouseEvent.CLICK, clearClick);
			_menu.addEventListener(MouseEvent.CLICK, clickMenu);

		}
		
		private function clearClick(e:MouseEvent):void 
		{
			var timer:Timer = new Timer(500, 1);
			timer.addEventListener(TimerEvent.TIMER_COMPLETE, timerClear);
			
			Save.Clear();
			between = new gWonBack();
			addChild(between);
			
			timer.start();
		}
		
		private function timerClear(e:Event):void 
		{
			dispatchEvent(new StatusEvent(StatusEvent.STATUS, false, false, "", "GoToMenu"));
		}
		
		
		override public function Stop():void 
		{
			super.Stop();
			
			_menu = null;
			finish = null;
			back = null;
			clear = null;
			
			
		}
		
		private function clickMenu(e:MouseEvent):void 
		{
			var timer:Timer = new Timer(500, 1);
			timer.addEventListener(TimerEvent.TIMER_COMPLETE, timerMenu);
			
			between = new gWonBack();
			addChild(between);
			
			timer.start();
			
		}
		
		private function timerMenu(e:Event):void 
		{
			dispatchEvent(new StatusEvent(StatusEvent.STATUS, false, false, "", "GoToMenu"));
		}
		
		
		
		
		
	}

}