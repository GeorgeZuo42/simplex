

PlayerManager = {};
local this = PlayerManager;

local MoveTimer;
local Move2Pos;
local tempDirect;
local tempDirectLen;


OtherPlayers = {};
AllPlayers = {};
PlayerSelf= nil;
--local SelfBall = nil;

function PlayerManager.CreatePlayerSelf(name,id,size,color)
  print("CreatePlayer..>>>>>>>"..name);
  local k,v;
  k = name;
  PlayerSelf = Player:New(name,id,size,color);
  
  this.EatStar(PlayerSelf);
  MainCamera.SetPosition(PlayerSelf.obj.transform.position);
  
  print(dump(PlayerSelf));
  --SelfBall = PlayerSelf.obj.transform:Find("Ball");
  
  table.insert(AllPlayers,PlayerSelf);
  --print("Player.name = "..v.name..",id ="..v.playerId..",size = "..v.playerSize..",color= "..v.playerColor);
end

function PlayerManager.CreateOtherPlayer(name,id,size,color)
  print("CreatePlayer..>>>>>>>"..name);
  local k,v;
  k = name;
  v = Player:New(name,id,size,color);
  this.EatStar(v);
  table.insert(OtherPlayers,v);
  table.insert(AllPlayers,v);
  --this.PlayerAutoMove(v);
  print("Player.name = "..v.name..",id ="..v.playerId..",size = "..v.playerSize..",color= "..v.playerColor);
end

function PlayerManager.test()
  print("PlayerManager.test-------------------"..#players);
  for k,v in ipairs(players) do
    --print(k,v);
    print("Player.name = "..v.name..",id ="..v.playerId..",size = "..v.playerSize..",color= "..v.playerColor);
    v:SetSize(75);
    print("size = "..v.playerSize..",round = "..v.round..",PlayerId = "..v.PlayerId);
  end
end

function PlayerManager.MovePlayerSelf(MoveDirect)
  PlayerSelf:SelfMove(MoveDirect,1);
end

function PlayerManager.EatStar(player)
  for k,v in ipairs(Stars) do
    if(this.IsInBall(player,v.starView.transform.position))
    then
      local a = Mathf.Sqrt(Mathf.Pow(v.starView.transform.localScale.x, 2) + Mathf.Pow(player.SelfBall.transform.localScale.x, 2));
      --print("Be bigger is "..player.name..", scale before = "..player.SelfBall.transform.localScale.x);
      player.SelfBall.transform.localScale = Vector3(a, a, 1);
      --print("Be bigger is "..player.name..", scale after = "..player.SelfBall.transform.localScale.x);
      
      print("delete star = "..v.star.name);
      GameObject.Destroy(v.star);
      
      table.insert(NewStars,v.offsetX);
      table.insert(NewStars,v.offsetY);
      print("NewStars add x = "..v.offsetX..",y = "..v.offsetY);
      StarManager.NewStarPre();
      
      table.remove(Stars,k);
    end
  end
end

function PlayerManager.IsInBall(player,pos)
  local dis = Mathf.Sqrt(Mathf.Pow(pos.x - player.obj.transform.position.x, 2) + Mathf.Pow(pos.y - player.obj.transform.position.y, 2));
  return dis < player.SelfBall.transform.localScale.x /10;
end

function PlayerManager.SetPlayerArrow(bulletDirect)
  if(bulletDirect == Vector2.zero)
  then
    --print("bulletDirect = 0 "..dump(bulletDirect));
    PlayerSelf:ResetArrow();
  else
    --print("bulletDirect !=0"..dump(bulletDirect));
    PlayerSelf:SetArrow(bulletDirect);
  end
end

function PlayerManager.PlayerAutoMove(player)
  if(player ~= nil and player.alive ~= false) then
    player.stepTimer = Timer.New(PlayerManager.MoveAgain(player),Mathf.Random(1,10));
    player.stepTimer:Start();
  end
end
  
function PlayerManager.ChangeDirect(player)

  if(player ~= nil and player.alive ~= false) then
    Move2Pos = Vector3(Mathf.Random(0, MaxPos.x), Mathf.Random(0, MaxPos.y), 0);
    tempDirect = Move2Pos - player.obj.transform.position;
    tempDirectLen = Mathf.Sqrt(Mathf.Pow(tempDirect.x, 2) + Mathf.Pow(tempDirect.y, 2));
    player.moveDirect = tempDirect / tempDirectLen;
    player.moveSpeed = Mathf.Random(0,2);
  end
  
end

function PlayerManager.DeletePlayer(player)

  GameObject.Destroy(player.obj);
  for k,v in ipairs(AllPlayers) do
    if(v.playerId == player.playerId) then
      table.remove(AllPlayers,k);
    end
  end
  
  for k,v in ipairs(OtherPlayers) do
    if(v.playerId == player.playerId) then
      table.remove(OtherPlayers,k);
    end
  end
    
end

  
return this;