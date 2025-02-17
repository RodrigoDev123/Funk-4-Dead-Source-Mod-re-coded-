package editors;

import flixel.text.FlxText;
import flixel.FlxG;
import flixel.FlxSprite;

class CharacterColorTest extends MusicBeatState{
    var bf:Boyfriend;
    var colors:ColorSwap;
    override function create() {
        super.create();
		Paths.setCurrentLevel("shared");

        colors = new ColorSwap();

        bf = new Boyfriend(300, 200, "bf");
        bf.shader = colors.shader;
        add(bf);
        
        var t = new FlxText(20,20,0,"PRESS 0 TO HUE\nPRESS 1 TO BRIGTHNESS\nPRESS 2 TO SATURATION", 55);
        add(t);
    }
    var aidi:Int = 0;

    override function update(elapsed:Float){
        super.update(elapsed);

        if (FlxG.keys.justPressed.R){
            colors.brightness = 0;
            colors.hue = 0;
            colors.saturation = 0;
        }


        if (FlxG.keys.justPressed.ONE){
            aidi = 0;
        }
        if (FlxG.keys.justPressed.TWO){
            aidi = 1;
        }
        if (FlxG.keys.justPressed.THREE){
            aidi = 2;
        }

        if (FlxG.keys.pressed.RIGHT)
            changeas(aidi, 1);
        if (FlxG.keys.pressed.LEFT)
            changeas(aidi, -1);

        if (controls.BACK){
            MusicBeatState.switchState(new Funk4DeadMainMenu());
        }
    }

    function changeas(oidi:Int = 0, assus:Float){
        switch(oidi){
            case 0:
                colors.hue += assus /360;
                trace(colors.hue+ ", " + oidi);
            case 1:
                colors.brightness += assus/100;
                trace(colors.brightness+ ", " + oidi);
            case 2:  
                colors.saturation += assus/100; 
                trace(colors.saturation + ", " + oidi);
        }
    }
}