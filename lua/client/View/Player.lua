
Player = {};
Player.__index = Player;
local this = Player;
local playerArrow;
PlayersParent = UnityEngine.GameObject.Find("Players").transform;


--创建玩家--
function Player:New(playerName,playerId,playerSize,playerColor)
  local temp = {}
  setmetatable(temp,Player)
  temp.player_name = playerName;
  temp.playerId = playerId;
  temp.playerSize = playerSize;
  temp.playerColor = playerColor;
  temp.moveDirect = Vector2(Mathf.Random(0,1),Mathf.Random(0,1));
  temp.moveSpeed = 1;
  
  temp.stepTimer = nil;

  temp.obj = UnityEngine.Object.Instantiate(UnityEngine.Resources.Load("Prefabs/Player"));
  temp.obj.name = playerName;
  temp.obj.transform:SetParent(PlayersParent);
  temp.SelfBall = temp.obj.Find("Ball");
  temp.SelfBall.name = playerName.."ball";
  temp.playerArrow = temp.obj.Find("BallArrow");
  temp.playerName = temp.obj.Find("Name");
  temp.playerName.name = playerName.."Name";
  --print('bef_______'..temp.playerName);
  temp.playerName:GetComponent("TextMesh").text = playerName;
  --print('Afk_______'..temp.name.text);
  --GameObject.SetActive(temp.playerArrow,false)
  temp.playerArrow:SetActive(false);
  temp.obj.transform.position = this.RandomBorn();
  temp.alive = true;

  return temp;
end

function Player.RandomBorn()
  return Vector3(Mathf.Random(0,MaxPos.x), Mathf.Random(0,MaxPos.y),0);
end

function Player:SetSize(newSize)
  self.playerSize = newSize;
  self.round = newSize + 1;
  self.PlayerId = newSize + 1;
end

function Player:Move()
  if(Mathf.Random(0,1000) > 996) then
    PlayerManager.ChangeDirect(self);
  end
  
  local targetPos = Vector2(self.obj.transform.position.x,self.obj.transform.position.y) + Vector2(self.moveSpeed * self.moveDirect.x,self.moveSpeed * self.moveDirect.y);
  self.obj.transform.position = Vector3(Mathf.Clamp(targetPos.x, 0, MaxPos.x), Mathf.Clamp(targetPos.y, 0, MaxPos.y), 0);

  PlayerManager.EatStar(self);
end

function Player:SelfMove(moveDirect,MoveSpeed)
  local round = Mathf.Sqrt(Mathf.Pow(moveDirect.x, 2) + Mathf.Pow(moveDirect.y, 2));
  --print("moveDirect.z = "..moveDirect.z..",moveDirect = "..moveDirect..",round = "..round);
  local targetPos = Vector2(self.obj.transform.position.x,self.obj.transform.position.y) + (MoveSpeed / round) * moveDirect;
  self.obj.transform.position = Vector3(Mathf.Clamp(targetPos.x, 0, MaxPos.x), Mathf.Clamp(targetPos.y, 0, MaxPos.y), 0);
  MainCamera.SetPosition(self.obj.transform.position);

  PlayerManager.EatStar(self);
end

function Player:IsShootByBullet(bullet)
  local dis2Bullet = Mathf.Sqrt(Mathf.Pow(bullet.bullet.transform.position.x - self.obj.transform.position.x, 2) 
    + Mathf.Pow(bullet.bullet.transform.position.y - self.obj.transform.position.y, 2));
  if(dis2Bullet < (bullet.bullet.transform.localScale.x + self.SelfBall.transform.localScale.x)/10)
  then
    local temp = Mathf.Sqrt(Mathf.Max(0, Mathf.Pow(self.SelfBall.transform.lossyScale.x, 2) - Mathf.Pow(bullet.bullet.transform.lossyScale.x * 2, 2)));
    if(temp < 100)
    then
      PlayerManager.DeletePlayer(self);
      print("GameObject.Destroy(player)"..self.playerId);
      --GameObject.Destroy(Player);
    else
      self.SelfBall.transform.localScale = Vector3(temp,temp,1);
    end
    return true;
  else
    return false;
  end
end

function Player:ResetArrow()
  self.playerArrow:SetActive(false);
end

function Player:SetArrow(bulletDirect)
  if(self.playerArrow.activeInHierarchy == false) then
    --print("Player:SetArrow ________");
    self.playerArrow:SetActive(true);
  end
  
  self.playerArrow.transform.localPosition = (self.SelfBall.transform.localScale.x /10/ bulletDirect.magnitude) * bulletDirect; --+ self.SelfBall.transform.position;
  self.playerArrow.transform.localScale = (self.SelfBall.transform.localScale - Vector3(100, 100, 0))/5 + Vector3(100, 100, 0);
end

return this;

