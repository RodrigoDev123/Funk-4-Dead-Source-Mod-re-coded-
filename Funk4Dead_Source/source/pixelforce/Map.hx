package pixelforce;

import flixel.util.FlxTimer;
import flixel.FlxSprite;
import flixel.FlxG;
import flixel.text.FlxText;

class Map extends MusicBeatState{
    var bf:Bf;
    var startpos = [0.0,0.0];
     
    public static var instance:Map;

    var enabled:Bool = false;

    var gunType:GunType = GUN;

    var stunnTmr:Float = 1; //for gun

    override function create() {
        super.create();

        instance = this;

        startpos = [300, 400];

        bf = new Bf(startpos);
        add(bf);

        new FlxTimer().start(stunnTmr, function(tmr){
            if (enabled){
                switch (gunType){
                    case SHOTGUN:
                        addSHOTGUNBullet();
                    case MP5:
                        addMP5Bullet();
                }
            }
        },0);
    }

    public function spawnBullet(enab:Bool = false){
       enabled = enab;
    }

    
    function addGunBullet(){
        var bullet = new Bullet(bf);
        bullet.dir = bf.dir;
        add(bullet);
        stunnTmr = 1.0;
    }

    function addMP5Bullet(){
        var bullet = new Bullet(bf);
        bullet.dir = bf.dir;
        add(bullet);
        stunnTmr = 0.7;
    }

    function addSHOTGUNBullet(){
        for (i in 0...3){
            var bullet = new Bullet(bf);
            bullet.dir = bf.dir;
            bullet.ID = i;
            bullet.y += (bullet.height+9)*i;
            switch (i){
                case 0:
                    angle = 35;
                case 1:    
                    angle = 0;
                case 2:   
                    angle = 335;
            }
            add(bullet);
        }
        stunnTmr = 0.83;
    }

    override function update(elapsed:Float){
        super.update(elapsed);

        if (controls.BACK){
            FlxG.switchState(new Funk4DeadMainMenu());
        }

        if (FlxG.keys.justPressed.ONE)
            gunType = GUN;
        if (FlxG.keys.justPressed.TWO)
            gunType = MP5;
        if (FlxG.keys.justPressed.THREE)
            gunType = SHOOTGUN;
    }
}

enum GunType{
    SHOTGUN; //escopeta
    MP5; //mp5
    GUN; //normal gun
}