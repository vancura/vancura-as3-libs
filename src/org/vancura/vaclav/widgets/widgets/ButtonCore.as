package org.vancura.vaclav.widgets.widgets {
	import org.vancura.vaclav.core.QSprite;
	import org.vancura.vaclav.core.removeChildren;
	import org.vancura.vaclav.widgets.skin.ButtonSkin;
	import org.vancura.vaclav.widgets.skin.SkinManager;
	import org.vancura.vaclav.widgets.skin.interfaces.IButtonSkin;
	import org.vancura.vaclav.widgets.widgets.events.ButtonEvent;
	import org.vancura.vaclav.widgets.widgets.interfaces.IButton;
	import org.vancura.vaclav.widgets.widgets.interfaces.IWidget;

	import flash.display.DisplayObjectContainer;
	import flash.events.MouseEvent;

	
	
	public class ButtonCore extends Widget implements IWidget, IButton {

		
		
		private static var _currentDrag:ButtonCore;
		
		protected var $skin:IButtonSkin;
		protected var $activeSpr:QSprite;
		
		private var _isOver:Boolean;
		private var _isDown:Boolean;
		private var _areEventsEnabled:Boolean = true;

		
		
		public function ButtonCore(	skin:IButtonSkin,
									config:Object = null,
									parent:DisplayObjectContainer = null,
									debugLevel:String = null) {
										
			if(config == null) config = new Object();
			
			if(skin != null) {
				var sm:SkinManager = SkinManager.getInstance();
				super(config, parent, (debugLevel != null) ? debugLevel : sm.debugLevel);
			}
			else {
				throw new Error('No skin defined');
			}
			
			this.skin = skin;
		}

		
		
		override protected function $init():void {
			super.$init();
			
			this.buttonMode = true;
			this.useHandCursor = true;
			this.focusRect = false;
			this.tabEnabled = false;
		}

		
		
		override protected function $addChildren():void {
			super.$addChildren();
			
			$activeSpr = new QSprite({alpha:0}, $contentSpr);
			
			$activeSpr.addEventListener(MouseEvent.MOUSE_OVER, _onOver, false, 0, true);
			$activeSpr.addEventListener(MouseEvent.MOUSE_OUT, _onOut, false, 0, true);
			$activeSpr.addEventListener(MouseEvent.MOUSE_DOWN, _onPress, false, 0, true);
			$activeSpr.addEventListener(MouseEvent.MOUSE_UP, _onRelease, false, 0, true);
		}

		
		
		override protected function $removeChildren():void {
			super.$removeChildren();
			
			removeChildren($contentSpr, $activeSpr);
		}

		
		
		public function forceRelease():void {
			if(_isDown) {
				_currentDrag = null;
				_isDown = false;
				$releasedOutsideTween();
				dispatchEvent(new ButtonEvent(ButtonEvent.RELEASE_OUTSIDE, true));
			}
		}

		
		
		public static function releaseAll():void {
			for each(var b:IWidget in $allWidgets) {
				if(b is ButtonCore) (b as ButtonCore).forceRelease();
			}
		}
		
		
		
		public function get skin():IButtonSkin {
			return $skin;
		}

		
		
		public function set skin(skin:IButtonSkin):void {
			$skin = skin as ButtonSkin;
			
			if($width == 0) $width = $skin.assetWidth;
			if($height == 0) $height = $skin.assetHeight;
			if($skin.assetWidth != 0 && $skin.assetHeight != 0) setSize($skin.assetWidth, $skin.assetHeight);
			
			draw();
		}

		
		
		public function set areEventsEnabled(value:Boolean):void {
			_areEventsEnabled = value;
			
			$activeSpr.mouseEnabled = value;
			this.buttonMode = value;
			this.useHandCursor = value;
			
			if(!value) forceRelease();
		}

		
		
		public function get areEventsEnabled():Boolean {
			return _areEventsEnabled;
		}

		
		
		public function get isDown():Boolean {
			return _isDown;
		}

		
		
		public function get isOver():Boolean {
			return _isOver;
		}

		
		
		protected function $hoverInTween():void {
		}

		
		
		protected function $hoverOutTween():void {
		}

		
		
		protected function $focusInTween():void {
		}

		
		
		protected function $dragConfirmedTween():void {
		}

		
		
		protected function $releasedInsideTween():void {
		}

		
		
		protected function $releasedOutsideTween():void {
		}

		
		
		private function _onOver(event:MouseEvent):void {
			if(_areEventsEnabled) {
				if(event.buttonDown) {
					// drag over
					dispatchEvent(new ButtonEvent(ButtonEvent.DRAG_OVER, true));
				}
				else {
					// roll over
					_isOver = true;
					$hoverInTween();
					dispatchEvent(new ButtonEvent(ButtonEvent.HOVER_IN, true));
				}
			}
		}

		
		
		private function _onOut(event:MouseEvent):void {
			if(_areEventsEnabled) {
				if(event.buttonDown) {
					// drag out
					dispatchEvent(new ButtonEvent(ButtonEvent.DRAG_OUT, true));
				}
				else {
					// roll out
					_isOver = false;
					$hoverOutTween();
					dispatchEvent(new ButtonEvent(ButtonEvent.HOVER_OUT, true));
				}
			}
		}

		
		
		private function _onPress(event:MouseEvent):void {
			if(_areEventsEnabled) {
				_isDown = true;
				_currentDrag = this;
				$focusInTween();
				stage.addEventListener(MouseEvent.MOUSE_UP, _onRelease, false, 0, true);
				dispatchEvent(new ButtonEvent(ButtonEvent.FOCUS_IN, true));
			}
		}

		
		
		private function _onRelease(event:MouseEvent):void {
			stage.removeEventListener(MouseEvent.MOUSE_UP, _onRelease);
			
			if(_areEventsEnabled && _isDown) {
				if(event.currentTarget == stage) {
					// release outside
					forceRelease();
				}
				
				else if(_currentDrag != this) {
					// drag confirm
					$dragConfirmedTween();
					dispatchEvent(new ButtonEvent(ButtonEvent.DRAG_CONFIRM, true));
				}
				
				else {
					// release inside
					_currentDrag = null;
					$releasedInsideTween();
					dispatchEvent(new ButtonEvent(ButtonEvent.RELEASE_INSIDE, true));
				}
	
				dispatchEvent(new MouseEvent(MouseEvent.MOUSE_UP, true));
			}
		}
	}
}