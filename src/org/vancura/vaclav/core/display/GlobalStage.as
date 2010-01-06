/***********************************************************************************************************************
 * Copyright (c) 2010. Vaclav Vancura.
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

package org.vancura.vaclav.core.display {
	import flash.display.Sprite;
	import flash.display.Stage;

	/**
	 * Global Stage singleton.
	 * Original: (http://www.kirupa.com/forum/showthread.php?p=1939920)
	 * Created by Matthew Lloyd (http://www.Matt-Lloyd.co.uk)
	 * This is release under a Creative Commons license, More information can be found here: (http://creativecommons.org/licenses/by-nc-sa/2.0/uk)
	 *
	 * @author Pierluigi Pesenti (http://blog.oaxoa.com)
	 */
	public class GlobalStage extends Sprite {


		private static var _instance:GlobalStage = null;



		/**
		 * Init global Stage singleton.
		 *
		 * @param stg Stage
		 */
		public static function init(stg:Stage):void {
			stg.addChild(GlobalStage.getInstance());
		}



		/**
		 * Get an instance.
		 *
		 * @return Instance
		 */
		public static function getInstance():GlobalStage {
			if(_instance == null) _instance = new GlobalStage();
			return _instance;
		}



		/**
		 * Get global Stage reference.
		 *
		 * @return Global Stage reference
		 */
		public static function get stage():Stage {
			return getInstance().stage;
		}
	}
}
