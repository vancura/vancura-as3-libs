package {
	import br.com.stimuli.string.printf;

	import com.greensock.TweenNano;

	import org.vancura.vaclav.core.Stats;
	import org.vancura.vaclav.widgets.constants.DebugLevel;
	import org.vancura.vaclav.widgets.events.ButtonEvent;
	import org.vancura.vaclav.assets.SWFLibraryProvider;
	import org.vancura.vaclav.widgets.globals.SkinManager;
	import org.vancura.vaclav.widgets.skin.LabelButtonSkin;
	import org.vancura.vaclav.widgets.widgets.LabelButton;

	import flash.display.MovieClip;
	import flash.events.ErrorEvent;
	import flash.events.Event;

	[SWF(width="1000",height="400",frameRate="60",backgroundColor="#FFFFFF")]

	
	
	public class SWFTest extends MovieClip {

		
		
		private var _buttonTest:LabelButton;
		private var _skinManager:SkinManager;
		private var _skin:LabelButtonSkin;
		private var _stressRemove:int;
		private var _stressList:Array = new Array();

		
		
		public function SWFTest() {
			_skinManager = SkinManager.getInstance();
			_skinManager.debugLevel = DebugLevel.HOVER;
			_skinManager.debugColor = 0x123456;
			
			var skinProvider:SWFLibraryProvider;
			
			try {
				skinProvider = new SWFLibraryProvider('test-skin.swf', null, null, true);
				skinProvider.addEventListener(Event.COMPLETE, _onSkinComplete, false, 0, true);
				skinProvider.addEventListener(ErrorEvent.ERROR, _onSkinError, false, 0, true);
				
				_skinManager.attach(skinProvider);
			}
			catch(err:Error) {
				trace(printf('Skin could not be attached (%s)', err.message));
				return;
			}
		}
		
		
		
		private function _onSkinError(event:ErrorEvent):void {
			trace(printf('Error: %s', event.text));
		}

		
		
		private function _onSkinComplete(event:Event):void {
			trace('Skin loaded');
			trace(_skinManager.toString());
			
			// --------
			var skin:LabelButtonSkin = _skinManager.getSkin('label_button');
			
			_buttonTest = new LabelButton(skin, {x:10, y:100, width:200}, 'Lorem ipsum', this);
			
			_buttonTest.addEventListener(ButtonEvent.RELEASE_INSIDE, _onTest);
			
			// --------
			var stats:Stats = new Stats();
			addChild(stats);
		}

		
		
		private function _onTest(event:ButtonEvent):void {
			_skin = _skinManager.getSkin('label_button');
			_stressRemove = -50;
			
			_buttonTest.morph({width:400, morphDuration:2});
			_stressTest();
		}

		
		
		private function _stressTest():void {
			var mw:int = Math.random() * 200;
			var mh:int = Math.random() * 200;
			var mx:int = Math.random() * (stage.stageWidth - mw);
			var my:int = Math.random() * (stage.stageHeight - mh);
			var newBtn:LabelButton = new LabelButton(_skin, {x:mx, y:my, width:mw, height:mh}, 'Lorem ipsum', this);
			
			_stressList.push(newBtn);
			_stressRemove++;
			
			var oldBtn:LabelButton = _stressList[_stressRemove] as LabelButton;
			if(oldBtn != null) {
				oldBtn.destroy();
				removeChild(oldBtn);
			}
			_stressList[_stressRemove] = null;
			
			TweenNano.delayedCall(.001, _stressTest);
		}
	}
}
