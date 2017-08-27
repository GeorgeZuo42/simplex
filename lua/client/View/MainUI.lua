MainUI = {};
local this = MainUI;

local MultiTable = {result = "succ",OnlinePlayers = {}}
for i = 2,6 do 
 local player = {};
 player.userName = "OnlinePlayer"..tostring(i);
 player.playerId = i;
 table.insert(MultiTable.OnlinePlayers,player);
  --MultiTable.OnlinePlayers.Add(player);
end

local MainUIObj;
local SingleBtn;
local MultiBtn;

function MainUI.Load()
  MainUIObj = Instantiate(Resources.Load("Prefabs/MainUI"));
  MainUIObj.transform:SetParent(Canvas);
  MainUIObj.transform.localPosition = Vector3.zero;
  this.Init();
end


function MainUI.Init()
  local luabeh = MainUIObj:GetComponent("LuaBehaviour");
  SingleBtn = MainUIObj.Find("SingleBtn");
  MultiBtn = MainUIObj.Find("MultiBtn");
  
  luabeh:AddClick(MultiBtn, this.OnClickMultiBtn);
  luabeh:AddClick(SingleBtn, this.OnClickSingleBtn);
end


function MainUI.OnClickSingleBtn()
  this.SetState(false);
  BattleManager.SigleBattleInit();
end

function MainUI.OnClickMultiBtn()
  local MatchTable = {}
  MatchTable.type = "aoi_enter";
  MatchTable.massage = {
    userName = login_req.message.user_name;
    }
  Network.AOIEnter(MatchTable);
  --this.SetFalse();
  --BattleManager.OnlineBattleInit(MultiTable);
end

function MainUI.SetState(state)
  MainUIObj:SetActive(state);
end


