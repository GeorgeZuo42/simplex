Players = {};
local this = Players;

local playersObj;
function Players.Awake(obj)
  playersObj = obj;
end

function Players.Start()
  
end

function Players.Update()
  if(#OtherPlayers ~= 0) then
    for k,v in ipairs(OtherPlayers) do
      v:Move();
    end
  end
end