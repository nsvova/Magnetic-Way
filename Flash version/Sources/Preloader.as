/**
 * @author Denis Kolyako
 * @url http://dev.etcs.ru/
 * @email etc [at] mail.ru
 */
package {
	import flash.display.*;
	import flash.text.*;
	import flash.events.*;
	import mochi.as3.*;
	
	public dynamic class Preloader extends MovieClip 
	{
		public static const ENTRY_FRAME:Number = 3;
		public static const DOCUMENT_CLASS:String = 'Main';
		
		private var textPercent:TextField = null;
		
		public function Preloader()
		{
			super();
			stop();
			
			MochiServices.connect("20962c19e8d9fd80", this, errorConnect);
			
			
			var myOptions:Object = {
				id:"20962c19e8d9fd80",
				res:"640x480",
				clip: this,
				color: 0x006699,
				background: 0x333333,
				outline: 0xFFFFFF
				//ad_loaded: function (width, height) { trace("ad loaded: " + width + "x" + height); }
				//ad_progress: function (percent) { trace("preloader percent: " + percent); }
				};
				
				MochiAd.showPreGameAd(  myOptions  );
				
			
				loaderInfo.addEventListener(ProgressEvent.PROGRESS, progressHandler);
				loaderInfo.addEventListener(Event.COMPLETE, completeHandler);
			
		}
		
		public function errorConnect(status:String):void
		{
			
		}
		
		
		public function isUrl(_url:String):Boolean
		{
			  var url:String = stage.loaderInfo.loaderURL;
			  var urlStart:Number = url.indexOf("://")+3;
			  var urlEnd:Number = url.indexOf("/", urlStart);
			  var domain:String = url.substring(urlStart, urlEnd);
			  var LastDot:Number = domain.lastIndexOf(".")-1;
			  var domEnd:Number = domain.lastIndexOf(".", LastDot)+1;
			  domain = domain.substring(domEnd, domain.length);
			  
				
			  if (_url == domain)
				return true;
			
			return false;
		} 	 	
		
		private function progressHandler(event:ProgressEvent):void 
		{
			if (textPercent)
			{
				removeChild(textPercent);
			}
			
			textPercent = new TextField();
			textPercent.selectable = false;
			var percent:int = (loaderInfo.bytesLoaded * 100 / loaderInfo.bytesTotal);
			textPercent.text = percent.toString() + "%";
			textPercent.setTextFormat(FlashGrafic.CreateTextFormat(40, 0xffffff), -1, -1);
			textPercent.x = 280;
			textPercent.y = 210;
			
			addChild(textPercent);
			
		}
		
		private function completeHandler(event:Event):void 
		{
			play();
			addEventListener(Event.ENTER_FRAME, enterFrameHandler);
		}
		
		private function enterFrameHandler(event:Event):void {
			if (currentFrame >= 2) {
				if (textPercent)
					removeChild(textPercent);
				removeEventListener(Event.ENTER_FRAME, enterFrameHandler);
				stop();
				main();
			}
		}
		
		private function main():void {
			
			addChild(new Main());
			/*var programClass:Class = loaderInfo.applicationDomain.getDefinition(Preloader.DOCUMENT_CLASS) as Class;
			var program:Sprite = new programClass() as Sprite;
			addChild(program);*/
			/* // Logic, but not working code:
			var program:Program = new Program();
			addChild(program);
			*/
		}
	}
}