package org.vancura.vaclav.widgets.widgets {
	import com.greensock.TweenMax;

	import org.vancura.vaclav.core.Drawing;
	import org.vancura.vaclav.core.QBitmap;
	import org.vancura.vaclav.core.removeChildren;
	import org.vancura.vaclav.widgets.skin.SkinManager;
	import org.vancura.vaclav.widgets.skin.interfaces.IButtonSkin;
	import org.vancura.vaclav.widgets.widgets.interfaces.IButton;
	import org.vancura.vaclav.widgets.widgets.interfaces.IWidget;

	import mx.effects.easing.Sine;

	import flash.display.DisplayObjectContainer;

	
	
	public class StaticButton extends ButtonCore implements IWidget, IButton {

		
		
		private var _backBM:QBitmap;
		private var _hoveredBM:QBitmap;
		private var _pressedBM:QBitmap;

		
		
		public function StaticButton(	skin:IButtonSkin,
										config:Object = null,
										parent:DisplayObjectContainer = null,
										debugLevel:String = null) {
											
			if(config == null) config = new Object();
			
			var sm:SkinManager = SkinManager.getInstance();
			super(skin, config, parent, (debugLevel != null) ? debugLevel : sm.debugLevel);
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
			_hoveredBM = new QBitmap({alpha:0}, $contentSpr);
			_pressedBM = new QBitmap({alpha:0}, $contentSpr);
		}

		
		
		override protected function $removeChildren():void {
			super.$removeChildren();
			
			removeChildren($contentSpr, _backBM, _hoveredBM, _pressedBM);
		}

		
		
		override public function draw():void {
			super.draw();
			
			_backBM.bitmapData = $skin.backBD;
			_hoveredBM.bitmapData = $skin.hoveredBD;
			_pressedBM.bitmapData = $skin.pressedBD;
			
			$activeSpr.graphics.clear();
			Drawing.drawRect($activeSpr, 0, 0, $skin.assetWidth, $skin.assetHeight);
		}

		
		
		override protected function $hoveredInTween():void {
			new TweenMax(_backBM, $skin.hoveredInDuration, {alpha:0, ease:Sine.easeIn});
			new TweenMax(_hoveredBM, $skin.hoveredInDuration, {alpha:1, ease:Sine.easeOut});
			new TweenMax(_pressedBM, $skin.hoveredInDuration, {alpha:0, ease:Sine.easeIn});
		}

		
		
		override protected function $hoveredOutTween():void {
			new TweenMax(_backBM, $skin.hoveredOutDuration, {alpha:1, ease:Sine.easeOut});
			new TweenMax(_hoveredBM, $skin.hoveredOutDuration, {alpha:0, ease:Sine.easeIn});		
			new TweenMax(_pressedBM, $skin.hoveredOutDuration, {alpha:0, ease:Sine.easeIn});
		}

		
		
		override protected function $pressedInTween():void {
			new TweenMax(_backBM, $skin.pressedInDuration, {alpha:0, ease:Sine.easeIn});
			new TweenMax(_hoveredBM, $skin.pressedInDuration, {alpha:0, ease:Sine.easeIn});		
			new TweenMax(_pressedBM, $skin.pressedInDuration, {alpha:1, ease:Sine.easeOut});
		}

		
		
		override protected function $dragConfirmedTween():void {
			new TweenMax(_backBM, $skin.hoveredInDuration, {alpha:0, ease:Sine.easeIn});
			new TweenMax(_hoveredBM, $skin.hoveredInDuration, {alpha:1, ease:Sine.easeOut});
			new TweenMax(_pressedBM, $skin.hoveredInDuration, {alpha:0, ease:Sine.easeIn});
		}

		
		
		override protected function $releasedInsideTween():void {
			new TweenMax(_backBM, $skin.pressedOutDuration, {alpha:0, ease:Sine.easeIn});
			new TweenMax(_hoveredBM, $skin.pressedOutDuration, {alpha:1, ease:Sine.easeOut});
			new TweenMax(_pressedBM, $skin.pressedOutDuration, {alpha:0, ease:Sine.easeIn});
		}

		
		
		override protected function $releasedOutsideTween():void {
			new TweenMax(_backBM, $skin.pressedOutDuration, {alpha:1, ease:Sine.easeOut});
			new TweenMax(_hoveredBM, $skin.pressedOutDuration, {alpha:0, ease:Sine.easeIn});		
			new TweenMax(_pressedBM, $skin.pressedOutDuration, {alpha:0, ease:Sine.easeIn});
		}
	}
}
