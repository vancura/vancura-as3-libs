package org.vancura.vaclav.widgets.globals {
	import br.com.stimuli.string.printf;

	
	
	public class SkinProvider {

		
		
		protected var $skinConfig:Object;
		protected var $skinList:Array;
		protected var $themeElements:Array;
		protected var $themeConfig:Array;
		protected var $isVerbose:Boolean;
		
		
		
		public function SkinProvider(themeElements:Array = null, themeConfig:Array = null, isVerbose:Boolean = false) {
			$skinList = new Array();
			$themeElements = (themeElements != null) ? themeElements : new Array();
			$themeConfig = (themeConfig != null) ? themeConfig : new Array();
			$isVerbose = isVerbose;
		}

		
		
		protected function $mergeConfig(source:Object):Object {
			for each(var o:Object in themeConfig) {
				var parameter:String = o.parameter as String; 
				if(parameter.indexOf(source.id) == 0) {
					try {
						var value:String = o.value as String;
						var instance:String = parameter.replace(source.id + '.', '');
						source[instance] = (value == '') ? null : value;
					}
					catch(err:Error) {
						throw new Error(printf('Could not convert config (mask="%s")', source.id));
					}
				}
			}
			
			return source;
		}

		
		
		public function get skinConfig():Object {
			return $skinConfig;
		}
		
		
		
		public function get skinList():Array {
			return $skinList;
		}
		
		
		
		public function get themeElements():Array {
			return $themeElements;
		}
		
		
		
		public function get themeConfig():Array {
			return $themeConfig;
		}
		
		
		
		public function get isVerbose():Boolean {
			return $isVerbose;
		}
	}
}
