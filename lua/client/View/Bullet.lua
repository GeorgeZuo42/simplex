Bullet = {}
Bullet.__index = Bullet;
local this = Bullet;

BulletParent = GameObject.Find("Bullets").transform;


--创建玩家--
function Bullet:New(playerId,pos,speed,direct,range)
  local temp = {}
  setmetatable(temp,Bullet)
  temp.playerId = playerId;
  temp.speed = speed;
  temp.direct = direct / (Mathf.Sqrt(Mathf.Pow(direct.x, 2) + Mathf.Pow(direct.y, 2)));
  temp.range = range;
  temp.startPos = pos;

  temp.bullet = Instantiate(Resources.Load("Prefabs/bullet"));
  temp.bullet.name = "bullet"..tostring(playerId);
  temp.bullet.transform:SetParent(BulletParent);
  temp.bullet.transform.position = pos;
  
  return temp;
end

function Bullet:MoveDis()
  return Mathf.Sqrt(Mathf.Pow(self.bullet.transform.position.x - self.startPos.x, 2) + Mathf.Pow(self.bullet.transform.position.y - self.startPos.y, 2));
end

function Bullet:DeleteBullet()
  GameObject.Destroy(self.bullet);
end

function Bullet:ShootTest()
  if(#AllPlayers > 0) then
    for k,v in ipairs(AllPlayers) do
      if(self.playerId ~=v.playerId) then
        if(v:IsShootByBullet(self)) then
          self:DeleteBullet();
          return true;
        end
      end
    end
  end

  return false;
end

return this;