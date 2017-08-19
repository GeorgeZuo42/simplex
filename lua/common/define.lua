MaxPos = Vector3(1920,1080.0);

ViewNames = {
	"ControlStick",	
  "MainCamera",
  "SkillControler",
  "Bullets",
  "Players",
}

LogicNames = {
	--"ControlStickManager",	
  "PlayerManager",
  "StarManager",
}

AfterSceneLoad = {
   "View/Bullet",
   "View/Player",
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