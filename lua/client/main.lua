require "common/define"

--require("mobdebug").start(ip, port)

print("main.lua: start");
UnityEngine.SceneManagement.SceneManager.LoadScene("client");
  for i=1,#ViewNames do
    require("View/"..tostring(ViewNames[i]));
    --print("View/"..tostring(ViewNames[i]));
  end

function LoadSceneDone()
  
  for i=1,#LogicNames do
    require("Logic/"..tostring(LogicNames[i]));
  end
  
  for i=1,#AfterSceneLoad do
    require(tostring(AfterSceneLoad[i]));
  end

  PlayerManager.CreatePlayerSelf("playerSelf",1,100,Colors.red);
  StarManager.InitStars();
  
  for i = 2,6 do
    PlayerManager.CreateOtherPlayer("player"..tostring(i),i,100 + i * 20,Colors.yellow);
  end
  
end
