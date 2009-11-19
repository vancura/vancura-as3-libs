package org.vancura.vaclav.widgets.widgets {
	import com.greensock.TweenMax;
	import com.greensock.easing.Sine;

	import org.vancura.vaclav.core.MorphSprite;
	import org.vancura.vaclav.core.removeChildren;
	import org.vancura.vaclav.widgets.constants.Align;
	import org.vancura.vaclav.widgets.constants.MouseStatus;
	import org.vancura.vaclav.widgets.events.ButtonEvent;
	import org.vancura.vaclav.widgets.globals.SkinManager;
	import org.vancura.vaclav.widgets.interfaces.IButton;
	import org.vancura.vaclav.widgets.interfaces.IGlyphLabelButton;
	import org.vancura.vaclav.widgets.interfaces.IGlyphLabelButtonSkin;
	import org.vancura.vaclav.widgets.interfaces.IImage;
	import org.vancura.vaclav.widgets.interfaces.ILabel;

	import flash.display.DisplayObjectContainer;

	
	
	public class GlyphLabelButton extends MorphSprite implements IGlyphLabelButton {

		
		
		protected var $skin:IGlyphLabelButtonSkin;		
		protected var $button:ScaleButton;
		protected var $glyphOut:Image;		protected var $glyphHover:Image;		protected var $glyphFocus:Image;
		protected var $labelOut:Label;
		protected var $labelHover:Label;
		protected var $labelFocus:Label;

		private var _debugLevel:String;

		
		
		public function GlyphLabelButton(	skin:IGlyphLabelButtonSkin,
											config:Object = null,
											text:String = '',
											parent:DisplayObjectContainer = null,
											debugLevel:String = null) {
										
			if(config == null) {
				config = new Object();
			}
			
			var dl:String = (debugLevel != null) ? debugLevel : SkinManager.debugLevel;
			
			$button = new ScaleButton(skin.buttonSkin, {}, this, dl);
			$glyphOut = new Image(skin.glyphsSkin.glyphOutSkin, {mouseEnabled:false, mouseChildren:false}, this, dl);			$glyphHover = new Image(skin.glyphsSkin.glyphHoverSkin, {alpha:0, mouseEnabled:false, mouseChildren:false}, this, dl);			$glyphFocus = new Image(skin.glyphsSkin.glyphFocusSkin, {alpha:0, mouseEnabled:false, mouseChildren:false}, this, dl);
			$labelOut = new Label(skin.labelOutSkin, {mouseEnabled:false, mouseChildren:false}, '', this, dl);
			$labelHover = new Label(skin.labelHoverSkin, {alpha:0, mouseEnabled:false, mouseChildren:false}, '', this, dl);
			$labelFocus = new Label(skin.labelFocusSkin, {alpha:0, mouseEnabled:false, mouseChildren:false}, '', this, dl);
			$button.debugColor = SkinManager.debugColor;
			$glyphOut.debugColor = SkinManager.debugColor;			$glyphHover.debugColor = SkinManager.debugColor;			$glyphFocus.debugColor = SkinManager.debugColor;
			$labelOut.debugColor = SkinManager.debugColor;
			$labelHover.debugColor = SkinManager.debugColor;
			$labelFocus.debugColor = SkinManager.debugColor;
			
			this.skin = skin;
			this.text = text;
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
			
			removeChildren(this, $button, $glyphOut, $glyphHover, $glyphFocus, $labelOut, $labelHover, $labelFocus);
			
			$button.destroy();
			$glyphOut.destroy();			$glyphHover.destroy();			$glyphFocus.destroy();
			$labelOut.destroy();
			$labelHover.destroy();
			$labelFocus.destroy();
		}

		
		
		public function draw():void {
			$button.draw();
			$glyphOut.draw();			$glyphHover.draw();			$glyphFocus.draw();
			$labelOut.draw();
			$labelHover.draw();
			$labelFocus.draw();
		}

		
		
		public function forceRelease():void {
			$button.forceRelease();
		}

		
		
		public static function releaseAll():void {
			ButtonCore.releaseAll();
		}

		
		
		public function get skin():IGlyphLabelButtonSkin {
			return $skin;
		}

		
		
		public function set skin(skin:IGlyphLabelButtonSkin):void {
			$skin = skin;
			
			$skin.labelOutSkin.hAlign = Align.LEFT;
			$skin.labelHoverSkin.hAlign = Align.LEFT;
			$skin.labelFocusSkin.hAlign = Align.LEFT;
			
			$button.skin = $skin.buttonSkin;
			$glyphOut.skin = $skin.glyphsSkin.glyphOutSkin;			$glyphHover.skin = $skin.glyphsSkin.glyphHoverSkin;			$glyphFocus.skin = $skin.glyphsSkin.glyphFocusSkin;
			$labelOut.skin = $skin.labelOutSkin;
			$labelHover.skin = $skin.labelHoverSkin;
			$labelFocus.skin = $skin.labelFocusSkin;
			
			draw();
		}

		
		
		override public function get width():Number {
			return $button.width;
		}

		
		
		override public function set width(value:Number):void {
			var outWidth:int = $glyphOut.width + $labelOut.width;
			var hoverWidth:int = $glyphHover.width + $labelHover.width;
			var focusWidth:int = $glyphFocus.width + $labelFocus.width;
			var maxWidth:int = Math.max(outWidth, hoverWidth, focusWidth);
			
			$button.width = value;
			$glyphOut.x = Math.round((value - maxWidth) / 2);
			$glyphHover.x = Math.round((value - maxWidth) / 2);
			$glyphFocus.x = Math.round((value - maxWidth) / 2);
			$labelOut.x = $glyphOut.x + $glyphOut.width;
			$labelHover.x = $glyphHover.x + $glyphHover.width;
			$labelFocus.x = $glyphFocus.x + $glyphFocus.width;
			
			draw();
		}

		
		
		override public function get height():Number {
			return $button.height;
		}

		
		
		override public function set height(value:Number):void {
			$button.height = value;
			$glyphOut.y = Math.round((value - $glyphOut.height) / 2);			$glyphHover.y = Math.round((value - $glyphHover.height) / 2);			$glyphFocus.y = Math.round((value - $glyphFocus.height) / 2);
			$labelOut.y = Math.round((value - $labelOut.height) / 2);
			$labelHover.y = Math.round((value - $labelHover.height) / 2);
			$labelFocus.y = Math.round((value - $labelFocus.height) / 2);
			
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

		
		
		public function set mouseStatus(value:String):void {
			$button.mouseStatus = value;
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
		
		
		
		public function get text():String {
			return $labelOut.text;
		}

		
		
		public function set text(value:String):void {
			$labelOut.text = value;
			$labelHover.text = value;
			$labelFocus.text = value;
			
			draw();
		}
		
		
		
		public function get label():ILabel {
			if($button.mouseStatus == MouseStatus.OUT) return $labelOut;
			if($button.mouseStatus == MouseStatus.HOVER) return $labelHover;
			if($button.mouseStatus == MouseStatus.FOCUS) return $labelFocus;
			
			return null;
		}
		
		
		
		public function get labelOut():ILabel {
			return $labelOut;
		}
		
		
		
		public function get labelHover():ILabel {
			return $labelHover;
		}
		
		
		
		public function get labelFocus():ILabel {
			return $labelFocus;
		}
		
		
		
		public function get button():IButton {
			return $button;
		}
		
		
		
		private function _onButtonHoverInTween(event:ButtonEvent):void {
			new TweenMax($glyphOut, $skin.buttonSkin.hoverInDuration, {alpha:0, ease:Sine.easeIn});
			new TweenMax($glyphHover, $skin.buttonSkin.hoverInDuration, {alpha:1, ease:Sine.easeOut});
			new TweenMax($glyphFocus, $skin.buttonSkin.hoverInDuration, {alpha:0, ease:Sine.easeIn});
			new TweenMax($labelOut, $skin.buttonSkin.hoverInDuration, {alpha:0, ease:Sine.easeIn});
			new TweenMax($labelHover, $skin.buttonSkin.hoverInDuration, {alpha:1, ease:Sine.easeOut});
			new TweenMax($labelFocus, $skin.buttonSkin.hoverInDuration, {alpha:0, ease:Sine.easeIn});
		}

		
		
		private function _onButtonHoverOutTween(event:ButtonEvent):void {
			new TweenMax($glyphOut, $skin.buttonSkin.hoverOutDuration, {alpha:1, ease:Sine.easeOut});
			new TweenMax($glyphHover, $skin.buttonSkin.hoverOutDuration, {alpha:0, ease:Sine.easeIn});		
			new TweenMax($glyphFocus, $skin.buttonSkin.hoverOutDuration, {alpha:0, ease:Sine.easeIn});
			new TweenMax($labelOut, $skin.buttonSkin.hoverOutDuration, {alpha:1, ease:Sine.easeOut});
			new TweenMax($labelHover, $skin.buttonSkin.hoverOutDuration, {alpha:0, ease:Sine.easeIn});		
			new TweenMax($labelFocus, $skin.buttonSkin.hoverOutDuration, {alpha:0, ease:Sine.easeIn});
		}

		

		private function _onButtonFocusInTween(event:ButtonEvent):void {
			new TweenMax($glyphOut, $skin.buttonSkin.focusInDuration, {alpha:0, ease:Sine.easeIn});
			new TweenMax($glyphHover, $skin.buttonSkin.focusInDuration, {alpha:0, ease:Sine.easeIn});		
			new TweenMax($glyphFocus, $skin.buttonSkin.focusInDuration, {alpha:1, ease:Sine.easeOut});
			new TweenMax($labelOut, $skin.buttonSkin.focusInDuration, {alpha:0, ease:Sine.easeIn});
			new TweenMax($labelHover, $skin.buttonSkin.focusInDuration, {alpha:0, ease:Sine.easeIn});		
			new TweenMax($labelFocus, $skin.buttonSkin.focusInDuration, {alpha:1, ease:Sine.easeOut});
		}
		
		
		
		private function _onButtonDragConfirmedTween(event:ButtonEvent):void {
			new TweenMax($glyphOut, $skin.buttonSkin.hoverInDuration, {alpha:0, ease:Sine.easeIn});
			new TweenMax($glyphHover, $skin.buttonSkin.hoverInDuration, {alpha:1, ease:Sine.easeOut});
			new TweenMax($glyphFocus, $skin.buttonSkin.hoverInDuration, {alpha:0, ease:Sine.easeIn});
			new TweenMax($labelOut, $skin.buttonSkin.hoverInDuration, {alpha:0, ease:Sine.easeIn});
			new TweenMax($labelHover, $skin.buttonSkin.hoverInDuration, {alpha:1, ease:Sine.easeOut});
			new TweenMax($labelFocus, $skin.buttonSkin.hoverInDuration, {alpha:0, ease:Sine.easeIn});
		}

		
		
		private function _onButtonReleasedInsideTween(event:ButtonEvent):void {
			new TweenMax($glyphOut, $skin.buttonSkin.focusOutDuration, {alpha:0, ease:Sine.easeIn});
			new TweenMax($glyphHover, $skin.buttonSkin.focusOutDuration, {alpha:1, ease:Sine.easeOut});
			new TweenMax($glyphFocus, $skin.buttonSkin.focusOutDuration, {alpha:0, ease:Sine.easeIn});
			new TweenMax($labelOut, $skin.buttonSkin.focusOutDuration, {alpha:0, ease:Sine.easeIn});
			new TweenMax($labelHover, $skin.buttonSkin.focusOutDuration, {alpha:1, ease:Sine.easeOut});
			new TweenMax($labelFocus, $skin.buttonSkin.focusOutDuration, {alpha:0, ease:Sine.easeIn});
		}

		
		
		private function _onButtonReleasedOutsideTween(event:ButtonEvent):void {
			new TweenMax($glyphOut, $skin.buttonSkin.focusOutDuration, {alpha:1, ease:Sine.easeOut});
			new TweenMax($glyphHover, $skin.buttonSkin.focusOutDuration, {alpha:0, ease:Sine.easeIn});		
			new TweenMax($glyphFocus, $skin.buttonSkin.focusOutDuration, {alpha:0, ease:Sine.easeIn});
			new TweenMax($labelOut, $skin.buttonSkin.focusOutDuration, {alpha:1, ease:Sine.easeOut});
			new TweenMax($labelHover, $skin.buttonSkin.focusOutDuration, {alpha:0, ease:Sine.easeIn});		
			new TweenMax($labelFocus, $skin.buttonSkin.focusOutDuration, {alpha:0, ease:Sine.easeIn});
		}
	}
}
