local transform;
local gameObject;

Player = {};
local this = Player;

--创建玩家--
function Player.Awake(obj)
	gameObject = obj;
	transform = obj.transform;

	logWarn("Awake lua--->>"..gameObject.name);
end

--设置玩家位置--
function Player.SetPosition(pos)
    transform.position = pos;
end

--设置玩家大小--
function Player.SetPosition(sca)
    transform.scale = sca;
end

--销毁玩家--
function Player.OnDestroy()
	logWarn("OnDestroy---->>>"..gameObject.name);
end