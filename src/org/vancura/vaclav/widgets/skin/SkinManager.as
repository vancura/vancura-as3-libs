package org.vancura.vaclav.widgets.skin {
	import br.com.stimuli.string.printf;

	import org.vancura.vaclav.widgets.DebugLevel;
	import org.vancura.vaclav.widgets.skin.interfaces.ISkinnable;

	import flash.display.LoaderInfo;
	import flash.display.MovieClip;
	import flash.events.EventDispatcher;

	
	
	public class SkinManager extends EventDispatcher {

		
		
		private static const _DEFAULT_DEBUG_LEVEL:String = DebugLevel.NONE;
		private static const _DEFAULT_DEBUG_COLOR:uint = 0xFF0000;
		
		private static var _instance:SkinManager;
		
		private var _skinMC:MovieClip;
		private var _loaderInfo:LoaderInfo;
		private var _skinConfig:Object;
		private var _skinList:Array;
		private var _themeElements:Array;
		private var _themeConfig:Array;
		private var _debugLevel:String;
		private var _debugColor:uint;
		private var _isAttached:Boolean;
		private var _isVerbose:Boolean;

		
		
		public static function getInstance():SkinManager {
			return _instance || (_instance = new SkinManager());
		}
		
		
		
		public function attachMovieClip(mc:MovieClip, debugLevel:String = _DEFAULT_DEBUG_LEVEL, debugColor:uint = _DEFAULT_DEBUG_COLOR, themeElements:Array = null, themeConfig:Array = null, isVerbose:Boolean = false):void {
			// prevent reattaching
			if(_isAttached) {
				throw new Error('Skin already applied');
			}
			
			// initial setting
			_isAttached = true;
			_skinMC = mc;
			
			// override parameters if needed and setup lists
			_skinList = new Array();
			_debugLevel = debugLevel;
			_debugColor = debugColor;
			_themeElements = (themeElements != null) ? themeElements : new Array();
			_themeConfig = (themeConfig != null) ? themeConfig : new Array();
			_isVerbose = isVerbose;
			
			// get skin loaderInfo.
			// used to get assets from skin asset library.
			if(_skinMC.loaderInfo == null) {
				throw new Error('Could not get skin loaderInfo (skin asset library)');
			}
			else {
				_loaderInfo = _skinMC.loaderInfo;
			}
			
			// get config
			try {
				_skinConfig = _skinMC.getSkinConfig();
			}
			catch(err:Error) {
				throw new Error('Could not get skin config. Usually it means there was a compile error while publishing skin SWF. Go check it out into Compiler Errors panel in Flash.');
			}
			
			// set global parameters
			if(_debugLevel == null) {
				_debugLevel = (_skinConfig.debugLevel != undefined) ? _skinConfig.debugLevel : _DEFAULT_DEBUG_LEVEL;
			}
			if(_debugColor != _DEFAULT_DEBUG_COLOR) {
				_debugColor = (_skinConfig.debugColor != undefined) ? _skinConfig.debugColor : _DEFAULT_DEBUG_COLOR;
			}
			
			// get skins
			if(_skinConfig.skins != null && _skinConfig.skins.length > 0) {
				for each(var i:Object in _skinConfig.skins) {
					if(i.id != undefined && i.type != undefined) {
						
						var skin:ISkinnable;
						var isSupported:Boolean = true;
						var isOK:Boolean = true;
						
						switch(i.type) {
							case Skin.TYPE_BAR:
								skin = new BarSkin(i.id);
								_applyAsset(skin, BarSkin, i);
								(skin as BarSkin).parseConfig(_mergeConfig(i));
								break;
								
							case Skin.TYPE_IMAGE:
								skin = new ImageSkin(i.id);
								_applyAsset(skin, ImageSkin, i);
								(skin as ImageSkin).parseConfig(_mergeConfig(i));
								break;
								
							case Skin.TYPE_BUTTON:
								skin = new ButtonSkin(i.id);
								_applyAsset(skin, ButtonSkin, i);
								(skin as ButtonSkin).parseConfig(_mergeConfig(i));
								break;
								
							case Skin.TYPE_LABEL:
								skin = new LabelSkin(i.id);
								(skin as LabelSkin).parseConfig(_mergeConfig(i));
								break;
								
							case Skin.TYPE_LABEL_BUTTON:
								skin = new LabelButtonSkin(i.id);
								_applyAsset((skin as LabelButtonSkin).buttonSkin, ButtonSkin, i.button);
								(skin as LabelButtonSkin).parseConfig(_mergeConfig(i));
								break;
								
							case Skin.TYPE_CHECK_BUTTON:
								skin = new CheckButtonSkin(i.id);
								_applyAsset((skin as CheckButtonSkin).buttonOffSkin, ButtonSkin, i.buttonOff);
								_applyAsset((skin as CheckButtonSkin).buttonOnSkin, ButtonSkin, i.buttonOn);
								(skin as CheckButtonSkin).parseConfig(_mergeConfig(i));
								break;
								
							case Skin.TYPE_INPUT_BAR:
								skin = new InputBarSkin(i.id);
								_applyAsset((skin as InputBarSkin).barSkin, BarSkin, i.bar);
								(skin as InputBarSkin).parseConfig(_mergeConfig(i));
								break;
								
							default:
								isSupported = false;
						}
						
						if(isOK && isSupported) {
							if(_isVerbose) {
								trace(printf('SkinManager: Adding "%s" skin "%s"', i.type, i.id));
							}
							_skinList.push(skin);
						}
						else if(isOK) {
							if(_isVerbose) {
								trace(printf('SkinManager: "%s" skin is unsupported (type "%s")', i.id, i.type));
							}
						}
						 
					}
					else {
						if(_isVerbose) {
							trace('SkinManager: Found skin without id or type fields defined');
						}
					}
				}
			}
			else {
				if(_isVerbose) {
					trace('SkinManager: No skins defined');
				}
			}
		}
		
		
		
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
				
				for each(var i:ISkinnable in _skinList) {
					list += printf('%s (%s), ', i.id, i.type);
				}
				list = list.substr(0, list.length - 2);
				
				return printf('SkinManager info:\n  isAttached=true\n  debugLevel=%s\n  debugColor=%x\n  registered skins: "%s"', _debugLevel, _debugColor, list);
			}
			else {
				return printf('SkinManager info:\n  isAttached=false');
			}
		}
		
		
		
		public function get themeElements():Array {
			return _themeElements;
		}

		
		
		public function get themeConfig():Array {
			return _themeConfig;
		}

		
		
		public function get skinList():Array {
			return _skinList;
		}

		
		
		public function get debugLevel():String {
			return _debugLevel;
		}

		
		
		public function get debugColor():uint {
			return _debugColor;
		}
		
		
		
		public function get isAttached():Boolean {
			return _isAttached;
		}
		
		
		
		private function _getAsset(name:String):MovieClip {
			try {
				return new(_loaderInfo.applicationDomain.getDefinition(name) as Class) as MovieClip;
			}
			catch(err:ReferenceError) {
			}
			
			return null;
		}

		
		
		private function _mergeConfig(source:Object):Object {
			for each(var o:Object in _themeConfig) {
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

		
		
		private function _applyAsset(skin:ISkinnable, cls:Class, i:Object):Boolean {
			var asset:MovieClip = _getAsset(i.symbol);
			
			if(i.symbol != undefined) {
				with(skin as cls) {
					if(asset != null) {
						getAssetsFromMovieClip(asset, _themeElements);
						parseConfig(_mergeConfig(i));
						return true;
					}
					else {
						if(_isVerbose) {
							trace(printf('SkinManager: "%s" skin requires symbol "%s", but it was not found in the library', i.id, i.symbol));
						}
						return false;
					}
				}
			}
			else {
				if(_isVerbose) {
					trace(printf('SkinManager: "%s" skin requires symbol field', i.id));
				}
				return false;
			}
		}
	}
}
