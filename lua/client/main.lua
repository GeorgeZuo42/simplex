
require "common/define";


print("main.lua: start");
UnityEngine.SceneManagement.SceneManager.LoadScene("client");
  for i=1,#ViewNames do
    require("View/"..tostring(ViewNames[i]));
    --print("View/"..tostring(ViewNames[i]));
  end

function LoadSceneDone()
  
  for i=1,#LogicNames do
    require("Logic/"..tostring(LogicNames[i]));
  end
  
  for i=1,#AfterSceneLoad do
    require(tostring(AfterSceneLoad[i]));
  end
  LoginUI.Load();
end
--]]


--[[
function ReceData()
  s, status, partial = c:receive();
end
  
local socket = require("socket")
local json = require 'cjson'

  host = "192.168.31.249 "
  port = 5678
  
  LoginTable = {
    type = "login",
    message = {
    user_name = "mingxi170",
    password = "521775",
    }
  }
  
    aoi_test = {
    type = "aoi_enter",
    message = {
    user_name = "mingxi170",
    password = "521775",
      }
    }
  c = assert (socket.connect (host, port));
  local str = json.encode(LoginTable);
  local aoi_str = json.encode(aoi_test);
  c:send (str);
  coroutine.start(ReceData);
  print("server receive: "..s);

  if(s ~= '') then
    c:send (aoi_str);
    coroutine.start(ReceData);
    print("server receive -----: "..s);
  end
  
    
--]]

--[[
function f1()
  coroutine.start(f2);
  print("f11");
  coroutine.wait(1);
  print("f12");
end

function f2()
  coroutine.start(f3);
  print("f21");
  coroutine.wait(1);
  print("f22");
end

function f3()
  print("f31");
  coroutine.wait(1);
  print("f32");
end

coroutine.start(f1);

--]]