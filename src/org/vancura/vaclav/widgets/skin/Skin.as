/***********************************************************************************************************************
 * Copyright (c) 2010 Vaclav Vancura.
 * Contact me at vaclav@vancura.org or see my homepage at vaclav.vancura.org
 * Project's GIT repo: http://github.com/vancura/vancura-as3-libs
 * Documentation: http://doc.vaclav.vancura.org/vancura-as3-libs
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated
 * documentation files (the "Software"), to deal in the Software without restriction, including without limitation
 * the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software,
 * and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in all copies or substantial portions
 * of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED
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

	import org.vancura.vaclav.core.utils.DisplayUtils;
	import org.vancura.vaclav.core.utils.StringUtils;
	import org.vancura.vaclav.widgets.interfaces.ISkinnable;

	public class Skin implements ISkinnable {


		protected var _id:String;
		protected var _type:String;
		protected var _assetWidth:Number = 0;
		protected var _assetHeight:Number = 0;
		protected var _data:Object = new Object();

		private var _oldData:Object;



		public function Skin(type:String, id:String = null):void {
			_id = id;
			_type = type;

			if(_id == null) {
				var rs:String = StringUtils.randomString();
				_id = printf('%s:skin:%s', type, rs);
			}
		}



		public function get id():String {
			return _id;
		}



		public function get type():String {
			return _type;
		}



		public function get assetWidth():Number {
			return _assetWidth;
		}



		public function get assetHeight():Number {
			return _assetHeight;
		}



		public function get data():Object {
			return _data;
		}



		public function set data(value:Object):void {
			_data = value;
		}



		public function parseConfig(source:Object):void {
			_oldData = _data;

			if(source.data != undefined) {
				_data = source.data;
			}
		}



		public function revertConfig():void {
			_data = _oldData;
		}



		protected function _getSkinSize(source:MovieClip, frame:*):void {
			// it's needed to duplicate this MovieClip as there was some weird bug:
			// when used source.gotoAndStop(frame) on one of next lines,
			// all future getChildByName() on this source failed.
			var duplicate:MovieClip = DisplayUtils.duplicateMovieClip(source);

			duplicate.gotoAndStop(frame);

			_assetWidth = duplicate.width;
			_assetHeight = duplicate.height;
		}



		protected function _getSkinFrame(source:MovieClip, elements:Array = null, frame:* = 1):BitmapData {
			// it's needed to duplicate this MovieClip as there was some weird bug:
			// when used source.gotoAndStop(frame) on one of next lines,
			// all future getChildByName() on this source failed.
			var duplicate:MovieClip = DisplayUtils.duplicateMovieClip(source);
			var output:BitmapData = new BitmapData(_assetWidth, _assetHeight, true, 0x00000000);

			duplicate.gotoAndStop(frame);

			if(elements != null) {
				// roll throught all elements
				for each(var element:Object in elements) {
					// get element properties
					try {
						var name:String = element.name;
						var color:uint = uint(element.color);
					}
					catch(getElementError:Error) {
						var msg1:String = printf('Error in element properties (use name:String and color:uint pairs) (%s)', getElementError.message);
						throw new Error(msg1);
					}

					// count color matrix
					var colMatrix:ColorMatrix = new ColorMatrix();
					colMatrix.colorize(color);

					// apply color matrix
					// noinspection UnusedCatchParameterJS,EmptyCatchBlockJS
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



		protected function _checkSize(source:BitmapData):void {
			if(_assetWidth == 0 && _assetHeight == 0) {
				// size is not specified, set initial values
				_assetWidth = source.width;
				_assetHeight = source.height;
			} else if(source.width != _assetWidth || source.height != _assetHeight) {
				// size mismatch
				throw new Error('Sizes have to match');
			}
		}
	}
}
