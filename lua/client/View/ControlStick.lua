local transform;
local rectTransform;
local gameObject;
local StickBall;
ControlStickCenter = nil;

local isPress;
local fingerId;
local MoveDirect;
local EffectClickDistance = 400;
local ControlStickRound = 150;

ControlStick = {};
local this = ControlStick;

--创建摇杆--
function ControlStick.Awake(obj)
	gameObject = obj;
	transform = obj.transform;
  rectTransform = obj:GetComponent("RectTransform");

  StickBall = transform:Find("StickBall"):GetComponent("RectTransform");
  
  this.Reset();
  
  isPress = false;
  fingerId = -1;
  MoveDirect = Vector3.zero;

	print("Awake lua--->>"..gameObject.name);
end

function ControlStick.Start()
  
end

--初始化摇杆--
function ControlStick.Reset()
    transform.position = Vector3.zero;
    --print("stickBall pos.x = "..StickBall.localPosition.x.."----pos.x = "..StickBall.position.x);
    StickBall.anchoredPosition = Vector3.zero;
    --print("stickBall pos.x = "..StickBall.localPosition.x.."----pos.x = "..StickBall.position.x);
    --print("rectTransform.sizeDelta.width = "..dump(rectTransform.sizeDelta));
    ControlStickCenter = Vector3(rectTransform.sizeDelta.x / 2,rectTransform.sizeDelta.y / 2,0) + transform.position;
end


--设置摇杆基点位置--
function ControlStick.SetBasePosition(pos)
    transform.position = pos - ControlStickCenter;
    ControlStickCenter = pos;
end


--设置摇杆球位置--
function ControlStick.SetStickBall(pos)
    StickBall.position = pos;
end


--table解析----
function dump(o)
   if type(o) == 'table' then
      local s = '{ '
      for k,v in pairs(o) do
         if type(k) ~= 'number' then k = '"'..k..'"' end
         s = s .. '['..k..'] = ' .. dump(v) .. ','
      end
      return s .. '} '
   else
      return tostring(o)
   end
end

--每帧检测-----
function ControlStick.Update()
  --print("ControlStick.Update>>>>>>>>>>>>>>>>>>>>");
  if(Input.touchCount <= 0) 
  then
    --print("Input.touchCount = "..Input.touchCount);
    return;
  elseif(fingerId ~= -1 and this.IsTouchEnd()) 
  then
    isPress = false;
    fingerId = -1;
    this.Reset();
    MoveDirect = Vector3.zero;
  elseif(isPress)
  then
    local touchPos = this.GetTouchPos();
    if(touchPos)
    then
      MoveDirect = touchPos - ControlStickCenter;
      this.MoveStickBall(touchPos);
    else
      print("ispress = "..tostring(isPress).."and touchPos = "..tostring(touchPos));
    end
  elseif(this.IsInTrrigerArea())
  then
    print("IsInTrrigerArea = true");
    local touchPos = this.GetTouchPos();
    if(touchPos)
    then
      print("touchPos = true");
      this.SetBasePosition(touchPos);
      --MoveDirect = touchPos - ControlStickCenter;
      --this.MoveStickBall(touchPos);
    else
      print("IsInTrrigerArea = "..tostring(IsInTrrigerArea()).."and touchPos = "..tostring(touchPos));
    end
  end
end
    
  --移动指示球--
function ControlStick.MoveStickBall(touchPos)
    local dis = Mathf.Sqrt(Mathf.Pow((touchPos.x - ControlStickCenter.x), 2) + Mathf.Pow((touchPos.y - ControlStickCenter.y), 2));
    if(dis <= ControlStickRound)
    then
        this.SetStickBall(touchPos);
    else 
        local pos = (ControlStickRound / dis) * (touchPos - ControlStickCenter) + ControlStickCenter;
        this.SetStickBall(pos);
    end
end

function ControlStick.IsInTrrigerArea()
  --for i,v in pairs(Input.touches) do
    --if(v.position.x <= ControlStickCenter.x + EffectClickDistance.x
        --and v.position.x >= ControlStickCenter.x - EffectClickDistance.x
        --and v.position.y <= ControlStickCenter.y + EffectClickDistance.y
        --and v.position.y >= ControlStickCenter.y + EffectClickDistance.y
      --)
    --then
    print("Input.touchCount = "..Input.touchCount.."--");
  for i = 0, Input.touchCount-1 do
    --print("Input.touches[i].position = "..dump(Input.touches[i].position).."----ControlStickCenter = "..dump(ControlStickCenter).."EffectClickDistance = "..EffectClickDistance);
    if(
      Input.touches[i].position.x <= Screen.width / 3 --ControlStickCenter.x + EffectClickDistance
        --and Input.touches[i].position.x >= ControlStickCenter.x - EffectClickDistance
        and Input.touches[i].position.y <= Screen.height / 3 *2 --ControlStickCenter.y + EffectClickDistance
        --and Input.touches[i].position.y <= ControlStickCenter.y - EffectClickDistance
      )
    then
      fingerId = Input.touches[i].fingerId;
      isPress = true;
      return true;
    end
  end

  return false;
end

function ControlStick.IsTouchEnd()
  --for i,v in pairs(Input.touches) do
  for i = 0,Input.touchCount-1 do
    if (Input.touches[i].fingerId == fingerId and Input.touches[i].phase == TouchPhase.Ended)
    then
      return true;
    end
  end
  
  return false;
end

function ControlStick.GetTouchPos()
  for i = 0,Input.touchCount-1 do
    if(Input.touches[i].fingerId == fingerId)
    then
      return Input.touches[i].position;
    end
  end

  return nil;
end