/***********************************************************************************************************************
 * Some methods Copyrighted by their authors, specified in ASDocs.
 * If not specified elsewhere: Copyright (c) 2010 Vaclav Vancura.
 *
 * Contact me at vaclav@vancura.org, @vancura or at my homepage at http://vaclav.vancura.org.
 * Project's GIT repo: http://github.com/vancura/vancura-as3-libs
 * Documentation: http://doc.vaclav.vancura.org/vancura-as3-libs
 *
 * Licensed under Attribution 3.0 Czech Republic (http://creativecommons.org/licenses/by/3.0/cz/deed.en_GB).
 *
 * That means you are free:
 * * to copy, distribute, display, and perform the work
 * * to make derivative works
 *
 * Under the following conditions::
 * * Attribution Ñ You must give the original author credit.
 *
 * With the understanding that:
 *    * Waiver Ñ Any of the above conditions can be waived if you get permission from the copyright holder. CC licenses
 *      anticipate that a licensor may want to waive compliance with a specific condition, such as attribution.
 *    * Other Rights Ñ In no way are any of the following rights affected by the license:
 *	         - Your fair dealing or fair use rights Ñ All jurisdictions allow some limited uses of copyrighted material
 *            without permission. CC licenses do not affect the rights of users under those copyright limitations and
 *            exceptions, such as fair use and fair dealing where applicable.
 *	         - The author's moral rights Ñ In addition to the right of licensors to request removal of their name from
 *            the work when used in a derivative or collective they don't like, copyright laws in most jurisdictions
 *            around the world (with the notable exception of the US except in very limited circumstances) grant
 *            creators "moral rights" which may provide some redress if a derivative work represents a "derogatory
 *            treatment" of the licensor's work.
 *	         - Rights other persons may have either in the work itself or in how the work is used, such as publicity or
 *            privacy rights. Ñ Publicity rights allow individuals to control how their voice, image or likeness is used
 *            for commercial purposes in public. If a CC-licensed work includes the voice or image of anyone other than
 *            the licensor, a user of the work may need to get permission from those individuals before using the work
 *            for commercial purposes.
 *
 * Notice Ñ For any reuse or distribution, you must make clear to others the licence terms of this work.
 **********************************************************************************************************************/

package org.vancura.vaclav.widgets.skin {
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
				_id = type + ':skin:' + rs;
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
						var msg1:String = 'Error in element properties (use name:String and color:uint pairs) (' + getElementError.message + ')';
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
