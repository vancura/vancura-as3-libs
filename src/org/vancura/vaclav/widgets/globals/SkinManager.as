package org.vancura.vaclav.widgets.globals {
	import br.com.stimuli.string.printf;

	import org.vancura.vaclav.widgets.constants.DebugLevel;
	import org.vancura.vaclav.widgets.interfaces.ISkinnable;

	import flash.events.EventDispatcher;

	
	
	public class SkinManager extends EventDispatcher {

		
		
		private static var _instance:SkinManager;
		
		private var _debugLevel:String = DebugLevel.NONE;
		private var _debugColor:uint = 0xFF0000;
		private var _isAttached:Boolean;
		private var _skinProvider:SkinProvider;

		
		
		public static function getInstance():SkinManager {
			return _instance || (_instance = new SkinManager());
		}
		
		
		
		public function attach(skinProvider:SkinProvider):void {
			// prevent reattaching
			if(_isAttached) {
				throw new Error('Skin provider already attached');
			}
			else {
				_isAttached = true;
			}
			
			_skinProvider = skinProvider;
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
		
		
		
		public function get themeElements():Array {
			if(_skinProvider != null) {
				return _skinProvider.themeElements;
			}
			else {
				throw new Error('Skin provider is not attached');
			}
		}

		
		
		public function get themeConfig():Array {
			if(_skinProvider != null) {
				return _skinProvider.themeConfig;
			}
			else {
				throw new Error('Skin provider is not attached');
			}
		}

		
		
		public function get skinList():Array {
			if(_skinProvider != null) {
				return _skinProvider.skinList;
			}
			else {
				throw new Error('Skin provider is not attached');
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
		
		
		
		public function get isAttached():Boolean {
			return _isAttached;
		}
	}
}
