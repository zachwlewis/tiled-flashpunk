package {

import net.flashpunk.Engine;
import net.flashpunk.FP;

[SWF(width=588, height=588)]
public class Main extends Engine {
    public function Main() {
        super(294, 294);
    }

	override public function init():void
	{
		FP.screen.scale = 2;
		FP.screen.color = 0x2c4e68;
		trace("FlashPunk started.");
		FP.world = new MapWorld();
		super.init();
	}
}
}
