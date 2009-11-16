package org.vancura.vaclav.widgets.globals {
	import br.com.stimuli.string.printf;

	import org.vancura.vaclav.widgets.constants.DebugLevel;
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
	import flash.events.EventDispatcher;

	
	
	public class SkinManager extends EventDispatcher {

		
		
		private static var _instance:SkinManager;
		
		private var _debugLevel:String = DebugLevel.NONE;
		private var _debugColor:uint = 0xFF0000;
		private var _skinList:Array;
		private var _themeElements:Array;
		private var _themeConfig:Array;

		
		
		public static function getInstance():SkinManager {
			return _instance || (_instance = new SkinManager());
		}
		
		
		
		public function SkinManager() {
			_skinList = new Array();
			_themeElements = (themeElements != null) ? themeElements : new Array();
			_themeConfig = (themeConfig != null) ? themeConfig : new Array();
		}
		
		
		
		public function attach

		
		
		public function getSkin(id:String):* {
			for each(var item:ISkinnable in skinList) {
				if(item.id == id) {
					return item;
				}
			}
			
			return null;
		}
		
		
		
		override public function toString():String {
			if(_isAttached) {
				var list:String = '';
				
				for each(var i:ISkinnable in skinList) {
					list += printf('%s (%s), ', i.id, i.type);
				}
				list = list.substr(0, list.length - 2);
				
				return printf('SkinManager info:\n  isAttached=true\n  debugLevel=%s\n  debugColor=%x\n  registered skins: "%s"', _debugLevel, _debugColor, list);
			}
			else {
				return printf('SkinManager info:\n  isAttached=false');
			}
		}
		
		
		
		public function get debugLevel():String {
			return _debugLevel;
		}

		
		
		public function set debugLevel(debugLevel:String):void {
			_debugLevel = debugLevel;
		}
		
		
		
		public function get debugColor():uint {
			return _debugColor;
		}
		
		
		
		public function set debugColor(debugColor:uint):void {
			_debugColor = debugColor;
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
			return _skinList;
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
			return _themeElements;
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
			return _themeConfig;
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
							_skinList.push(skin);
						}
					}
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
	}
}
