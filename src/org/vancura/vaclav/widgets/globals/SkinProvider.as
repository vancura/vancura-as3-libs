package org.vancura.vaclav.widgets.globals {
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

	
	
	public class SkinProvider {

		
		
		protected var $skinConfig:Object;
		protected var $skinList:Array;
		protected var $themeElements:Array;
		protected var $themeConfig:Array;
		protected var $isVerbose:Boolean;
		
		
		
		public function SkinProvider(themeElements:Array = null, themeConfig:Array = null, isVerbose:Boolean = false) {
			$skinList = new Array();
			$themeElements = (themeElements != null) ? themeElements : new Array();
			$themeConfig = (themeConfig != null) ? themeConfig : new Array();
			$isVerbose = isVerbose;
		}

		
		
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
		
		
		
		protected function $getSkins():void {
			// get skins
			if($skinConfig.skins != null && $skinConfig.skins.length > 0) {
				for each(var i:Object in $skinConfig.skins) {
					if(i.id != undefined && i.type != undefined) {
						
						var skin:ISkinnable;
						var isSupported:Boolean = true;
						var isOK:Boolean = true;
						
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
							if($isVerbose) {
								trace(printf('SkinManager: Adding "%s" skin "%s"', i.type, i.id));
							}
							$skinList.push(skin);
						}
						else if(isOK) {
							if($isVerbose) {
								trace(printf('SkinManager: "%s" skin is unsupported (type "%s")', i.id, i.type));
							}
						}
						 
					}
					else {
						if($isVerbose) {
							trace('SkinManager: Found skin without id or type fields defined');
						}
					}
				}
			}
			else {
				if($isVerbose) {
					trace('SkinManager: No skins defined');
				}
			}
		}

		
		
		protected function $getAsset(name:String):MovieClip {
			return null;
		}
		
		
		
		protected function $applyAsset(skin:ISkinnable, cls:Class, i:Object):Boolean {
			return false;
		}
		
		
		
		public function get skinConfig():Object {
			return $skinConfig;
		}
		
		
		
		public function get skinList():Array {
			return $skinList;
		}
		
		
		
		public function get themeElements():Array {
			return $themeElements;
		}
		
		
		
		public function get themeConfig():Array {
			return $themeConfig;
		}
		
		
		
		public function get isVerbose():Boolean {
			return $isVerbose;
		}
	}
}
