BattleManager = {}
local this =  BattleManager;

function BattleManager.SigleBattleInit()
  ControlStick.SetState(true);
  SkillControler.SetState(true);
  PlayerManager.CreatePlayerSelf(LoginTable.userName,1,100,Colors.red);
  StarManager.InitStars();
  
  for i = 2,6 do
    PlayerManager.CreateOtherPlayer("AiPlayer"..tostring(i),i,100 + i * 20,Colors.yellow);
  end
end

function BattleManager.OnlineBattleInit(multiTable)
  ControlStick.SetState(true);
  SkillControler.SetState(true);
  --PlayerManager.CreatePlayerSelf(LoginTable.userName,1,100,Colors.red);
  print("multiTable = ",dump(multiTable));
  for k,v in ipairs(multiTable) do
    if(v.name == login_req.message.user_name) then
      PlayerManager.CreatePlayerSelf(v.name,1,100,Colors.red);
    else
      PlayerManager.CreateOnlinePlayer(v.name,k+1,100,Colors.red);
    end
  end
  
  StarManager.InitStars();
end

