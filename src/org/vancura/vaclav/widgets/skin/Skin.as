package org.vancura.vaclav.widgets.skin {
	import org.vancura.vaclav.core.duplicateMovieClip;
	import org.vancura.vaclav.widgets.skin.interfaces.ISkinnable;

	import flash.display.BitmapData;
	import flash.display.MovieClip;
	import flash.filters.ColorMatrixFilter;

	
	
	public class Skin implements ISkinnable {

		

		public static const TYPE_BAR:String = 'bar';
		public static const TYPE_IMAGE:String = 'image';
		public static const TYPE_BUTTON:String = 'button';
		public static const TYPE_LABEL:String = 'label';
		public static const TYPE_LABEL_BUTTON:String = 'label_button';
		public static const TYPE_CHECK_BUTTON:String = 'check_button';
		public static const TYPE_INPUT_BAR:String = 'input_bar';

		protected var $id:String;
		protected var $type:String;
		protected var $assetWidth:Number = 0;
		protected var $assetHeight:Number = 0;
		protected var $data:Object = new Object();

		private var _oldData:Object;
		
		
		
		public function Skin(id:String, type:String):void {
			$id = id;
			$type = type;
		}
		
		
		
		public function get id():String {
			return $id;
		}
		
		
		
		public function get type():String {
			return $type;
		}

		
		
		public function get assetWidth():Number {
			return $assetWidth;
		}

		
		
		public function get assetHeight():Number {
			return $assetHeight;
		}
		
		
		
		public function get data():Object {
			return $data;
		}

		
		
		public function set data(value:Object):void {
			$data = value;
		}
		
		
		
		public function parseConfig(source:Object):void {
			_oldData = $data;
			
			if(source.data != undefined) $data = source.data;
		}
		
		
		
		public function revertConfig():void {
			$data = _oldData;			
		}

		
		
		protected function $getSkinSize(source:MovieClip, frame:*):void {
			// it's needed to duplicate this MovieClip as there was some weird bug:
			// when used source.gotoAndStop(frame) on one of next lines,
			// all future getChildByName() on this source failed.
			var duplicate:MovieClip = duplicateMovieClip(source);
			
			duplicate.gotoAndStop(frame);
			
			$assetWidth = duplicate.width;
			$assetHeight = duplicate.height;
		}

		
		
		protected function $getSkinFrame(source:MovieClip, elements:Array = null, frame:* = 1):BitmapData {
			// it's needed to duplicate this MovieClip as there was some weird bug:
			// when used source.gotoAndStop(frame) on one of next lines,
			// all future getChildByName() on this source failed.
			var duplicate:MovieClip = duplicateMovieClip(source);
			var output:BitmapData = new BitmapData($assetWidth, $assetHeight, true, 0x00000000);
			
			duplicate.gotoAndStop(frame);

			if(elements != null) {				
				// roll throught all elements
				for each(var element:Object in elements) {
					// get element properties
					try {
						var name:String = element.name;
						var color:uint = uint(element.color);
					}
					catch(getElement:Error) {
						throw new Error('Error in element properties (use name:String and color:uint pairs)');
					}
				
					// count color matrix
					var colMatrix:ColorMatrix = new ColorMatrix();
					colMatrix.colorize(color);
					
					// apply color matrix
					try {
						duplicate.getChildByName(name).filters = [new ColorMatrixFilter(colMatrix.matrix)]; 
					}
					catch(applyColorMatrixError:Error) {
						// child not found, ignore it
					}
				}
			}
			
			// draw composition
			output.draw(duplicate);
				
			return output;
		}

		
		
		protected function $checkSize(source:BitmapData):void {
			if($assetWidth == 0 && $assetHeight == 0) {
				// size is not specified, set initial values
				$assetWidth = source.width;
				$assetHeight = source.height;
			}
			else if(source.width != $assetWidth || source.height != $assetHeight) {
				// size mismatch
				throw new Error('Size has to be same');
			}
		}
	}
}
