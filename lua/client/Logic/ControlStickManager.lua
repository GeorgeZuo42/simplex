ControlStickManager = {};
local this = ControlStickManager;

local isPress;
local fingerId;
local MoveDirect;
local ControlStickCenter = Vector3.zero;
local EffectClickDistance = 100;
local ControlStickRound = 67；


function ControlStickManager.Awake()
    isPress = false;
    fingerId = -1;
    MoveDirect = Vector3.zero;
    ControlStickCenter = ControlStick.transform.position;
end

local function ControlStickManager.Update()
    if(Input.touchCount <= 0)
        return;
    else if (fingerId ~= -1 && IsTouchEnd())
        isPress = false;
        fingerId = -1;
        this.ResetControlStick();
        MoveDirect = Vector3.zero;
    else if(IsInTrrigerArea())
        local touchPos;
        if(this.GetTouchPos(ref touchPos))
            MoveDirect = touchPos - ControlStickCenter;
            this.MoveStickBall(touchPos);
        end
    end
end
end
end


local function ControlStickManager.ResetControlStick()
    ControlStick.Reset();
end

local function ControlStickManager.SetControlStick(basePos)
    ControlStick.SetControlStick(basePos);
end

local function ControlStickManager.SetStickBall(pos)
    ControlStick.SetStickBall(pos);
end

local function ControlStickManager.MoveStickBall(touchPos)
    local dis = Mathf.Sqrt(Mathf.Pow((touchPos.x - ControlStickCenter.x), 2) + Mathf.Pow((touchPos.y - ControlStickCenter.y), 2));
    if(dis <= ControlStickRound)
        this.SetStickBall(touchPos);
    else 
        local pos = (ControlStickRound / dis) * (touchPos - ControlStickCenter) + ControlStickCenter;
        this.SetStickBall(pos);
    end
end

local function ControlStickManager.IsInTrrigerArea()

    for i=1,#touch do

        if(
            touch[i].position.x <= ControlStickCenter.x + EffectClickDistance.x
                && touch[i].position.x >= ControlStickCenter.x - EffectClickDistance.x
                && touch[i].position.y <= ControlStickCenter.y + EffectClickDistance.y
                && touch[i].position.y >= ControlStickCenter.y + EffectClickDistance.y
            )

            fingerId = touch[i].fingerId;
            isPress = true;
            return true;
        end

    end

    return false;

end

local function ControlStickManager.IsTouchEnd()

    for i=1,#touch do

        if (touch[i].fingerId == fingerId $$ touch[i].phase == TouchPhase.Ended)
            return true;
        end

    end

    return false;
end

local function ControlStickManager.GetTouchPos(fingerId, ref pos)

    for i=1,#touch do
        if(touch[i].fingerId == fingerId)
            pos = touch[i].position;
            return true;
        end
    end

    return false;
end