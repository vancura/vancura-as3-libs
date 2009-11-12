package org.vancura.vaclav.widgets.widgets {
	import com.greensock.TweenMax;

	import org.bytearray.display.ScaleBitmap;
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
		private var _hoverSBM:ScaleBitmap;
		private var _focusSBM:ScaleBitmap;

		
		
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
			_hoverSBM = new ScaleBitmap();
			_focusSBM = new ScaleBitmap();
			
			_hoverSBM.alpha = 0;
			_focusSBM.alpha = 0;
			
			addChildren($contentSpr, _backSBM, _hoverSBM, _focusSBM);
		}

		
		
		override protected function $removeChildren():void {
			super.$removeChildren();
			
			removeChildren($contentSpr, _backSBM, _hoverSBM, _focusSBM);
		}

		
		
		override public function draw():void {
			super.draw();
			
			_backSBM.bitmapData = $skin.backBD;
			_hoverSBM.bitmapData = $skin.hoverBD;
			_focusSBM.bitmapData = $skin.focusBD;

			var rect:Rectangle = $skin.guideBD.getColorBoundsRect(0x00FF0000, 0x00000000, false);
			_backSBM.scale9Grid = rect;			_hoverSBM.scale9Grid = rect;			_focusSBM.scale9Grid = rect;
			
			if($width != 0) {
				_backSBM.width = $width;
				_hoverSBM.width = $width;
				_focusSBM.width = $width;
			}
			if($height != 0) {
				_backSBM.height = $height;
				_hoverSBM.height = $height;
				_focusSBM.height = $height;
			}
			
			$activeSpr.graphics.clear();
			Drawing.drawRect($activeSpr, 0, 0, $width, $height);
		}

		
		
		override protected function $hoverInTween():void {
			new TweenMax(_backSBM, $skin.hoverInDuration, {alpha:0, ease:Sine.easeIn});
			new TweenMax(_hoverSBM, $skin.hoverInDuration, {alpha:1, ease:Sine.easeOut});
			new TweenMax(_focusSBM, $skin.hoverInDuration, {alpha:0, ease:Sine.easeIn});
		}

		
		
		override protected function $hoverOutTween():void {
			new TweenMax(_backSBM, $skin.hoverOutDuration, {alpha:1, ease:Sine.easeOut});
			new TweenMax(_hoverSBM, $skin.hoverOutDuration, {alpha:0, ease:Sine.easeIn});		
			new TweenMax(_focusSBM, $skin.hoverOutDuration, {alpha:0, ease:Sine.easeIn});
		}

		
		
		override protected function $focusInTween():void {
			new TweenMax(_backSBM, $skin.focusInDuration, {alpha:0, ease:Sine.easeIn});
			new TweenMax(_hoverSBM, $skin.focusInDuration, {alpha:0, ease:Sine.easeIn});		
			new TweenMax(_focusSBM, $skin.focusInDuration, {alpha:1, ease:Sine.easeOut});
		}

		
		
		override protected function $dragConfirmedTween():void {
			new TweenMax(_backSBM, $skin.hoverInDuration, {alpha:0, ease:Sine.easeIn});
			new TweenMax(_hoverSBM, $skin.hoverInDuration, {alpha:1, ease:Sine.easeOut});
			new TweenMax(_focusSBM, $skin.hoverInDuration, {alpha:0, ease:Sine.easeIn});
		}

		
		
		override protected function $releasedInsideTween():void {
			new TweenMax(_backSBM, $skin.focusOutDuration, {alpha:0, ease:Sine.easeIn});
			new TweenMax(_hoverSBM, $skin.focusOutDuration, {alpha:1, ease:Sine.easeOut});
			new TweenMax(_focusSBM, $skin.focusOutDuration, {alpha:0, ease:Sine.easeIn});
		}

		
		
		override protected function $releasedOutsideTween():void {
			new TweenMax(_backSBM, $skin.focusOutDuration, {alpha:1, ease:Sine.easeOut});
			new TweenMax(_hoverSBM, $skin.focusOutDuration, {alpha:0, ease:Sine.easeIn});		
			new TweenMax(_focusSBM, $skin.focusOutDuration, {alpha:0, ease:Sine.easeIn});
		}
	}
}
