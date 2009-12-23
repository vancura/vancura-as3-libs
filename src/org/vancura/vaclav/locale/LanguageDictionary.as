/***********************************************************************************************************************
 * Copyright (c) 2009. Vaclav Vancura (http://vaclav.vancura.org)
 **********************************************************************************************************************/

package org.vancura.vaclav.locale {
	import flash.utils.Dictionary;

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



		public function parseXML(list:XMLList):void {
			for each(var x:XML in list) {
				var id:String = x.@id;
				var value:String = x.toString();

				_dictionary[id] = value;
			}
		}



		public function getText(id:String):String {
			return _dictionary[id];
		}



		public function get lang():String {
			return _lang;
		}
	}
}
