package org.vancura.vaclav.widgets.widgets {
	import com.greensock.TweenMax;
	import com.greensock.easing.Sine;

	import org.vancura.vaclav.core.MorphSprite;
	import org.vancura.vaclav.core.removeChildren;
	import org.vancura.vaclav.widgets.constants.MouseStatus;
	import org.vancura.vaclav.widgets.events.ButtonEvent;
	import org.vancura.vaclav.widgets.globals.SkinManager;
	import org.vancura.vaclav.widgets.interfaces.IButton;
	import org.vancura.vaclav.widgets.interfaces.IGlyphButton;
	import org.vancura.vaclav.widgets.interfaces.IGlyphButtonSkin;
	import org.vancura.vaclav.widgets.interfaces.IImage;

	import flash.display.DisplayObjectContainer;

	
	
	public class GlyphButton extends MorphSprite implements IGlyphButton {

		
		
		protected var $skin:IGlyphButtonSkin;		
		protected var $button:ScaleButton;
		protected var $glyphOut:Image;		protected var $glyphHover:Image;		protected var $glyphFocus:Image;

		private var _debugLevel:String;

		
		
		public function GlyphButton(	skin:IGlyphButtonSkin,
										config:Object = null,
										parent:DisplayObjectContainer = null,
										debugLevel:String = null) {
										
			if(config == null) {
				config = new Object();
			}
			
			var dl:String = (debugLevel != null) ? debugLevel : SkinManager.debugLevel;
			
			$button = new ScaleButton(skin.buttonSkin, {}, this, dl);
			$glyphOut = new Image(skin.glyphsSkin.glyphOutSkin, {mouseEnabled:false, mouseChildren:false}, this, dl);			$glyphHover = new Image(skin.glyphsSkin.glyphHoverSkin, {alpha:0, mouseEnabled:false, mouseChildren:false}, this, dl);			$glyphFocus = new Image(skin.glyphsSkin.glyphFocusSkin, {alpha:0, mouseEnabled:false, mouseChildren:false}, this, dl);
			$button.debugColor = SkinManager.debugColor;
			$glyphOut.debugColor = SkinManager.debugColor;			$glyphHover.debugColor = SkinManager.debugColor;			$glyphFocus.debugColor = SkinManager.debugColor;
			
			this.skin = skin;
			this.buttonMode = true;
			this.useHandCursor = true;
			this.focusRect = false;
			this.tabEnabled = false;
			
			$button.addEventListener(ButtonEvent.HOVER_IN_TWEEN, _onButtonHoverInTween, false, 0, true);			$button.addEventListener(ButtonEvent.HOVER_OUT_TWEEN, _onButtonHoverOutTween, false, 0, true);			$button.addEventListener(ButtonEvent.FOCUS_IN_TWEEN, _onButtonFocusInTween, false, 0, true);			$button.addEventListener(ButtonEvent.DRAG_CONFIRMED_TWEEN, _onButtonDragConfirmedTween, false, 0, true);			$button.addEventListener(ButtonEvent.RELEASED_INSIDE_TWEEN, _onButtonReleasedInsideTween, false, 0, true);			$button.addEventListener(ButtonEvent.RELEASED_OUTSIDE_TWEEN, _onButtonReleasedOutsideTween, false, 0, true);			
			if(config.width == undefined) {
				config.width = skin.buttonSkin.assetWidth;
			}
			
			if(config.height == undefined) {
				config.height = skin.buttonSkin.assetHeight;
			}
			
			if(skin != null) {
				super(config, parent);
			}
			else {
				throw new Error('No skin defined');
			}
			
			$skin = skin;
		}

		
		
		public function destroy():void {
			$button.removeEventListener(ButtonEvent.HOVER_IN_TWEEN, _onButtonHoverInTween);
			$button.removeEventListener(ButtonEvent.HOVER_OUT_TWEEN, _onButtonHoverOutTween);
			$button.removeEventListener(ButtonEvent.FOCUS_IN_TWEEN, _onButtonFocusInTween);
			$button.removeEventListener(ButtonEvent.DRAG_CONFIRMED_TWEEN, _onButtonDragConfirmedTween);
			$button.removeEventListener(ButtonEvent.RELEASED_INSIDE_TWEEN, _onButtonReleasedInsideTween);
			$button.removeEventListener(ButtonEvent.RELEASED_OUTSIDE_TWEEN, _onButtonReleasedOutsideTween);
			
			removeChildren(this, $button, $glyphOut, $glyphHover, $glyphFocus);
			
			$button.destroy();
			$glyphOut.destroy();			$glyphHover.destroy();			$glyphFocus.destroy();
		}

		
		
		public function draw():void {
			$button.draw();
			$glyphOut.draw();			$glyphHover.draw();			$glyphFocus.draw();
		}

		
		
		public function forceRelease():void {
			$button.forceRelease();
		}

		
		
		public static function releaseAll():void {
			ButtonCore.releaseAll();
		}

		
		
		public function get skin():IGlyphButtonSkin {
			return $skin;
		}

		
		
		public function set skin(skin:IGlyphButtonSkin):void {
			$skin = skin;
			
			$button.skin = $skin.buttonSkin;
			$glyphOut.skin = $skin.glyphsSkin.glyphOutSkin;			$glyphHover.skin = $skin.glyphsSkin.glyphHoverSkin;			$glyphFocus.skin = $skin.glyphsSkin.glyphFocusSkin;
			
			draw();
		}

		
		
		override public function get width():Number {
			return $button.width;
		}

		
		
		override public function set width(value:Number):void {
			$button.width = value;
			$glyphOut.x = Math.round((value - $glyphOut.width) / 2);
			$glyphHover.x = Math.round((value - $glyphHover.width) / 2);
			$glyphFocus.x = Math.round((value - $glyphFocus.width) / 2);
			
			draw();
		}

		
		
		override public function get height():Number {
			return $button.height;
		}

		
		
		override public function set height(value:Number):void {
			$button.height = value;
			$glyphOut.y = Math.round((value - $glyphOut.height) / 2);			$glyphHover.y = Math.round((value - $glyphHover.height) / 2);			$glyphFocus.y = Math.round((value - $glyphFocus.height) / 2);
			
			draw();
		}

		
		
		public function set areEventsEnabled(value:Boolean):void {
			$button.areEventsEnabled = value;
			this.buttonMode = value;
			this.useHandCursor = value;
			
			draw();
		}

		
		
		public function get areEventsEnabled():Boolean {
			return $button.areEventsEnabled;
		}

		
		
		public function get mouseStatus():String {
			return $button.mouseStatus;
		}

		
		
		public function get debugLevel():String {
			return _debugLevel;
		}

		
		
		public function set debugLevel(value:String):void {
			_debugLevel = value;
			$button.debugLevel = value;
			$glyphOut.debugLevel = value;			$glyphHover.debugLevel = value;			$glyphFocus.debugLevel = value;
		}

		
		
		public function get glyph():IImage {
			if($button.mouseStatus == MouseStatus.OUT) return $glyphOut;
			if($button.mouseStatus == MouseStatus.HOVER) return $glyphHover;
			if($button.mouseStatus == MouseStatus.FOCUS) return $glyphFocus;
			
			return null;
		}
		
		
		
		public function get glyphOut():IImage {
			return $glyphOut;
		}
		
		
		
		public function get glyphHover():IImage {
			return $glyphHover;
		}
		
		
		
		public function get glyphFocus():IImage {
			return $glyphFocus;
		}
		
		
		
		public function get button():IButton {
			return $button;
		}
		
		
		
		private function _onButtonHoverInTween(event:ButtonEvent):void {
			new TweenMax($glyphOut, $skin.buttonSkin.hoverInDuration, {alpha:0, ease:Sine.easeIn});
			new TweenMax($glyphHover, $skin.buttonSkin.hoverInDuration, {alpha:1, ease:Sine.easeOut});
			new TweenMax($glyphFocus, $skin.buttonSkin.hoverInDuration, {alpha:0, ease:Sine.easeIn});
		}

		
		
		private function _onButtonHoverOutTween(event:ButtonEvent):void {
			new TweenMax($glyphOut, $skin.buttonSkin.hoverOutDuration, {alpha:1, ease:Sine.easeOut});
			new TweenMax($glyphHover, $skin.buttonSkin.hoverOutDuration, {alpha:0, ease:Sine.easeIn});		
			new TweenMax($glyphFocus, $skin.buttonSkin.hoverOutDuration, {alpha:0, ease:Sine.easeIn});
		}

		

		private function _onButtonFocusInTween(event:ButtonEvent):void {
			new TweenMax($glyphOut, $skin.buttonSkin.focusInDuration, {alpha:0, ease:Sine.easeIn});
			new TweenMax($glyphHover, $skin.buttonSkin.focusInDuration, {alpha:0, ease:Sine.easeIn});		
			new TweenMax($glyphFocus, $skin.buttonSkin.focusInDuration, {alpha:1, ease:Sine.easeOut});
		}
		
		
		
		private function _onButtonDragConfirmedTween(event:ButtonEvent):void {
			new TweenMax($glyphOut, $skin.buttonSkin.hoverInDuration, {alpha:0, ease:Sine.easeIn});
			new TweenMax($glyphHover, $skin.buttonSkin.hoverInDuration, {alpha:1, ease:Sine.easeOut});
			new TweenMax($glyphFocus, $skin.buttonSkin.hoverInDuration, {alpha:0, ease:Sine.easeIn});
		}

		
		
		private function _onButtonReleasedInsideTween(event:ButtonEvent):void {
			new TweenMax($glyphOut, $skin.buttonSkin.focusOutDuration, {alpha:0, ease:Sine.easeIn});
			new TweenMax($glyphHover, $skin.buttonSkin.focusOutDuration, {alpha:1, ease:Sine.easeOut});
			new TweenMax($glyphFocus, $skin.buttonSkin.focusOutDuration, {alpha:0, ease:Sine.easeIn});
		}

		
		
		private function _onButtonReleasedOutsideTween(event:ButtonEvent):void {
			new TweenMax($glyphOut, $skin.buttonSkin.focusOutDuration, {alpha:1, ease:Sine.easeOut});
			new TweenMax($glyphHover, $skin.buttonSkin.focusOutDuration, {alpha:0, ease:Sine.easeIn});		
			new TweenMax($glyphFocus, $skin.buttonSkin.focusOutDuration, {alpha:0, ease:Sine.easeIn});
		}
	}
}
