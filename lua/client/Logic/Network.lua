local json = require"cjson";

Network = {};
local this = Network;

local socket = require("socket")
local ReceiveStr;
local ReceiveData;

host = "192.168.31.249 ";
port = 5678;

c = assert (socket.connect (host, port));
c:settimeout(0);
--socket.AddEvent(c,this.CoroutineReceive);


local heartbeat_rsp_data = {
  type = "heartbeat"
}

local self_pos_data = {
  type = "self_pos"
  }

local heartbeat_rsp_str = json.encode(heartbeat_rsp_data);


function Network.CoroutineReceive()
  print("Network.CoroutineReceive()");
  ReceiveStr = c:receive();
  
  if(ReceiveStr ~= nil) then
    print("server receive: "..ReceiveStr);
    ReceiveData = json.decode(ReceiveStr);
    if(ReceiveData.type == "heartbeat") then
      this.Heartbeat();
    elseif(ReceiveData.type == "login") then
      this.LoginRspHandler();
    elseif(ReceiveData.type == "aoi_enter") then
      this.MatchRspHandler();
    elseif(ReceiveData.type == "move") then
      this.MoveRspHandler();
    else
      print("Receive str = "..ReceiveStr);
    end
  end
  
  coroutine.wait(1);
  print("receive again");
  this.CoroutineReceive();
end

function Network.Start()
  print("Network.Start()");
  cr = coroutine.create(this.CoroutineReceive);
  coroutine.resume(cr);
end



function Network.Heartbeat()
  c:send(heartbeat_rsp_str);
end

function Network.LoginRspHandler()
  if(ReceiveData.status == "error") then
    print("login failure,ReceiveData.status = "..ReceiveData.status);
    --ShowTips.Login("login failure,s = "..s);
  else
    print("login successful");
    LoginUI.Destroy();
    MainUI.Load();
  end
end

function Network.MatchRspHandler()
  if(ReceiveData.status == "error") then
    print("match failure,ReceiveData.status = "..ReceiveData.status);
  else
    print("match successful,ReceiveData.status = "..ReceiveData.status);
    MainUI.SetState(false);
    BattleManager.OnlineBattleInit(json.decode(ReceiveData.message));
  end
end

function Network.MoveRspHandler()
  PlayerManager.SetOtherPlayerPos(json.decode(ReceiveData.message));
end

function Network.Login(login_req_data)
  c:send(json.encode(login_req_data));

  --[[local s, status, partial = coroutine.start(c:receive());
    if(s ~= nil) then
      print("server receive: "..s);
      if(s == "error") then
        print("login failure,s = "..s);
        --ShowTips.Login("login failure,s = "..s);
      else
        local loginRcv = json.decode(s);
        print(dump(loginRcv));
        if(loginRcv[result] == succ) then
          print("login successful");
          LoginUI.Destroy();
          MainUI.Load();
        end
      end
    end--]]
  end

function Network.AOIEnter(single_match_req_data)
  c:send(json.encode(single_match_req_data));
  
--[[
    local s, status, partial = coroutine.start(c:receive());
    if(s ~= nil) then
      --print("server receive: "..s);
      --if(s == "error") then
        --print("match failure,s = "..s);
        --ShowTips.Match("match failure,s = "..s);
      --else
        local MultiTable = json.decode(s);
        --if(MultiTable.result == succ) then
          --print(loginRcv.userName.."login successful");
          MainUI.SetState(false);
          BattleManager.OnlineBattleInit(MultiTable);
        --end
    end
--]]
end


function Network.SendSelfPos()
  self_pos_data.message = {
    pos = PlayerSelf.obj.transform.position;
    }
  c:send(json.encode(self_pos_data));
end
--[[
function Network.HeartBeat()
  local ping = coroutine.start(c:receive());
  if(ping ~= nil) then
    print("server receive: "..ping);
    local rcvData = json.decode(ping);
    if(rcvData.type == "ping") then
      c:send(pong);
    end
  end
  coroutine.wait(10);
  coroutine.start(this.HeartBeat);
end
--]]
return this;

