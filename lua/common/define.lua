MaxPos = Vector3(1920,1080.0);

ViewNames = {
	"ControlStick",	
  "MainCamera",
  "SkillControler",
  "Bullets",

  "MainUI",
}

LogicNames = {
	--"ControlStickManager",	
  "PlayerManager",
  "StarManager",
  "BattleManager",
}

AfterSceneLoad = {
   "View/Bullet",
   "View/Player",
   "View/LoginUI",
  "View/Players",
  }

Colors = {
  red = 1,
  yellow = 2,
  }

Input = UnityEngine.Input;
Screen = UnityEngine.Screen;
GameObject = UnityEngine.GameObject;
Resources = UnityEngine.Resources;
Instantiate = UnityEngine.Object.Instantiate;