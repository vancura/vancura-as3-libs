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
 * 	        - Your fair dealing or fair use rights Ñ All jurisdictions allow some limited uses of copyrighted material
 *            without permission. CC licenses do not affect the rights of users under those copyright limitations and
 *            exceptions, such as fair use and fair dealing where applicable.
 * 	        - The author's moral rights Ñ In addition to the right of licensors to request removal of their name from
 *            the work when used in a derivative or collective they don't like, copyright laws in most jurisdictions
 *            around the world (with the notable exception of the US except in very limited circumstances) grant
 *            creators "moral rights" which may provide some redress if a derivative work represents a "derogatory
 *            treatment" of the licensor's work.
 * 	        - Rights other persons may have either in the work itself or in how the work is used, such as publicity or
 *            privacy rights. Ñ Publicity rights allow individuals to control how their voice, image or likeness is used
 *            for commercial purposes in public. If a CC-licensed work includes the voice or image of anyone other than
 *            the licensor, a user of the work may need to get permission from those individuals before using the work
 *            for commercial purposes.
 *
 * Notice Ñ For any reuse or distribution, you must make clear to others the licence terms of this work.
 **********************************************************************************************************************/

package org.vancura.vaclav.core.display {
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.BlendMode;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;
	import flash.system.System;
	import flash.text.AntiAliasType;
	import flash.text.TextFormat;
	import flash.utils.getTimer;

	import org.vancura.vaclav.core.utils.DisplayUtils;

	/*
	 * Class: Stats
	 *
	 * Hi-ReS! Stats
	 * Original code by Mr.doob (<http://www.mrdoob.com>)
	 * Eyecandified by Vaclav Vancura (<http://vaclav.vancura.org>)
	 *
	 * Released under MIT license:
	 * http://www.opensource.org/licenses/mit-license.php
	 *
	 * How to use:
	 *
	 * (start code)
	 * 		addChild( new Stats() );
	 * (end)
	 *
	 * Version log:
	 *
	 * 2009-11-04	- Whole package moved to vancura-core (v.vancura)
	 * 2009-11-04	- Changed font to UNI0553 by miniml.com (v.vancura)
	 * 2008-10-20	- Added to as3-org-vancura (v.vancura)
	 * 2008-10-19	- Added NaturalDocs comments (v.vancura)
	 * 2008-10-16	- Eye candy (v.vancura)
	 * 2008-07-12	- Some speed and code optimisations (Mr.doob)
	 * 2008-02-15	- Class renamed to Stats (previously FPS) (Mr.doob)
	 * 2008-01-05	- Click changes the fps of flash (half up increases, half down decreases) (Mr.doob)
	 * 2008-01-04	- Log shape for MEM (Mr.doob & Theo)
	 * 2008-01-04	- More room for MS (Mr.doob)
	 * 2008-01-04	- Shameless ripoff of Alternativa's FPS look ;) (Mr.doob)
	 * 2008-12-13	- First version (Mr.doob)
	 *
	 * Author: Mr.doob <http://www.mrdoob.com>
	 * Author: Vaclav Vancura <http://vaclav.vancura.org>
	 */
	public class Stats extends Sprite {


		[Embed(source='../../../../../../lib/fonts/uni05_53.ttf', fontName='uni0553', mimeType='application/x-font', unicodeRange='U+0030-U+0039,U+002E,U+0046,U+0050,U+0053,U+004D,U+004D,U+0045,U+0020,U+003A,U+002F')]
		private static var _fontUni0553:Class;

		private static const _WIDTH:Number = 80;

		private var _fpsGraphBD:BitmapData;
		private var _memGraphBD:BitmapData;
		private var _msGraphBD:BitmapData;

		private var _fpsGraphBM:Bitmap;
		private var _memGraphBM:Bitmap;
		private var _msGraphBM:Bitmap;

		private var _textFormat:TextFormat = new TextFormat('uni0553', 8);
		private var _fpsText:QTextField;
		private var _msText:QTextField;
		private var _memText:QTextField;
		private var _fps:int;
		private var _timer:int;
		private var _ms:int;
		private var _msPrev:int = 0;
		private var _mem:Number = 0;



		/**
		 * Constructor.
		 */
		public function Stats():void {
			_fpsGraphBD = new BitmapData(_WIDTH, 50, false, 0x000000);
			_msGraphBD = new BitmapData(_WIDTH, 50, false, 0x000000);
			_memGraphBD = new BitmapData(_WIDTH, 50, false, 0x000000);
			_fpsGraphBM = new QBitmap({bitmapData: _fpsGraphBD, y:27, alpha:0.33, blendMode:BlendMode.SCREEN});
			_msGraphBM = new QBitmap({bitmapData: _msGraphBD, y:27, alpha:0.33, blendMode:BlendMode.SCREEN});
			_memGraphBM = new QBitmap({bitmapData: _memGraphBD, y:27, alpha:0.33, blendMode:BlendMode.SCREEN});
			_fpsText = new QTextField({defaultTextFormat: _textFormat, antiAliasType:AntiAliasType.NORMAL, y:-3, width:_WIDTH, height:10, textColor:0xFFFF00});
			_msText = new QTextField({defaultTextFormat: _textFormat, antiAliasType:AntiAliasType.NORMAL, y:5, width:_WIDTH, height:10, textColor:0x00FF00});
			_memText = new QTextField({defaultTextFormat: _textFormat, antiAliasType:AntiAliasType.NORMAL, y:13, width:_WIDTH, height:10, textColor:0x00FFFF});

			DisplayUtils.drawRect(this, 0, 0, _WIDTH, 27 + 50, 0x000000, 0.75);

			DisplayUtils.addChildren(this, _fpsGraphBM, _msGraphBM, _memGraphBM, _fpsText, _msText, _memText);

			addEventListener(MouseEvent.CLICK, _onMouseClick);
			addEventListener(Event.ENTER_FRAME, _onEnterFrame);
		}



		// Event listeners
		// ---------------


		private function _onMouseClick(e:MouseEvent):void {
			if(this.mouseY > this.height * 0.35) {
				stage.frameRate--;
			}
			else {
				stage.frameRate++;
			}

			_fpsText.text = 'FPS: ' + _fps + '/' + stage.frameRate;
		}



		private function _onEnterFrame(e:Event):void {
			_timer = getTimer();
			_fps++;

			if(_timer - 1000 > _msPrev) {
				_msPrev = _timer;
				//noinspection NestedFunctionCallJS
				_mem = Number((System.totalMemory / 1048576).toFixed(3));

				var f:uint = Math.min(50, 50 / stage.frameRate * _fps);
				var t:uint = ((_timer - _ms ) >> 1);

				//noinspection NestedFunctionCallJS
				var m:uint = Math.min(50, Math.sqrt(Math.sqrt(_mem * 5000))) - 2;

				_fpsGraphBD.scroll(1, 0);
				_msGraphBD.scroll(1, 0);
				_memGraphBD.scroll(1, 0);

				var r1:Rectangle = new Rectangle(0, 50 - f, 1, f);
				var r2:Rectangle = new Rectangle(0, 50 - t, 1, t);
				var r3:Rectangle = new Rectangle(0, 50 - m, 1, m);

				_fpsGraphBD.fillRect(r1, 0xFFFF00);
				_msGraphBD.fillRect(r2, 0x00FF00);
				_memGraphBD.fillRect(r3, 0x00FFFF);

				_fpsText.text = 'FPS: ' + _fps + '/' + stage.frameRate;
				_memText.text = 'MEM: ' + _mem;

				_fps = 0;
			}

			_msText.text = 'MS: ' + (_timer - _ms);
			_ms = _timer;
		}
	}
}
