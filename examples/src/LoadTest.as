/***********************************************************************************************************************
 * Copyright (c) 2009. Vaclav Vancura.
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

package {
	import flash.display.MovieClip;
	import flash.events.Event;

	import org.vancura.vaclav.assets.events.AssetManagerErrorEvent;
	import org.vancura.vaclav.assets.globals.AssetManager;
	import org.vancura.vaclav.assets.providers.FARAssetProvider;
	import org.vancura.vaclav.core.Stats;
	import org.vancura.vaclav.widgets.constants.DebugLevel;
	import org.vancura.vaclav.widgets.events.ButtonEvent;
	import org.vancura.vaclav.widgets.globals.A2S;
	import org.vancura.vaclav.widgets.globals.SkinManager;
	import org.vancura.vaclav.widgets.widgets.LabelButton;

	[SWF(width="1000",height="400",frameRate="60",backgroundColor="#FFFFFF")]


	public class LoadTest extends MovieClip {


		private var _assetManager:AssetManager;
		private var _buttonTest:LabelButton;



		/**
		 * In this example we'll try to load skin library from a FAR file
		 * and then create a simple button.
		 */
		public function LoadTest() {
			// create asset manager
			_assetManager = AssetManager.getInstance();

			// add event listeners
			_assetManager.addEventListener(Event.COMPLETE, _onProviderComplete, false, 0, true);
			_assetManager.addEventListener(AssetManagerErrorEvent.PROVIDER_ERROR, _onProviderError, false, 0, true);
			_assetManager.addEventListener(AssetManagerErrorEvent.ITEM_NOT_FOUND, _onItemNotFound, false, 0, true);
			_assetManager.addEventListener(AssetManagerErrorEvent.ITEM_LOAD_FAILED, _onItemLoadFailed, false, 0, true);

			// attach provider
			_assetManager.attachProvider(new FARAssetProvider('skins/test-skin.far'));
		}



		// Event listeners
		// ---------------


		private function _onProviderComplete(event:Event):void {
			SkinManager.debugLevel = DebugLevel.HOVER;

			_buttonTest = new LabelButton(A2S('label_button'), {x:300, y:100, width:400}, 'Test', this);
			_buttonTest.addEventListener(ButtonEvent.RELEASE_INSIDE, _onTest, false, 0, true);

			addChild(new Stats());
		}



		private function _onItemLoadFailed(event:AssetManagerErrorEvent):void {
			trace('Item load failed: ' + event.text);
		}



		private function _onItemNotFound(event:AssetManagerErrorEvent):void {
			trace('Item not found: ' + event.text);
		}



		private function _onProviderError(event:AssetManagerErrorEvent):void {
			trace('Provider error: ' + event.text);
		}



		private function _onTest(event:ButtonEvent):void {
			_buttonTest.morph({height:Math.random() * 300 + 100});
		}
	}
}
