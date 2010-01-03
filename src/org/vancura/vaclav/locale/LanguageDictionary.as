/***********************************************************************************************************************
 * Copyright (c) 2009. Vaclav Vancura (http://vaclav.vancura.org)
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
