local transform;
local gameObject;

MainCamera = {};
local this = MainCamera;


--启动相机--
function MainCamera.Awake(obj)
	gameObject = obj;
	transform = obj.transform;

	this.InitMainCamera();
	print("Awake lua--->>"..gameObject.name);
end
function MainCamera.Start()
end
function MainCamera.Update()
end

--初始相机位置--
function MainCamera.InitMainCamera()
	transform.position = Vector3(960,640,0);
end

--设置相机位置--
function MainCamera.SetPosition(Pos)
	transform.position = Vector3(Pos.x,Pos.y,0);
end