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

package org.vancura.vaclav.locale {
	import flash.utils.Dictionary;

	import mx.utils.StringUtil;

	public class LanguageDictionary {


		private var _lang:String;
		private var _dictionary:Dictionary;



		/**
		 * Constructor.
		 *
		 * @param lang Language ('en' by default)
		 */
		public function LanguageDictionary(lang:String = 'en') {
			_lang = lang;
			_dictionary = new Dictionary();
		}



		/**
		 * Parse locale XML.
		 *
		 * @param list Locale XML.
		 */
		public function parseXML(list:XMLList):void {
			for each(var x:XML in list) {
				_dictionary[String(x.@id)] = StringUtil.trim(x.toString());
			}
		}



		/**
		 * Get text by its ID.
		 *
		 * @param id Text ID
		 * @return Text if found, null if not
		 */
		public function getText(id:String):String {
			return _dictionary[id];
		}



		// Setters & getters
		// -----------------


		/**
		 * Get current language.
		 *
		 * @return Current language (like 'en')
		 */
		public function get lang():String {
			return _lang;
		}
	}
}
