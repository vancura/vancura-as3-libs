package org.vancura.vaclav.widgets.widgets {
	import org.vancura.vaclav.core.GraphicsUtil;
	import org.vancura.vaclav.core.MorphSprite;
	import org.vancura.vaclav.core.QSprite;
	import org.vancura.vaclav.core.removeChildren;
	import org.vancura.vaclav.widgets.DebugLevel;
	import org.vancura.vaclav.widgets.skin.SkinManager;
	import org.vancura.vaclav.widgets.widgets.interfaces.IWidget;

	import flash.display.DisplayObjectContainer;
	import flash.display.Stage;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.events.MouseEvent;

	
	
	public class Widget extends MorphSprite {

		
		
		public static const DRAW:String = 'draw';
		
		public static var initialDebugLevel:String;
		
		protected static const $DEBUG_PADDING:Number = 4;
		
		protected static var $allWidgets:Array;
		
		protected var $allIdx:uint;
		protected var $config:Object;
		protected var $width:Number = 0;
		protected var $height:Number = 0;
		protected var $debugLevel:String;
		protected var $debugColor:uint;
		protected var $debugSpr:QSprite;
		protected var $contentSpr:QSprite;

		
		
		public function Widget(	config:Object = null,
								parent:DisplayObjectContainer = null,
								debugLevel:String = null):void {
										
			if(config == null) $config = new Object();
			else $config = config;
			
			var sm:SkinManager = SkinManager.getInstance();
			$debugColor = sm.debugColor;

			super(config);
			
			if(config.x != undefined) this.x = config.x;
			if(config.y != undefined) this.y = config.y;
			if(config.width != undefined) this.width = config.width;
			if(config.height != undefined) this.height = config.height;
			 
			if(parent != null) parent.addChild(this);
			
			if($allWidgets == null) $allWidgets = new Array();
			$allWidgets.push(this);
			$allIdx = $allWidgets.length - 1;
			
			$init();
			
			if(debugLevel != null) {
				this.debugLevel = debugLevel;
			}
			else if(initialDebugLevel != null) {
				this.debugLevel = initialDebugLevel;
			}
		}

		
		
		public function destroy():void {
			$removeChildren();
		}

		
		
		protected function $init():void {
			$addChildren();
			$invalidate();
		}

		
		
		protected function $addChildren():void {
			$contentSpr = new QSprite({}, this);
			$debugSpr = new QSprite({mouseEnabled:false}, this);
		}

		
		
		protected function $removeChildren():void {
			this.removeEventListener(MouseEvent.ROLL_OVER, $onDebugOver);
			this.removeEventListener(MouseEvent.ROLL_OUT, $onDebugOut);
				
			$allWidgets[$allIdx] = null;
			
			removeChildren(this, $contentSpr, $debugSpr);
		}

		
		
		protected function $invalidate():void {
			addEventListener(Event.ENTER_FRAME, _onInvalidate, false, 0, true);
		}

		
		
		public static function initStage(stage:Stage):void {
			stage.align = StageAlign.TOP_LEFT;
			stage.scaleMode = StageScaleMode.NO_SCALE;
		}

		
		
		override public function setSize(width:Number, height:Number):void {
			$width = width;
			$height = height;
			$invalidate();
		}

		
		
		public function draw():void {
			if($debugLevel == DebugLevel.ALWAYS || $debugLevel == DebugLevel.HOVER) {
				if($width != 0 && $height != 0) {
					$debugSpr.graphics.clear();
					GraphicsUtil.drawRect($debugSpr, 0, 0, $width, $height, $debugColor, .15);
					GraphicsUtil.strokeBounds($debugSpr, 0, 0, $width, $height, 5, $debugColor);
				}
			}
			
			dispatchEvent(new Event(Widget.DRAW));
		}

		
		
		public static function set allDebugLevel(value:String):void {
			for each(var i:IWidget in $allWidgets) {
				if(i != null) i.debugLevel = value;
			}
		}
		
		
		
		override public function set width(w:Number):void {
			$width = Math.round(w);
			$invalidate();
			dispatchEvent(new Event(Event.RESIZE));
		}

		
		
		override public function get width():Number {
			return $width;
		}

		
		
		override public function set height(h:Number):void {
			$height = Math.round(h);
			$invalidate();
			dispatchEvent(new Event(Event.RESIZE));
		}

		
		
		override public function get height():Number {
			return $height;
		}

		
		
		override public function set x(value:Number):void {
			super.x = Math.round(value);
		}

		
		
		override public function set y(value:Number):void {
			super.y = Math.round(value);
		}

		
		
		public function get config():Object {
			return $config;
		}

		
		
		public function set debugLevel(value:String):void {
			if(value == DebugLevel.ALWAYS) {
				$debugSpr.visible = true;
				this.removeEventListener(MouseEvent.ROLL_OVER, $onDebugOver);
				this.removeEventListener(MouseEvent.ROLL_OUT, $onDebugOut);
			}
			else {
				$debugSpr.visible = false;
				this.addEventListener(MouseEvent.ROLL_OVER, $onDebugOver, false, 0, true);
				this.addEventListener(MouseEvent.ROLL_OUT, $onDebugOut, false, 0, true);
			}
			
			$debugLevel = value;
		}

		
		
		public function get debugLevel():String {
			return $debugLevel;
		}

		
		
		public function set debugColor(value:uint):void {
			$debugColor = value;
			draw();
		}

		
		
		public function get debugColor():uint {
			return $debugColor;
		}

		
		
		protected function $onDebugOver(event:MouseEvent):void {
			$debugSpr.visible = true;
		}

		
		
		protected function $onDebugOut(event:MouseEvent):void {
			$debugSpr.visible = false;
		}

		
		
		private function _onInvalidate(event:Event):void {
			removeEventListener(Event.ENTER_FRAME, _onInvalidate);
			draw();
		}
	}
}