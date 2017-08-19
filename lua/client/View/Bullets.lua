
local bulletsObj;
Bullets = {};
local this = Bullets;

BulletTable = {};

function Bullets.NewBullet(playerId,pos,speed,direct,range)
  local bullet = Bullet:New(playerId,pos,speed,direct,range);
  table.insert(BulletTable,bullet);
end

function Bullets.Awake(obj)
  bulletsObj = obj;
end

function Bullets.Start()
  --BulletTable = nil;
end

function Bullets.Update()
  if(#BulletTable ~= 0) then
    for k,v in ipairs(BulletTable) do
      if(v:MoveDis() < v.range) then
        --print(typeof(v.bullet));
        --print("direct = "..dump(v.direct).."position = ".."v.speed = "..v.speed);
        v.bullet.transform.position = v.bullet.transform.position +  Vector3(v.direct.x * v.speed,v.direct.y * v.speed,0);
        if(v:ShootTest()) then 
          table.remove(BulletTable,k);
        end
      else
        v:DeleteBullet();
        table.remove(BulletTable,k);
      end
    end
  end
end
