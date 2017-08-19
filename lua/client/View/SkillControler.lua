local transform;
local rectTransform;
local gameObject;
local StickBall;
local arrow;
local ButtonRound;
ControlerCenter = nil;

local isPress;
local fingerId;
local BulletDirect = Vector3.zero;
local EffectClickDistance = 200;
local ControlStickRound = 150;

SkillControler = {};
local this = SkillControler;

--创建摇杆--
function SkillControler.Awake(obj)
	gameObject = obj;
	arrow = obj.transform:Find("Arrow"):GetComponent("RectTransform");

	print("Awake lua--->>"..gameObject.name);
end

function SkillControler.Start()
  ButtonRound = 150;
  ControlerCenter = arrow.position;
  print("ControlerCenter position "..dump(ControlerCenter));
  isPress = false;
  fingerId = -1;
  BulletDirect = Vector2.zero;
end

--初始化摇杆--
function SkillControler.Reset()
    arrow.anchoredPosition = Vector3.zero;
    arrow.rotation = Vector3.zero;
end

--设置arrow位置--
function SkillControler.SetArrow(dir)
  
  local dirLength = Mathf.Sqrt(Mathf.Pow(dir.x, 2) + Mathf.Pow(dir.y,2));
  --print("dir.magnitude = "..dir.magnitude..", dirLength = "..dirLength.."dir = "..dump(dir));
  arrow.anchoredPosition = (ButtonRound / dir.magnitude) * dir;
end

--每帧检测-----
function SkillControler.Update()
  --print("ControlStick.Update>>>>>>>>>>>>>>>>>>>>");
  if(Input.touchCount <= 0) 
  then
    --print("Input.touchCount = "..Input.touchCount);
    return;
  elseif(fingerId ~= -1 and this.IsTouchEnd()) 
  then
    if(BulletDirect ~= Vector2.zero) then
      Bullets.NewBullet(PlayerSelf.playerId,PlayerSelf.obj.transform.position,5,BulletDirect,500);
    end
    
    isPress = false;
    fingerId = -1;
    this.Reset();
    BulletDirect = Vector2.zero;
    PlayerManager.SetPlayerArrow(BulletDirect);
  elseif(isPress)
  then
    local touchPos = this.GetTouchPos();
    if(touchPos)
    then
      BulletDirect = touchPos - ControlerCenter;
      this.SetArrow(BulletDirect);
      PlayerManager.SetPlayerArrow(BulletDirect);
    else
      print("ispress = "..tostring(isPress).."and touchPos = "..tostring(touchPos));
    end
  elseif(this.IsInTrrigerArea())
  then
    
    local touchPos = this.GetTouchPos();
    if(touchPos)
    then
      BulletDirect = touchPos - ControlStickCenter;
      this.SetArrow(BulletDirect);
      PlayerManager.SetPlayerArrow(BulletDirect);
    else
      print("IsInTrrigerArea = "..tostring(IsInTrrigerArea()).."and touchPos = "..tostring(touchPos));
    end
  end
end

function SkillControler.IsInTrrigerArea()
  --for i,v in pairs(Input.touches) do
    --if(v.position.x <= ControlStickCenter.x + EffectClickDistance
        --and v.position.x >= ControlStickCenter.x - EffectClickDistance
        --and v.position.y <= ControlStickCenter.y + EffectClickDistance
        --and v.position.y >= ControlStickCenter.y + EffectClickDistance
      --)
    --then
    --print("Input.touchCount = "..Input.touchCount.."--");
  for i = 0, Input.touchCount-1 do
    --print("Input.touches[i].position = "..dump(Input.touches[i].position).."----ControlStickCenter = "..dump(ControlStickCenter).."EffectClickDistance = "..EffectClickDistance);
    if(
      Input.touches[i].position.x <= ControlerCenter.x + EffectClickDistance
        and Input.touches[i].position.x >= ControlerCenter.x - EffectClickDistance
        and Input.touches[i].position.y <= ControlerCenter.y + EffectClickDistance
        and Input.touches[i].position.y >= ControlerCenter.y - EffectClickDistance
      )
    then
      fingerId = Input.touches[i].fingerId;
      isPress = true;
      return true;
    end
  end

  return false;
end

function SkillControler.IsTouchEnd()
  --for i,v in pairs(Input.touches) do
  for i = 0,Input.touchCount-1 do
    if (Input.touches[i].fingerId == fingerId and Input.touches[i].phase == TouchPhase.Ended)
    then
      return true;
    end
  end
  
  return false;
end

function SkillControler.GetTouchPos()
  for i = 0,Input.touchCount-1 do
    if(Input.touches[i].fingerId == fingerId)
    then
      return Input.touches[i].position;
    end
  end

  return nil;
end