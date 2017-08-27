Players = {};
local this = Players;

local playersObj;
function Players.Awake(obj)
  playersObj = obj;
end

function Players.Start()
  
end

function Players.Update()
  if(#AIPlayers ~= 0) then
    
    for k,v in ipairs(AIPlayers) do
      v:Move();
    end
    
  end
  
end