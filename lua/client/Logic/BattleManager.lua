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
  local init_star = false;
  ControlStick.SetState(true);
  SkillControler.SetState(true);
  --PlayerManager.CreatePlayerSelf(LoginTable.userName,1,100,Colors.red);
  print("multiTable = ",dump(multiTable));
  for k,v in ipairs(multiTable) do
    if(v.name == login_req.message.user_name) then
      if(PlayerSelf == nil) then
        PlayerManager.CreatePlayerSelf(v.name,1,100,Colors.red,Vector3(v.pos_x,v.pos_y,0));
        init_star = true;
      end
    else
      PlayerManager.CreateOnlinePlayer(v.name,k+1,100,Colors.red,Vector3(v.pos_x,v.pos_y,0));
    end
  end
  
  if(init_star) then
    StarManager.InitStars();
  end

end

