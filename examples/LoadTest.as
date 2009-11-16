package {
	import org.vancura.vaclav.assets.AssetManagerErrorEvent;
	import org.vancura.vaclav.assets.FARAssetProvider;
	import org.vancura.vaclav.assets.AssetManager;
	import org.vancura.vaclav.assets.Asset;
	import flash.display.MovieClip;
	import flash.events.Event;

	[SWF(width="1000",height="400",frameRate="60",backgroundColor="#FFFFFF")]

	
	
	public class LoadTest extends MovieClip {

		
		
		private var _assetManager:AssetManager;

		
		
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
			
			trace(asset);
			trace(asset.config);
		}
	}
}
