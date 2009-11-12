package org.vancura.vaclav.widgets.widgets {
	import org.vancura.vaclav.core.MorphSprite;
	import org.vancura.vaclav.core.removeChildren;
	import org.vancura.vaclav.widgets.interfaces.IBar;
	import org.vancura.vaclav.widgets.interfaces.IInputBar;
	import org.vancura.vaclav.widgets.interfaces.IInputBarSkin;
	import org.vancura.vaclav.widgets.interfaces.ILabel;
	import org.vancura.vaclav.widgets.interfaces.IWidget;
	import org.vancura.vaclav.widgets.globals.SkinManager;

	import flash.display.DisplayObjectContainer;

	
	
	public class InputBar extends MorphSprite implements IWidget, IInputBar {

		
		
		protected var $skin:IInputBarSkin;		
		protected var $bar:Bar;
		protected var $label:Label;

		private var _debugLevel:String;

		
		
		public function InputBar(	skin:IInputBarSkin,
									config:Object = null,
									parent:DisplayObjectContainer = null,
									debugLevel:String = null) {
										
			if(config == null) {
				config = new Object();
			}
			
			var sm:SkinManager = SkinManager.getInstance();
			var dl:String = (debugLevel != null) ? debugLevel : sm.debugLevel;
			
			$bar = new Bar(skin.barSkin, {}, this, dl);
			$label = new Label(skin.labelSkin, {}, '', this, dl);
			
			$bar.debugColor = sm.debugColor;
			$label.debugColor = sm.debugColor;
			$label.isInput = true;
			
			this.isMorphHeightEnabled = true;
			this.isMorphWidthEnabled = false;
			
			if(skin != null) {
				super(config, parent);
			}
			else {
				throw new Error('No skin defined');
			}
			
			$skin = skin;
		}

		
		
		public function destroy():void {
			removeChildren(this, $bar, $label);
			
			$bar.destroy();
			$label.destroy();
		}

		
		
		public function draw():void {
			$bar.draw();
			$label.draw();
			
			$label.height = $bar.height;
		}

		
		
		override public function get width():Number {
			return $bar.width;
		}

		
		
		override public function set width(value:Number):void {
			$bar.width = value;
			$label.width = value;
			
			draw();
		}

		
		
		override public function get height():Number {
			return $bar.height;
		}

		
		
		override public function set height(value:Number):void {
		}

		
		
		public function set areEventsEnabled(value:Boolean):void {
			$label.isInput = value;
			$label.alpha = (value) ? 1 : .5;
			
			draw();
		}

		
		
		public function get areEventsEnabled():Boolean {
			return $label.isInput;
		}

		
		
		public function get debugLevel():String {
			return _debugLevel;
		}

		
		
		public function set debugLevel(value:String):void {
			_debugLevel = value;

			$bar.debugLevel = value;
			$label.debugLevel = value;
		}

		
		
		public function get bar():IBar {
			return $bar;
		}
		
		
		
		public function get label():ILabel {
			return $label;
		}

		
		
		public function get text():String {
			return $label.text;
		}

		
		
		public function set text(value:String):void {
			$label.text = value;
		}

		
		
		public function get skin():IInputBarSkin {
			return $skin;
		}
		
		
		
		public function set skin(skin:IInputBarSkin):void {
			$skin = skin;
			
			$bar.skin = $skin.barSkin;
			$label.skin = $skin.labelSkin;
			
			draw();
		}
	}
}
