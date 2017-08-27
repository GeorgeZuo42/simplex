LoginUI = {};
local this = LoginUI;

login_req = {};
local loginUIObj;
local userNameInput;
local passwordInput;
local loginBtn;
local luab;

Canvas = UnityEngine.GameObject.Find("Canvas").transform;

function LoginUI.Load()
  loginUIObj = Instantiate(Resources.Load("Prefabs/LoginUI"));
  loginUIObj.transform:SetParent(Canvas);
  loginUIObj.transform.localPosition = Vector3.zero;
  this.Init();
end


function LoginUI.Init()
  userNameInput = loginUIObj.Find("UserName");
  passwordInput = loginUIObj.Find("Password");
  loginBtn = loginUIObj.Find("Login"); --:GetComponent("Button");
  local luab = loginUIObj:GetComponent('LuaBehaviour');
  luab:AddClick(loginBtn, this.OnClickLoginBtn);
  --loginBtn.onClick.AddListener (this.OnClickLoginBtn);
end

function LoginUI.Destroy()
  GameObject.Destroy(loginUIObj);
end

function LoginUI.OnClickLoginBtn()
  login_req.type = "login";
  login_req.message = {
    user_name = userNameInput.Find("InputName"):GetComponent("Text").text;
    password = passwordInput.Find("InputPassword"):GetComponent("Text").text;
    }
  local network = require "Logic/Network";
  print("require network over");
  network.Start();
  network.Login(login_req);
  --this.Destroy();
  --MainUI.Load();
end

