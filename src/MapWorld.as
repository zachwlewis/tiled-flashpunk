package
{
import net.flashpunk.FP;
import net.flashpunk.World;
import net.flashpunk.graphics.Tilemap;
import net.flashpunk.utils.Input;
import net.flashpunk.utils.Key;

public class MapWorld extends World
{
	[Embed(source = "../assets/sample.tmx", mimeType = "application/octet-stream")] private const MAPFILE:Class;
	[Embed(source = "../assets/spritesheet.png")] private const SPRITESHEET:Class;

	private var _map:Tilemap;
	public function MapWorld()
	{
		super();
	}

	override public function begin():void
	{
		var mapXML:XML = FP.getXML(MAPFILE);
		var mapWidth:uint = uint(mapXML.layer.@width);
		var mapHeight:uint = uint(mapXML.layer.@height);
		var tileX:uint = 0;
		var tileY:uint = 0;

		// Create a tilemap to show the level.
		// Tile size is hardcoded, but could be pulled from the XML.
		_map = new Tilemap(SPRITESHEET, mapWidth * 21, mapHeight * 21, 21, 21);

		// Iterate through tiles, adding them to the tilemap.
		for each (var tile:XML in mapXML.layer.data.tile)
		{
			// Once the end of the map is reached, loop back to the start.
			if (tileX >= mapWidth)
			{
				tileX = 0;
				tileY++;
			}

			// Ignore empty tiles.
			if (tile.@gid != 0)
			{
				_map.setTile(tileX, tileY, uint(tile.@gid - 1));
			}

			// Move to the next tile.
			tileX++;
		}

		// Add the map to the world.
		addGraphic(_map);
		super.begin();
	}

	override public function update():void
	{
		// Pan the camera based on player input.
		var direction:int = 0;

		if (Input.check(Key.LEFT)) direction--;
		if (Input.check(Key.RIGHT)) direction++;

		FP.camera.x += direction * 100 * FP.elapsed;

		// Prevent the camera from going past the map.
		FP.camera.x = FP.clamp(FP.camera.x, 0, _map.width - FP.screen.width);
	}
}
}
