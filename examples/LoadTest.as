package {
	import org.vancura.vaclav.assets.Asset;
	import org.vancura.vaclav.assets.events.AssetManagerErrorEvent;
	import org.vancura.vaclav.assets.globals.AssetManager;
	import org.vancura.vaclav.assets.providers.FARAssetProvider;
	import org.vancura.vaclav.core.Stats;
	import org.vancura.vaclav.widgets.constants.DebugLevel;
	import org.vancura.vaclav.widgets.events.ButtonEvent;
	import org.vancura.vaclav.widgets.globals.SkinManager;
	import org.vancura.vaclav.widgets.skin.ButtonSkin;
	import org.vancura.vaclav.widgets.widgets.LabelButton;
	import org.vancura.vaclav.widgets.widgets.StaticButton;

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
			SkinManager.debugLevel = DebugLevel.ALWAYS;
			
			var asset:Asset = _assetManager.getAsset('label_button');
			var skin:* = SkinManager.assetToSkin(asset);
			
			_buttonTest = new LabelButton(skin, {x:300, y:100, width:400}, 'Test', this);
			_buttonTest.addEventListener(ButtonEvent.RELEASE_INSIDE, _onTest, false, 0, true);
			
			var anotherSkin:ButtonSkin = SkinManager.assetToSkin(_assetManager.getAsset('scale_button')) as ButtonSkin;
			var anotherButton:StaticButton = new StaticButton(anotherSkin, {x:50, y:200}, this);
			
			// --------
			
			var stats:Stats = new Stats();
			addChild(stats);
		}
		
		
		
		private function _onTest(event:ButtonEvent):void {
			_buttonTest.morph({height:Math.random() * 300 + 100});
		}
	}
}
