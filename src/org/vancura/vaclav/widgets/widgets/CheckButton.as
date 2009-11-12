package org.vancura.vaclav.widgets.widgets {
	import org.vancura.vaclav.core.MorphSprite;
	import org.vancura.vaclav.core.removeChildren;
	import org.vancura.vaclav.widgets.events.ButtonEvent;
	import org.vancura.vaclav.widgets.interfaces.IButton;
	import org.vancura.vaclav.widgets.interfaces.ICheckButton;
	import org.vancura.vaclav.widgets.interfaces.ICheckButtonSkin;
	import org.vancura.vaclav.widgets.interfaces.IWidget;
	import org.vancura.vaclav.widgets.skin.SkinManager;

	import flash.display.DisplayObjectContainer;

	
	
	public class CheckButton extends MorphSprite implements IWidget, ICheckButton {

		
		
		protected var $skin:ICheckButtonSkin;		
		protected var $buttonOff:StaticButton;		protected var $buttonOn:StaticButton;

		private var _debugLevel:String;
		private var _isChecked:Boolean;

		
		
		public function CheckButton(	skin:ICheckButtonSkin,
										config:Object = null,
										parent:DisplayObjectContainer = null,
										debugLevel:String = null) {
										
			if(config == null) {
				config = new Object();
			}
			
			var sm:SkinManager = SkinManager.getInstance();
			var dl:String = (debugLevel != null) ? debugLevel : sm.debugLevel;
			
			$buttonOff = new StaticButton(skin.buttonOffSkin, {}, this, dl);
			$buttonOn = new StaticButton(skin.buttonOnSkin, {visible:false}, this, dl);
			
			$buttonOff.debugColor = sm.debugColor;
			$buttonOn.debugColor = sm.debugColor;
			
			this.buttonMode = true;
			this.useHandCursor = true;
			this.focusRect = false;
			this.tabEnabled = false;
			this.isMorphHeightEnabled = false;
			this.isMorphWidthEnabled = false;
			
			$buttonOff.addEventListener(ButtonEvent.RELEASE_INSIDE, _onToggle, false, 0, true);			$buttonOn.addEventListener(ButtonEvent.RELEASE_INSIDE, _onToggle, false, 0, true);
			
			if(skin != null) {
				super(config, parent);
			}
			else {
				throw new Error('No skin defined');
			}
			
			$skin = skin;
		}

		
		
		public function destroy():void {
			$buttonOff.removeEventListener(ButtonEvent.RELEASE_INSIDE, _onToggle);
			
			removeChildren(this, $buttonOff, $buttonOn);
			
			$buttonOff.destroy();			$buttonOn.destroy();
		}

		
		
		public function draw():void {
			$buttonOff.draw();
			$buttonOn.draw();
			
			$buttonOff.visible = !_isChecked;
			$buttonOn.visible = _isChecked;
		}

		
		
		public function forceRelease():void {
			$buttonOff.forceRelease();			$buttonOn.forceRelease();
		}

		
		
		public static function releaseAll():void {
			ButtonCore.releaseAll();
		}

		
		
		override public function get width():Number {
			return $buttonOff.width;
		}

		
		
		override public function set width(value:Number):void {
		}

		
		
		override public function get height():Number {
			return $buttonOff.height;
		}

		
		
		override public function set height(value:Number):void {
		}

		
		
		public function set areEventsEnabled(value:Boolean):void {
			$buttonOff.areEventsEnabled = value;
			$buttonOn.areEventsEnabled = value;
			
			this.buttonMode = value;
			this.useHandCursor = value;
			
			draw();
		}

		
		
		public function get areEventsEnabled():Boolean {
			return $buttonOff.areEventsEnabled;
		}

		
		
		public function get isDown():Boolean {
			return $buttonOff.isDown;
		}

		
		
		public function get isOver():Boolean {
			return $buttonOff.isOver;
		}

		
		
		public function get debugLevel():String {
			return _debugLevel;
		}

		
		
		public function set debugLevel(value:String):void {
			_debugLevel = value;

			$buttonOff.debugLevel = value;
			$buttonOn.debugLevel = value;
		}

		
		
		public function get isChecked():Boolean {
			return _isChecked;
		}
		
		
		
		public function set isChecked(value:Boolean):void {
			_isChecked = value;
			draw();
		}

		
		
		public function get skin():ICheckButtonSkin {
			return $skin;
		}
		
		
		
		public function set skin(skin:ICheckButtonSkin):void {
			$skin = skin;
			
			$buttonOff.skin = skin.buttonOffSkin;
			$buttonOn.skin = skin.buttonOnSkin;
			
			draw();
		}
		
		
		
		public function get button():IButton {
			return (_isChecked) ? $buttonOn : $buttonOff;
		}
		
		
		
		public function get buttonOff():IButton {
			return $buttonOff;
		}
		
		
		
		public function get buttonOn():IButton {
			return $buttonOn;
		}
		
		
		
		private function _onToggle(event:ButtonEvent):void {
			isChecked = !isChecked;
		}
	}
}
