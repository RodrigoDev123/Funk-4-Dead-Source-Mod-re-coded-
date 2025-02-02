#if desktop
import Discord.DiscordClient;
#end
import flixel.FlxSprite;
import flixel.text.FlxText;
import flixel.math.FlxMath;
import flixel.FlxG;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.input.mouse.FlxMouseEventManager;
import flixel.input.mouse.FlxMouseEvent;
import flixel.addons.transition.FlxTransitionableState;
import flixel.input.keyboard.FlxKey;

class Funk4DeadMainMenu extends MusicBeatState{

    var menuList = ["play", "survivors", "mutation", "options"];
    var menuGrp:FlxTypedGroup<FlxSprite>;
    public static var curSelected:Int = 0;
    var selectedSomethin:Bool = false;
    var menucursor:FlxSprite;
    var debugKeys:Array<FlxKey>;
    override function create(){
        super.create();

        #if MODS_ALLOWED
		Paths.pushGlobalMods();
		#end
		WeekData.loadTheFirstEnabledMod();

		#if desktop
		// Updating Discord Rich Presence
		DiscordClient.changePresence("In the Menus", null);
		#end
		debugKeys = ClientPrefs.copyKey(ClientPrefs.keyBinds.get('debug_1'));

		transIn = FlxTransitionableState.defaultTransIn;
		transOut = FlxTransitionableState.defaultTransOut;

		persistentUpdate = persistentDraw = true;

        menuGrp = new FlxTypedGroup<FlxSprite>();
        add(menuGrp);

        for (i in 0...menuList.length){
             var menu = new FlxSprite(130.2, 74.25);
             menu.frames = Paths.getSparrowAtlas("menu/menuButtons", "f4d");
             menu.animation.addByPrefix("selected", menuList[i] + " sel", 24, true);
             menu.animation.addByPrefix("unselected", menuList[i] + " unsel", 24, true);
             menu.animation.play("unselected");
             menu.antialiasing = ClientPrefs.globalAntialiasing;
             menu.ID = i;
             menu.x += (110.75+menu.width)*i;
             menu.origin.x += menu.width / 2;
             menu.origin.y += menu.height / 2;
             menuGrp.add(menu);
             FlxMouseEvent.add(menu, 
                function(object:FlxSprite/*mousedown*/){
                    if(!selectedSomethin){
                        // if(object==gfDance){
                        //     var anims = ["singUP","singLEFT","singRIGHT","singDOWN"];
                        //     var sounds = ["GF_1","GF_2","GF_3","GF_4"];
                        //     var anim = FlxG.random.int(0,3);
                        //     gfDance.holdTimer=0;
                        //     gfDance.playAnim(anims[anim]);
                        //     FlxG.sound.play(Paths.sound(sounds[anim]));
                        // }else{
                            for(obj in menuGrp.members){
                                if(obj==object){
                                    accept();
                                    break;
                                }
                            }
                        // }
                    }
                },
                function(object:FlxSprite/**onUp**/){

                },
                function(object:FlxSprite/**onmouseover**/){
                    if(!selectedSomethin){
                        for(idx in 0...menuGrp.members.length){
                            var obj = menuGrp.members[idx];
                            if(obj==object){
                                if(idx!=curSelected){
                                    FlxG.sound.play(Paths.sound('scrollMenu'));
                                    changeItem(idx,true);
                                }
                            }
                        }
                    }
                },
                function(object:FlxSprite/**onmouseout**/){
                });
        }

        menucursor = new FlxSprite(0,0,Paths.image("f4dCursor", "f4d"));
		menucursor.loadGraphic(Paths.image("f4dCursor", "f4d"));
		menucursor.antialiasing = ClientPrefs.globalAntialiasing;
		menucursor.screenCenter();
		FlxG.mouse.visible = true;
        changeItem(0,false);
    }

    var shitcounter:Int = 0;
    override function update(elapsed:Float){
        super.update(elapsed);
        
        FlxG.mouse.load(menucursor.pixels,0.9);

        if (FlxG.keys.justPressed.EIGHT){
            FlxG.switchState(new pixelforce.Map());
        }

        if (controls.UI_LEFT_P){
            changeItem(-1);
        }
        if (controls.UI_RIGHT_P){
            changeItem(1);
        }
        shitcounter = 0;
        if (controls.UI_RIGHT){
            shitcounter+= Std.int(Math.pow(Math.pow(2,2),2));
            if (shitcounter % 256 == 0){
                shitcounter = 0;
                changeItem(1);
            }
        }
        if (controls.UI_LEFT){
            shitcounter+=Std.int(Math.pow(Math.pow(2,2),2));
            if (shitcounter % 256 == 0){
                shitcounter = 0;
               changeItem(-1);
            }
        }

        trace(shitcounter);

        menuGrp.forEach(function(spr:FlxSprite)
        {
            var lerpvalue:Float = CoolUtil.boundTo(elapsed * 9.2, 0, 1);
            if (spr.ID == curSelected){
                var mult = FlxMath.lerp(spr.scale.x, 1.18, lerpvalue);
                spr.scale.set(mult,mult);
                // spr.updateHitbox();
            }else{
                var mult = FlxMath.lerp(spr.scale.x, 1, lerpvalue);
                spr.scale.set(mult,mult);
                // spr.updateHitbox();    
            }
        });
    }

    public function accept() {
        switch (menuList[curSelected]){
            case "play":
                MusicBeatState.switchState(new StoryMenuState());
            case "survivors":
                MusicBeatState.switchState(new CreditsState());
            case "mutation":
                MusicBeatState.switchState(new FreeplayState());  
            case "options":
                LoadingState.loadAndSwitchState(new options.OptionsState());
        }
    }

	function changeItem(huh:Int = 0,force:Bool=false)
	{
		if(force){
			curSelected=huh;
		}else{
			curSelected += huh;

			if (curSelected >= menuList.length)
				curSelected = 0;
			if (curSelected < 0)
				curSelected = menuList.length - 1;
		}

        for (item in menuGrp.members){
             item.animation.play("unselected");
             if (item.ID == curSelected){
                 item.animation.play("selected");
             }
        }
	}
}