package {
	import org.vancura.vaclav.assets.AssetManager;
	import org.vancura.vaclav.assets.AssetManagerErrorEvent;
	import org.vancura.vaclav.assets.FARAssetProvider;
	import org.vancura.vaclav.core.Stats;
	import org.vancura.vaclav.widgets.constants.DebugLevel;
	import org.vancura.vaclav.widgets.globals.SkinManager;
	import org.vancura.vaclav.widgets.widgets.LabelButton;

	import flash.display.MovieClip;
	import flash.events.Event;

	[SWF(width="1000",height="400",frameRate="60",backgroundColor="#FFFFFF")]

	
	
	public class LoadTest extends MovieClip {

		
		
		private var _assetManager:AssetManager;
		private var _buttonTest:LabelButton;

		
		
		public function LoadTest() {
			_assetManager = AssetManager.getInstance();
			
			_assetManager.addEventListener(Event.COMPLETE, _onProviderComplete, false, 0, true);
			_assetManager.addEventListener(AssetManagerErrorEvent.PROVIDER_ERROR, _onProviderError, false, 0, true);
			
			_assetManager.attachProvider(new FARAssetProvider('test-skin.far'));
		}
		
		
		
		private function _onProviderError(event:AssetManagerErrorEvent):void {
			trace('PROVIDER ERROR: ' + event.text);
		}

		
		
		private function _onProviderComplete(event:Event):void {
			SkinManager.debugColor = 0xFF0000;
			SkinManager.debugLevel = DebugLevel.HOVER;
			
			_buttonTest = new LabelButton(SkinManager.assetToSkin(_assetManager.getAsset('button')), {x:300, y:100, width:300}, 'Test', this, DebugLevel.NONE);
			
			// --------
			
			var stats:Stats = new Stats();
			addChild(stats);
		}
	}
}
