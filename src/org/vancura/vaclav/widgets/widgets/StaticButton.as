package org.vancura.vaclav.widgets.widgets {
	import com.greensock.TweenMax;
	import com.greensock.easing.Sine;

	import org.vancura.vaclav.core.GraphicsUtil;
	import org.vancura.vaclav.core.QBitmap;
	import org.vancura.vaclav.core.removeChildren;
	import org.vancura.vaclav.widgets.interfaces.IButton;
	import org.vancura.vaclav.widgets.interfaces.IButtonSkin;
	import org.vancura.vaclav.widgets.interfaces.IWidget;
	import org.vancura.vaclav.widgets.globals.SkinManager;

	import flash.display.DisplayObjectContainer;

	
	
	public class StaticButton extends ButtonCore implements IWidget, IButton {

		
		
		private var _backBM:QBitmap;
		private var _hoverBM:QBitmap;
		private var _focusBM:QBitmap;

		
		
		public function StaticButton(	skin:IButtonSkin,
										config:Object = null,
										parent:DisplayObjectContainer = null,
										debugLevel:String = null) {
											
			if(config == null) config = new Object();
			
			super(skin, config, parent, (debugLevel != null) ? debugLevel : SkinManager.debugLevel);
		}

		
		
		override protected function $init():void {
			super.$init();
			
			isMorphWidthEnabled = false;
			isMorphHeightEnabled = false;
			isChangeWidthEnabled = false;
			isChangeHeightEnabled = false;
		}

		
		
		override protected function $addChildren():void {
			super.$addChildren();
			
			_backBM = new QBitmap({}, $contentSpr);
			_hoverBM = new QBitmap({alpha:0}, $contentSpr);
			_focusBM = new QBitmap({alpha:0}, $contentSpr);
		}

		
		
		override protected function $removeChildren():void {
			super.$removeChildren();
			
			removeChildren($contentSpr, _backBM, _hoverBM, _focusBM);
		}

		
		
		override public function draw():void {
			super.draw();
			
			_backBM.bitmapData = $skin.backBD;
			_hoverBM.bitmapData = $skin.hoverBD;
			_focusBM.bitmapData = $skin.focusBD;
			
			$activeSpr.graphics.clear();
			GraphicsUtil.drawRect($activeSpr, 0, 0, $skin.assetWidth, $skin.assetHeight);
		}

		
		
		override protected function $hoverInTween():void {
			new TweenMax(_backBM, $skin.hoverInDuration, {alpha:0, ease:Sine.easeIn});
			new TweenMax(_hoverBM, $skin.hoverInDuration, {alpha:1, ease:Sine.easeOut});
			new TweenMax(_focusBM, $skin.hoverInDuration, {alpha:0, ease:Sine.easeIn});
		}

		
		
		override protected function $hoverOutTween():void {
			new TweenMax(_backBM, $skin.hoverOutDuration, {alpha:1, ease:Sine.easeOut});
			new TweenMax(_hoverBM, $skin.hoverOutDuration, {alpha:0, ease:Sine.easeIn});		
			new TweenMax(_focusBM, $skin.hoverOutDuration, {alpha:0, ease:Sine.easeIn});
		}

		
		
		override protected function $focusInTween():void {
			new TweenMax(_backBM, $skin.focusInDuration, {alpha:0, ease:Sine.easeIn});
			new TweenMax(_hoverBM, $skin.focusInDuration, {alpha:0, ease:Sine.easeIn});		
			new TweenMax(_focusBM, $skin.focusInDuration, {alpha:1, ease:Sine.easeOut});
		}

		
		
		override protected function $dragConfirmedTween():void {
			new TweenMax(_backBM, $skin.hoverInDuration, {alpha:0, ease:Sine.easeIn});
			new TweenMax(_hoverBM, $skin.hoverInDuration, {alpha:1, ease:Sine.easeOut});
			new TweenMax(_focusBM, $skin.hoverInDuration, {alpha:0, ease:Sine.easeIn});
		}

		
		
		override protected function $releasedInsideTween():void {
			new TweenMax(_backBM, $skin.focusOutDuration, {alpha:0, ease:Sine.easeIn});
			new TweenMax(_hoverBM, $skin.focusOutDuration, {alpha:1, ease:Sine.easeOut});
			new TweenMax(_focusBM, $skin.focusOutDuration, {alpha:0, ease:Sine.easeIn});
		}

		
		
		override protected function $releasedOutsideTween():void {
			new TweenMax(_backBM, $skin.focusOutDuration, {alpha:1, ease:Sine.easeOut});
			new TweenMax(_hoverBM, $skin.focusOutDuration, {alpha:0, ease:Sine.easeIn});		
			new TweenMax(_focusBM, $skin.focusOutDuration, {alpha:0, ease:Sine.easeIn});
		}
	}
}
