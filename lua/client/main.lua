require "common/define"
--require("mobdebug").start(ip, port)

print("main.lua: start");
UnityEngine.SceneManagement.SceneManager.LoadScene("client");

for i=1,#ViewNames do
  require("View/"..tostring(ViewNames[i]));
  print("View/"..tostring(ViewNames[i]));
end

os.exit = function()
    UnityEngine.Application.Quit()
end
