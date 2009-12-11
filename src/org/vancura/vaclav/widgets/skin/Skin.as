/***********************************************************************************************************************
 * Copyright (c) 2009. Vaclav Vancura.
 * Contact me at vaclav@vancura.org or see my homepage at vaclav.vancura.org
 * Project's GIT repo: http://github.com/vancura/vancura-as3-libs
 * Documentation: http://doc.vaclav.vancura.org/vancura-as3-libs
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated
 * documentation files (the “Software”), to deal in the Software without restriction, including without limitation
 * the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software,
 * and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in all copies or substantial portions
 * of the Software.
 *
 * THE SOFTWARE IS PROVIDED “AS IS”, WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED
 * TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
 * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
 * OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
 * DEALINGS IN THE SOFTWARE.
 **********************************************************************************************************************/

package org.vancura.vaclav.widgets.skin {
	import br.com.stimuli.string.printf;

	import com.quasimondo.geom.ColorMatrix;

	import flash.display.BitmapData;
	import flash.display.MovieClip;
	import flash.filters.ColorMatrixFilter;

	import org.vancura.vaclav.core.duplicateMovieClip;
	import org.vancura.vaclav.core.randomString;
	import org.vancura.vaclav.widgets.interfaces.ISkinnable;

	public class Skin implements ISkinnable {


		protected var $id:String;
		protected var $type:String;
		protected var $assetWidth:Number = 0;
		protected var $assetHeight:Number = 0;
		protected var $data:Object = new Object();

		private var _oldData:Object;



		public function Skin(type:String, id:String = null):void {
			$id = id;
			$type = type;

			if($id == null) {
				$id = printf('%s:skin:%s', type, randomString());
			}
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

			if(source.data != undefined) {
				$data = source.data;
			}
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
			} else if(source.width != $assetWidth || source.height != $assetHeight) {
				// size mismatch
				throw new Error('Sizes have to match');
			}
		}
	}
}
