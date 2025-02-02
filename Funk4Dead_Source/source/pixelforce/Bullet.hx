package pixelforce;

import flixel.FlxG;
import pixelforce.Bf.Dirs;
import flixel.FlxSprite;

class Bullet extends FlxSprite{
    public var dir:Bf.Dirs;
    public var bulletSpeed:Int=600;
    public var killers:Array<Zombie> = [];
    public var attach:FlxSprite;
    public function new (attach:FlxSprite){
         super();
         this.attach = attach;
         killers = [];
         loadGraphic(Paths.image("pixel/bullet", "f4d"));
         setGraphicSize(Std.int(width*CoolUtil.pixelForceZoom));
         updateHitbox();
         antialiasing = false;
        //  init posit
         switch(dir){
            case LEFT:
                setPosition(attach.x+attach.width/2, (attach.y+attach.height/2)+9);
            case RIGHT:
                setPosition(attach.x+attach.width/2, (attach.y+attach.height/2)+9);
            case UP:
                setPosition((attach.x+attach.width/2)+8, (attach.y+attach.height/2));
            case DOWN:
                setPosition((attach.x+attach.width/2)-13, (attach.y+attach.height/2));
        }
    }

    override function update(elapsed:Float) {
        super.update(elapsed);

        switch(dir){
            case LEFT:
                velocity.x = -bulletSpeed;
                angle = 180;
            case RIGHT:
                angle = 0;
                velocity.x = bulletSpeed;
            case UP:
                velocity.y = -bulletSpeed;
                angle = 90;
            case DOWN:
                velocity.y = bulletSpeed;
                angle = 270;
        }
    }

    public function killingObjects(){
        for (i in 0...killers.length){
        if (FlxG.pixelPerfectOverlap(this, killers[i],255)){
            kill();
            destroy();
            killers[i].die();
        }
        }

    }
}