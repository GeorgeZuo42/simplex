StarManager = {};
local this = StarManager;

Stars = {};
NewStars = {};
UnitPix = 150;

Unit = {};
Unit.__index = Unit;
StarsParent = UnityEngine.GameObject.Find("Stars").transform;

--单元格对象--
function Unit:New(star,starView,offsetX,offsetY)
  local temp = {}
  setmetatable(temp,Unit)
  temp.star = star;
  temp.starView = starView;
  temp.offsetX = offsetX;
  temp.offsetY = offsetY;
  
  return temp;
end

--初始化星星--
function StarManager.InitStars()
  local UnitNumX = Mathf.Floor(MaxPos.x / UnitPix);
  local UnitNumY = Mathf.Floor(MaxPos.y / UnitPix)
  for i = 0, UnitNumX-1 do
    for j = 0, UnitNumY-1 do
      local posX = Mathf.Random(UnitPix * i, UnitPix * (i + 1));
      local posY = Mathf.Random(UnitPix * j, UnitPix * (j + 1));
      
      local star = Instantiate(Resources.Load("Prefabs/star"));
      
      star.name = "star"..tostring(i)..tostring(j);
      star.transform:SetParent(StarsParent);
      star.transform.position = Vector3(posX,posY,0);
      local tstar = star.transform:Find("StarView");

      local a = Unit:New(star,tstar,i,j);
      table.insert(Stars,a);
    end
  end
end

function StarManager.NewStarPre()
  if(#NewStars > 0)
  then
    --print("NewStars = "..#NewStars);
    --print(dump(NewStars));
    local a = Timer.New(this.NewStar,5);
    a:Start();
    
  end   
end

function StarManager.NewStar()
  --print("StarManager.NewStar----------"..dump(NewStars));
  local posX = Mathf.Random(UnitPix * NewStars[1], UnitPix * (NewStars[1] + 1));
  local posY = Mathf.Random(UnitPix * NewStars[2], UnitPix * (NewStars[2] + 1));
  if(this.IsInBall(Vector3(posX,posY,0)))
  then
    table.insert(NewStars,NewStars[1]);
    table.insert(NewStars,NewStars[2]);
    --print("NewStars = add x"..NewStars[1] ..",y = "..NewStars[2]);
    --print("NewStars = delete x"..NewStars[1].. ",y = "..NewStars[2]);
    table.remove(NewStars,1);
    table.remove(NewStars,1);

    this.NewStarPre();
  else
    --print("true----------");
    local star = Instantiate(Resources.Load("Prefabs/star"));
    
    star.name = "star"..tostring(NewStars[1])..tostring(NewStars[2]);
    star.transform:SetParent(StarsParent);
    star.transform.position = Vector3(posX,posY,0);
    local tstar = star.transform:Find("StarView");

    local a = Unit:New(star,tstar,NewStars[1],NewStars[2]);
    table.insert(Stars,a);
    
    --print("NewStars = delete x"..NewStars[1].. ",y = "..NewStars[2]);
    table.remove(NewStars,1);
    table.remove(NewStars,1);
  end
  
end

function StarManager.IsInBall(pos)
  if(#AllPlayers ~= 0) then
    for k,v in ipairs(AllPlayers) do
      local dis = Mathf.Sqrt(Mathf.Pow(pos.x - v.obj.transform.position.x, 2) + Mathf.Pow(pos.y - v.obj.transform.position.y, 2));
      if(dis < v.SelfBall.transform.localScale.x /10) then
        return true;
      end
    end
  end
  return false;
end

return this;
