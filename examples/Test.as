package {
	import org.vancura.vaclav.core.Drawing;
	import org.vancura.vaclav.core.QSprite;

	import flash.display.MovieClip;

	
	
	/**
	 * @author Vaclav Vancura (http://vaclav.vancura.org)
	 */
	public class Test extends MovieClip {

		
		
		public function Test() {
			var qspr:QSprite = new QSprite({x:100, y:50, alpha:.5});
			
			Drawing.drawRect(qspr);
			
			addChild(qspr);
		}
	}
}
