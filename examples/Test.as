package {
	import org.vancura.vaclav.widgets.DebugLevel;
	import org.vancura.vaclav.widgets.skin.ButtonSkin;
	import org.vancura.vaclav.widgets.widgets.ScaleButton;
	import org.vancura.vaclav.widgets.widgets.events.ButtonEvent;

	import flash.display.BitmapData;
	import flash.display.MovieClip;
	
	
	
	[SWF(width="1000",height="400",frameRate="60",backgroundColor="#FFFFFF")]

	
	
	/**
	 * @author Vaclav Vancura (http://vaclav.vancura.org)
	 */
	public class Test extends MovieClip {

		
		
		private var _buttonTest:ScaleButton;
		
		
		
		public function Test() {
			var skin:ButtonSkin = new ButtonSkin();
			
			var source:BitmapData = new BitmapData(400, 100);
			
			
			
			skin.getAssetsFromComposition(source);
			
			_buttonTest = new ScaleButton(skin, {x:10, y:10}, this, DebugLevel.HOVER);
			
			_buttonTest.addEventListener(ButtonEvent.RELEASE_INSIDE, _onTest);
		}
		
		
		
		private function _onTest(event:ButtonEvent):void {
			_buttonTest.morph({width:400, morphDuration:2});
		}
	}
}
