package org.vancura.vaclav.widgets.globals {
	import flash.events.EventDispatcher;
	import br.com.stimuli.string.printf;

	import org.vancura.vaclav.widgets.interfaces.ISkinnable;
	import org.vancura.vaclav.widgets.skin.BarSkin;
	import org.vancura.vaclav.widgets.skin.ButtonSkin;
	import org.vancura.vaclav.widgets.skin.CheckButtonSkin;
	import org.vancura.vaclav.widgets.skin.ImageSkin;
	import org.vancura.vaclav.widgets.skin.InputBarSkin;
	import org.vancura.vaclav.widgets.skin.LabelButtonSkin;
	import org.vancura.vaclav.widgets.skin.LabelSkin;
	import org.vancura.vaclav.widgets.skin.Skin;

	import flash.display.MovieClip;

	
	
	public class Provider extends EventDispatcher {

		
		
		protected var $skinList:Array;
		protected var $themeElements:Array;
		protected var $themeConfig:Array;
		protected var $isVerbose:Boolean;
		
		
		
		/*
		 * Constructor: Provider
		 * 
		 * Create a new Provider instance.
		 * 
		 * Parameters:
		 * 		themeElements	- Theming element names
		 * 		themeConfig		- Theming element config
		 * 		isVerbose		- Verbose flag
		 */
		public function Provider(themeElements:Array = null, themeConfig:Array = null, isVerbose:Boolean = false) {
			$skinList = new Array();
			$themeElements = (themeElements != null) ? themeElements : new Array();
			$themeConfig = (themeConfig != null) ? themeConfig : new Array();
			$isVerbose = isVerbose;
		}

		
		
		/*
		 * Method: $mergeConfig
		 * 
		 * Merge config from Skin with config in parameter.
		 * 
		 * Parameters:
		 * 		source	- Source config object
		 * 		
		 * Returns:
		 * 		Merged config object
		 */
		protected function $mergeConfig(source:Object):Object {
			for each(var o:Object in themeConfig) {
				var parameter:String = o.parameter as String;
				 
				if(parameter.indexOf(source.id) == 0) {
					try {
						var value:String = o.value as String;
						var instance:String = parameter.replace(source.id + '.', '');
						source[instance] = (value == '') ? null : value;
					}
					catch(err:Error) {
						throw new Error(printf('Could not convert config (mask="%s")', source.id));
					}
				}
			}
			
			return source;
		}
		
		
		
		/*
		 * Method: $getSkins
		 * 
		 * Get all skins from the skin config object.
		 * 
		 * Parameters:
		 */
		protected function $getSkins(skinConfig:Object):void {
			if(skinConfig.skins != null && skinConfig.skins.length > 0) {
				// at least one skin is inside
				
				for each(var i:Object in skinConfig.skins) {
					if(i.id != undefined && i.type != undefined) {
						// id and type fields are required
						
						var skin:ISkinnable;
						var isSupported:Boolean = true;
						var isOK:Boolean = true;
						
						// check for skin type
						switch(i.type) {
							case Skin.TYPE_BAR:
								skin = new BarSkin(i.id);
								$applyAsset(skin, BarSkin, i);
								(skin as BarSkin).parseConfig($mergeConfig(i));
								break;
								
							case Skin.TYPE_IMAGE:
								skin = new ImageSkin(i.id);
								$applyAsset(skin, ImageSkin, i);
								(skin as ImageSkin).parseConfig($mergeConfig(i));
								break;
								
							case Skin.TYPE_BUTTON:
								skin = new ButtonSkin(i.id);
								$applyAsset(skin, ButtonSkin, i);
								(skin as ButtonSkin).parseConfig($mergeConfig(i));
								break;
								
							case Skin.TYPE_LABEL:
								skin = new LabelSkin(i.id);
								(skin as LabelSkin).parseConfig($mergeConfig(i));
								break;
								
							case Skin.TYPE_LABEL_BUTTON:
								skin = new LabelButtonSkin(i.id);
								$applyAsset((skin as LabelButtonSkin).buttonSkin, ButtonSkin, i.button);
								(skin as LabelButtonSkin).parseConfig($mergeConfig(i));
								break;
								
							case Skin.TYPE_CHECK_BUTTON:
								skin = new CheckButtonSkin(i.id);
								$applyAsset((skin as CheckButtonSkin).buttonOffSkin, ButtonSkin, i.buttonOff);
								$applyAsset((skin as CheckButtonSkin).buttonOnSkin, ButtonSkin, i.buttonOn);
								(skin as CheckButtonSkin).parseConfig($mergeConfig(i));
								break;
								
							case Skin.TYPE_INPUT_BAR:
								skin = new InputBarSkin(i.id);
								$applyAsset((skin as InputBarSkin).barSkin, BarSkin, i.bar);
								(skin as InputBarSkin).parseConfig($mergeConfig(i));
								break;
								
							default:
								isSupported = false;
						}
						
						if(isOK && isSupported) {
							// type is ok
							if($isVerbose) {
								trace(printf('SkinManager: Adding "%s" skin "%s"', i.type, i.id));
							}
							
							$skinList.push(skin);
						}
						else if(isOK) {
							// type is not supported
							if($isVerbose) {
								trace(printf('SkinManager: "%s" skin is unsupported (type "%s")', i.id, i.type));
							}
						}
						 
					}
					else {
						// no id and/or type fields available
						if($isVerbose) {
							trace('SkinManager: Found skin without id or type fields defined');
						}
					}
				}
			}
			
			else {
				// no skins defined
				if($isVerbose) {
					trace('SkinManager: No skins defined');
				}
			}
		}

		
		
		/*
		 * Method: $getAsset
		 * 
		 * Get asset by its name.
		 * Placeholder to be replaced by providers.
		 */
		protected function $getAsset(name:String):MovieClip {
			return null;
		}
		
		
		
		/*
		 * Method: $applyAsset
		 * 
		 * Apply asset.
		 * Placeholder to be replaced by providers.
		 */
		protected function $applyAsset(skin:ISkinnable, cls:Class, i:Object):Boolean {
			return false;
		}
		
		
		
		/*
		 * Getter: skinList
		 * 
		 * Get Skins list.
		 * 
		 * Returns:
		 * 		Skins list
		 */
		public function get skinList():Array {
			return $skinList;
		}
		
		
		
		/*
		 * Getter: themeElements
		 * 
		 * Get Theme element names.
		 * 
		 * Returns:
		 * 		Theme element names
		 */
		public function get themeElements():Array {
			return $themeElements;
		}
		
		
		
		/*
		 * Getter: themeConfig
		 * 
		 * Get Theme element config.
		 * 
		 * Returns:
		 * 		Theme element config
		 */
		public function get themeConfig():Array {
			return $themeConfig;
		}
		
		
		
		/*
		 * Getter: isVerbose
		 * 
		 * Get verbose flag.
		 * 
		 * Returns:
		 * 		Verbose flag
		 */
		public function get isVerbose():Boolean {
			return $isVerbose;
		}
	}
}