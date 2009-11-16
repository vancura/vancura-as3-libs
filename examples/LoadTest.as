package {
	import org.vancura.vaclav.assets.Asset;
	import org.vancura.vaclav.assets.AssetManager;
	import org.vancura.vaclav.assets.AssetManagerErrorEvent;
	import org.vancura.vaclav.assets.FARAssetProvider;
	import org.vancura.vaclav.core.Stats;
	import org.vancura.vaclav.widgets.globals.SkinManager;
	import org.vancura.vaclav.widgets.skin.ButtonSkin;
	import org.vancura.vaclav.widgets.widgets.ScaleButton;

	import flash.display.MovieClip;
	import flash.events.Event;

	[SWF(width="1000",height="400",frameRate="60",backgroundColor="#FFFFFF")]

	
	
	public class LoadTest extends MovieClip {

		
		
		private var _assetManager:AssetManager;
		private var _buttonTest:ScaleButton;

		
		
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
			trace('PROVIDER COMPLETE');
			
			var asset:Asset = _assetManager.getAsset('button');
			
//			_skinManager.
			
//			trace(asset);
//			trace(asset.config.widget.@atlas_uri);



			var skin:ButtonSkin = SkinManager.assetToSkin(asset);
			
			_buttonTest = new ScaleButton(skin, {x:10, y:100, width:200}, this);
			
			// --------
			
			var stats:Stats = new Stats();
			addChild(stats);
		}
	}
}
