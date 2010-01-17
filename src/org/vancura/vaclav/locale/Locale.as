// Clarion Hotels Panorama Viewer
// Code Copyright (c) 2010 Vaclav Vancura (http://vaclav.vancura.org)
// Design Copyright (c) 2010 Vaclav Vancura (http://vaclav.vancura.org)
// Client: Clarion Hotels (http://cchp.cz)
// Publisher: Web Design Factory / WDF (http://wdf.cz)

package org.vancura.vaclav.locale {
	import flash.events.EventDispatcher;

	/**
	 * Locale manager.
	 *
	 * @author Vaclav Vancura (http://vaclav.vancura.org)
	 */
	public class Locale extends EventDispatcher {


		private static var _dictionaries:Array = new Array();
		private static var _currentLanguage:String = '';
		private static var _currentDictionary:LanguageDictionary;



		/**
		 * Parse locale XML.
		 *
		 * @param locales Locales node in the XML
		 */
		public static function parseXML(locales:XMLList):void {
			for each(var lang:XML in locales.locale) {
				var dictionary:LanguageDictionary = new LanguageDictionary(lang.@lang);

				dictionary.parseXML(lang.text);

				_dictionaries.push(dictionary);

				if(_currentLanguage == '') {
					language = lang.@lang;
				}
			}
		}



		/**
		 * Get text by its ID.
		 *
		 * @param id Text ID
		 * @return Text if found, null if not
		 */
		public static function getText(id:String):String {
			var out:String;

			if(_currentDictionary != null) {
				out = _currentDictionary.getText(id);
			}

			// locale string not found
			if(out == null) out = '[' + id + ']';

			return out;
		}



		// Getters & setters
		// -----------------


		/**
		 * Set current language.
		 *
		 * @param value Language (like 'en')
		 * @throws Error if language not found in currently active dictionaries
		 */
		public static function set language(value:String):void {
			var f:LanguageDictionary;

			for each(var dictionary:LanguageDictionary in _dictionaries) {
				if(dictionary.lang == value) f = dictionary;
			}

			if(f == null) {
				throw new Error('Language ' + value + ' not found in currently active dictionaries');
			}

			_currentLanguage = value;
			_currentDictionary = f;
		}



		/**
		 * Get current language.
		 *
		 * @return Current language (like 'en')
		 */
		public static function get language():String {
			return _currentLanguage;
		}
	}
}
