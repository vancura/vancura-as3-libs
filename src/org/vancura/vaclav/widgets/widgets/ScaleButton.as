package org.vancura.vaclav.widgets.widgets {
	import com.greensock.TweenMax;

	import org.vancura.vaclav.core.Drawing;
	import org.vancura.vaclav.core.addChildren;
	import org.vancura.vaclav.core.removeChildren;
	import org.vancura.vaclav.widgets.skin.SkinManager;
	import org.vancura.vaclav.widgets.skin.interfaces.IButtonSkin;
	import org.vancura.vaclav.widgets.widgets.interfaces.IButton;
	import org.vancura.vaclav.widgets.widgets.interfaces.IWidget;

	import mx.effects.easing.Sine;

	import flash.display.DisplayObjectContainer;
	import flash.geom.Rectangle;

	
	
	public class ScaleButton extends ButtonCore implements IWidget, IButton {

		
		
		private var _backSBM:ScaleBitmap;
		private var _hoveredSBM:ScaleBitmap;
		private var _pressedSBM:ScaleBitmap;

		
		
		public function ScaleButton(	skin:IButtonSkin,
										config:Object = null,
										parent:DisplayObjectContainer = null,
										debugLevel:String = null) {
											
			if(config == null) config = new Object();
			
			var sm:SkinManager = SkinManager.getInstance();
			super(skin, config, parent, (debugLevel != null) ? debugLevel : sm.debugLevel);
		}

		
		
		override protected function $init():void {
			super.$init();
			
			isMorphWidthEnabled = true;
			isMorphHeightEnabled = true;
			isChangeWidthEnabled = true;
			isChangeHeightEnabled = true;
		}

		
		
		override protected function $addChildren():void {
			super.$addChildren();
			
			_backSBM = new ScaleBitmap();
			_hoveredSBM = new ScaleBitmap();
			_pressedSBM = new ScaleBitmap();
			
			_hoveredSBM.alpha = 0;
			_pressedSBM.alpha = 0;
			
			addChildren($contentSpr, _backSBM, _hoveredSBM, _pressedSBM);
		}

		
		
		override protected function $removeChildren():void {
			super.$removeChildren();
			
			removeChildren($contentSpr, _backSBM, _hoveredSBM, _pressedSBM);
		}

		
		
		override public function draw():void {
			super.draw();
			
			_backSBM.bitmapData = $skin.backBD;
			_hoveredSBM.bitmapData = $skin.hoveredBD;
			_pressedSBM.bitmapData = $skin.pressedBD;

			var rect:Rectangle = $skin.guideBD.getColorBoundsRect(0x00FF0000, 0x00000000, false);
			_backSBM.scale9Grid = rect;			_hoveredSBM.scale9Grid = rect;			_pressedSBM.scale9Grid = rect;
			
			if($width != 0) {
				_backSBM.width = $width;
				_hoveredSBM.width = $width;
				_pressedSBM.width = $width;
			}
			if($height != 0) {
				_backSBM.height = $height;
				_hoveredSBM.height = $height;
				_pressedSBM.height = $height;
			}
			
			$activeSpr.graphics.clear();
			Drawing.drawRect($activeSpr, 0, 0, $width, $height);
		}

		
		
		override protected function $hoveredInTween():void {
			new TweenMax(_backSBM, $skin.hoveredInDuration, {alpha:0, ease:Sine.easeIn});
			new TweenMax(_hoveredSBM, $skin.hoveredInDuration, {alpha:1, ease:Sine.easeOut});
			new TweenMax(_pressedSBM, $skin.hoveredInDuration, {alpha:0, ease:Sine.easeIn});
		}

		
		
		override protected function $hoveredOutTween():void {
			new TweenMax(_backSBM, $skin.hoveredOutDuration, {alpha:1, ease:Sine.easeOut});
			new TweenMax(_hoveredSBM, $skin.hoveredOutDuration, {alpha:0, ease:Sine.easeIn});		
			new TweenMax(_pressedSBM, $skin.hoveredOutDuration, {alpha:0, ease:Sine.easeIn});
		}

		
		
		override protected function $pressedInTween():void {
			new TweenMax(_backSBM, $skin.pressedInDuration, {alpha:0, ease:Sine.easeIn});
			new TweenMax(_hoveredSBM, $skin.pressedInDuration, {alpha:0, ease:Sine.easeIn});		
			new TweenMax(_pressedSBM, $skin.pressedInDuration, {alpha:1, ease:Sine.easeOut});
		}

		
		
		override protected function $dragConfirmedTween():void {
			new TweenMax(_backSBM, $skin.hoveredInDuration, {alpha:0, ease:Sine.easeIn});
			new TweenMax(_hoveredSBM, $skin.hoveredInDuration, {alpha:1, ease:Sine.easeOut});
			new TweenMax(_pressedSBM, $skin.hoveredInDuration, {alpha:0, ease:Sine.easeIn});
		}

		
		
		override protected function $releasedInsideTween():void {
			new TweenMax(_backSBM, $skin.pressedOutDuration, {alpha:0, ease:Sine.easeIn});
			new TweenMax(_hoveredSBM, $skin.pressedOutDuration, {alpha:1, ease:Sine.easeOut});
			new TweenMax(_pressedSBM, $skin.pressedOutDuration, {alpha:0, ease:Sine.easeIn});
		}

		
		
		override protected function $releasedOutsideTween():void {
			new TweenMax(_backSBM, $skin.pressedOutDuration, {alpha:1, ease:Sine.easeOut});
			new TweenMax(_hoveredSBM, $skin.pressedOutDuration, {alpha:0, ease:Sine.easeIn});		
			new TweenMax(_pressedSBM, $skin.pressedOutDuration, {alpha:0, ease:Sine.easeIn});
		}
	}
}
