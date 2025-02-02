package pixelforce;

import flixel.FlxSprite;
import flixel.FlxG;
import flixel.input.keyboard.FlxKey;

using StringTools;

class Bf extends FlxSprite{
    public var startPos:Array<Float> = [100,100];

    //hmmm maybe its the correct speed
    public var SPEED:Int = 360;

    // // ujum, not an actually key, its more a bool constant
    // public var controlList = [
    //     [FlxG.keys.pressed.A, FlxG.keys.pressed.LEFT],
    //     [FlxG.keys.pressed.D, FlxG.keys.pressed.RIGHT],
    //     [FlxG.keys.pressed.S, FlxG.keys.pressed.DOWN],
    //     [FlxG.keys.pressed.W, FlxG.keys.pressed.UP],
    //     [FlxG.keys.pressed.H, FlxG.keys.pressed.O] // i really idk what its the shoot key for the 2p xd
    // ];

    public var control:PlayerControl;

    public var dir:Dirs;

    public function new(startPos:Array<Float>){
        this.startPos = startPos;
        super(startPos[0],startPos[1]);

        /* ok, im can use png spritesheet, but its
         more easyli to use xml files and these shits :v*/
        frames = Paths.getSparrowAtlas("pixel/bf_player", "f4d");
        animation.addByPrefix("idle", "bfidle", 10, true); //12
        animation.addByPrefix("walk-sides", "bfsides", 10, false);
        animation.addByPrefix("walk-down", "bfdown", 10, false);
        animation.addByPrefix("walk-up", "bfup", 10, false);
        animation.addByIndices("idle-up", "bfup", [1], "", 10, false);
        animation.addByIndices("idle-down", "bfdown", [1], "", 10, false);
        animation.play("idle", true);
        antialiasing = false;
        setGraphicSize(Std.int(width * CoolUtil.pixelForceZoom));
        updateHitbox();

        control = new PlayerControl();
    }
    var preffix="-";
    override function update(elapsed:Float){
        super.update(elapsed);
        // controlList = [
        //     [FlxG.keys.pressed.A, FlxG.keys.pressed.LEFT],
        //     [FlxG.keys.pressed.D, FlxG.keys.pressed.RIGHT],
        //     [FlxG.keys.pressed.S, FlxG.keys.pressed.DOWN],
        //     [FlxG.keys.pressed.W, FlxG.keys.pressed.UP],
        //     [FlxG.keys.pressed.H, FlxG.keys.pressed.O] // i really idk what its the shoot key for the 2p xd
        // ];

    
        control.set();
       
        if (animation.curAnim != null){
        switch (animation.curAnim.name.toLowerCase()){
            case "walk-down":
                preffix = "-down";
            case "walk-up":
                preffix = "-up";
            case "walk-sides":
                preffix = "";

        }
        }

        velocity.x = 0;
        velocity.y = 0;

        if (control.LEFT && (!control.DOWN || !control.UP)){
            velocity.x = -SPEED;
            dir = LEFT;
            animation.play("walk-sides", true);
            flipX = true;
        }else{
            animation.play("idle"+preffix,false);
        }

        if (control.RIGHT && (!control.UP || !control.DOWN)){
            velocity.x = SPEED;
            dir = RIGHT;
            animation.play("walk-sides", true);
            flipX = false;
        }else{
            animation.play("idle"+preffix,false);
        }

        if (control.DOWN && (!control.LEFT || !control.RIGHT)){
            velocity.y = SPEED;
            dir = DOWN;
            animation.play("walk-down", true);
            flipX = false;
        }else{
            animation.play("idle"+preffix,false);
        }
        
        if (control.UP && (!control.RIGHT || !control.LEFT)){
            animation.play("walk-up", true);
            velocity.y = -SPEED;
            flipX = false;
            dir = UP;
        }else{
            animation.play("idle"+preffix,false);
        }
            
        if (control.SHOOT){
            Map.instance.spawnBullet(true);
        }else{
            Map.instance.spawnBullet(false);
        }
    }
}

class PlayerControl{
    // OK, I HATE MY LIFE but,
    // i made this class because im
    // enough to use a LONG VARIABLE SHIT MAN
    // okay, let me start
    public function new(){
    //    nothing :v
    }

    public var RIGHT:Bool = false;
    public var LEFT:Bool =  false;
    public var UP:Bool = false;
    public var DOWN:Bool = false;
    public var SHOOT:Bool = false;
    public var SHOOT_R:Bool = false;
    public function set(){
        LEFT = FlxG.keys.anyPressed([A, FlxKey.LEFT]);
        RIGHT = FlxG.keys.anyPressed([D, FlxKey.RIGHT]);
        DOWN = FlxG.keys.anyPressed([S, FlxKey.DOWN]);
        UP = FlxG.keys.anyPressed([W, FlxKey.UP]);

        SHOOT = FlxG.keys.anyPressed([H, M]);
        SHOOT_R = FlxG.keys.anyJustReleased([H, M]);
    }
}


enum Dirs {
    LEFT;
    RIGHT;
    DOWN;
    UP;
}