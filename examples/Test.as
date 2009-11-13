package {
	import br.com.stimuli.string.printf;
	
	import flash.display.*;
	import flash.events.*;
	import flash.net.*;
	import flash.system.*;
	import flash.utils.*;
	
	import org.vancura.vaclav.core.QSprite;
	import org.vancura.vaclav.core.Stats;
	import org.vancura.vaclav.core.GraphicsUtil;
	import org.vancura.vaclav.widgets.constants.DebugLevel;
	import org.vancura.vaclav.widgets.events.ButtonEvent;
	import org.vancura.vaclav.widgets.globals.SWFLibraryProvider;
	import org.vancura.vaclav.widgets.globals.SkinManager;
	import org.vancura.vaclav.widgets.skin.ImageSkin;
	import org.vancura.vaclav.widgets.skin.LabelButtonSkin;
	import org.vancura.vaclav.widgets.widgets.LabelButton;
	import com.greensock.TweenNano;
	import org.vancura.vaclav.widgets.widgets.Image;

	[SWF(width="1000",height="400",frameRate="60",backgroundColor="#FFFFFF")]

	
	
	/**
	 * @author Vaclav Vancura (http://vaclav.vancura.org)
	 */
	public class Test extends MovieClip {

		
		
		private static const _SKIN_URI:String = 'test-skin.swf';
		
		private var _buttonTest:LabelButton;
		private var _skinURLLoader:URLLoader;
		private var _skinSWFLoader:Loader;
		private var _isError:Boolean;
		private var _skinManager:SkinManager;
		
		private var skin:LabelButtonSkin;
		private var _stressRemove:int;
		private var _stressList:Array = new Array();

		
		
		public function Test() {
			_skinURLLoader = new URLLoader();
			_skinURLLoader.dataFormat = URLLoaderDataFormat.BINARY;
			_skinURLLoader.addEventListener(Event.COMPLETE, _onURLLoaderComplete, false, 0, true);
			_skinURLLoader.addEventListener(IOErrorEvent.IO_ERROR, _onURLLoaderError, false, 0, true);
			_skinURLLoader.addEventListener(SecurityErrorEvent.SECURITY_ERROR, _onURLLoaderError, false, 0, true);
				
			_skinSWFLoader = new Loader();
			_skinSWFLoader.contentLoaderInfo.addEventListener(Event.INIT, _onSWFLoaderInit, false, 0, true);
				
			_skinURLLoader.load(new URLRequest(_SKIN_URI));
		}
		
		
		
		private function _onURLLoaderComplete(event:Event):void {
			if(_isError) {
				return;
			}
			
			var lc:LoaderContext = new LoaderContext(false, null);
			
			// FIXME: allowLoadBytesCodeExecution may be broken one day
			// We have to find a way how to load content from another sandbox
			// More info: http://richardleggett.co.uk/blog/index.php/2009/04/02/loading-swfs-into-air-1-5-and-loaderinfo
			// As seen here, it even doesn't compile, I have to put the parameter using Array. Damn!
			// lc['allowLoadBytesCodeExecution'] = true;
			
			_skinSWFLoader.loadBytes(_skinURLLoader.data, lc);
		}
		
		
		
		private function _onURLLoaderError(event:ErrorEvent):void {
			_isError = true;
			
			trace(printf('Skin could not be loaded. Is the URL ("%s") correct?', _SKIN_URI));
		}
		
		
		
		private function _onSWFLoaderInit(event:Event):void {
			if(_isError) return;
			
			_skinManager = SkinManager.getInstance();
			_skinManager.debugLevel = DebugLevel.HOVER;
			_skinManager.debugColor = 0x123456;
			
			var skinProvider:SWFLibraryProvider;
			
			try {
				skinProvider = new SWFLibraryProvider(_skinSWFLoader.contentLoaderInfo.content as MovieClip, null, null, true);
				_skinManager.attach(skinProvider);
			}
			catch(err:Error) {
				trace(printf('Skin could not be attached (%s)', err.message));
				return;
			}
								
			_skinURLLoader.removeEventListener(Event.COMPLETE, _onURLLoaderComplete);
			_skinURLLoader.removeEventListener(IOErrorEvent.IO_ERROR, _onURLLoaderError);
			_skinURLLoader.removeEventListener(SecurityErrorEvent.SECURITY_ERROR, _onURLLoaderError);
			_skinSWFLoader.contentLoaderInfo.removeEventListener(Event.INIT, _onSWFLoaderInit);
			
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
			skin = _skinManager.getSkin('label_button');
			_stressRemove = -50;
			
			_buttonTest.morph({width:400, morphDuration:2});
			_stressTest();
		}
		
		
		
		private function _stressTest():void {
			var mw:int = Math.random() * 200;
			var mh:int = Math.random() * 200;
			var mx:int = Math.random() * (stage.stageWidth - mw);
			var my:int = Math.random() * (stage.stageHeight - mh);
			var image:LabelButton = new LabelButton(skin, {x:mx, y:my, width:mw, height:mh}, 'Lorem ipsum', this);
//			var image:Image = new Image(skin, {x:mx, y:my}, this);
//			var image:QSprite = new QSprite({x:mx, y:my}, this);
			
			_stressList.push(image);
			_stressRemove++;
			
			TweenNano.delayedCall(.001, _stressTest);
			
			var xxx:LabelButton = _stressList[_stressRemove] as LabelButton;
			if(xxx != null) {
				xxx.destroy();
				removeChild(xxx);
			}
			_stressList[_stressRemove] = null;
		}
	}
}
