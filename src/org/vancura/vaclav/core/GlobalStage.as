package org.vancura.vaclav.core {
	import flash.display.Sprite;
	import flash.display.Stage;

	
	
	/*
	 * Class: GlobalStage
	 * 
	 * Global Stage singleton.
	 * 
	 * - Original: <http://www.kirupa.com/forum/showthread.php?p=1939920>
	 * - Created by Matthew Lloyd <http://www.Matt-Lloyd.co.uk>
	 * - This is release under a Creative Commons license, More information can be found here: <http://creativecommons.org/licenses/by-nc-sa/2.0/uk>
	 * 
	 * Author: Pierluigi Pesenti <http://blog.oaxoa.com>
	 */
	public class GlobalStage extends Sprite {

		
		
		private static var _instance:GlobalStage = null;

		
		
		/*
		 * Method: init
		 * 
		 * Init Global Stage singleton.
		 * 
		 * Parameters:
		 * 
		 * 		stg		- Stage
		 */
		public static function init(stg:Stage):void {
			stg.addChild(GlobalStage.instance);
		}

		
		
		/*
		 * Method: instance
		 * 
		 * Get a Global Stage instance.
		 * 
		 * Returns:
		 * 
		 * 		Global Stage instance
		 */
		public static function get instance():GlobalStage {
			if(_instance == null) _instance = new GlobalStage();
			return _instance;
		}

		
		
		/*
		 * method: stage
		 * 
		 * Get Global Stage reference.
		 * 
		 * Returns:
		 * 
		 * 		Global Stage reference
		 */
		public static function get stage():Stage {
			return instance.stage;
		}
	}
}
