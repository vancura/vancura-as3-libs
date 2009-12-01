package org.vancura.vaclav.widgets.globals {
	import org.vancura.vaclav.assets.globals.AssetManager;
	
	
	
	public function A2S(id:String):* {
		return SkinManager.assetToSkin(AssetManager.getInstance().getAsset(id));
	}
}
