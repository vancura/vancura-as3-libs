// TODO: Add MovieClipLibrary provider
// TODO: Add SWFLibrary provider
// TODO: Add folder provider



package org.vancura.vaclav.assets.providers {
	import org.vancura.vaclav.assets.Asset;
	import org.vancura.vaclav.assets.interfaces.IAssetProvider;

	import flash.events.EventDispatcher;

	
	
	public class AssetProvider extends EventDispatcher implements IAssetProvider {

		
		
		protected var $assetsList:Array;
		protected var $isError:Boolean;
		protected var $isActive:Boolean;
		protected var $isLoaded:Boolean;
		
		
		
		public function AssetProvider() {
			$assetsList = new Array();
		}
		
		
		
		public function destroy():void {
			if(!$isActive) {
				return;
			}
			
			$isActive = false;
			$isLoaded = false;
		}
		
		
		
		public function getAsset(id:String):Asset {
			for each(var asset:Asset in $assetsList) {
				if(asset.id == id) {
					return asset;
				}
			}
			
			return null;
		}

		
		
		public function get assetsList():Array {
			return $assetsList;
		}
		
		
		
		public function get isError():Boolean {
			return $isError;
		}
		
		
		
		public function get isActive():Boolean {
			return $isActive;
		}
		
		
		
		public function get isLoaded():Boolean {
			return $isLoaded;
		}
	}
}
