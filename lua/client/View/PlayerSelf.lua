local ball;
local player;
local arrow;

PlayerId = nil;
local moveSpeed;
local MaxPos;
local scaleSize;
Local dis2Bullet;
local moveDirect;
local targerPos;
local TarPos;
local round;

PlayerSelf = {};
local this = PlayerSelf;

--创建玩家--
function Player.Awake(obj)
	player = obj;
	--transform = obj.transform;

	logWarn("Awake lua--->>"..gameObject.name);
end

function Player.Start()
  moveSpeed = 1;
  MaxPos = Vector3(1920,1080,0);
  this.PlayerAutoMove();
end

function Player.PlayerAutoMove（）
    TarPos = new Vector3(Random.Range(0, MaxPos.x), Random.Range(0, MaxPos.y), 0);
    moveDirect = TarPos - ball.transform.position;
    round = Mathf.Sqrt(Mathf.Pow(moveDirect.x, 2) + Mathf.Pow(moveDirect.y, 2));
    Invoke("PlayerAutoMove", Random.Range(1, 10));
end

function Player.Update()
  targerPos = player.transform.position + (moveSpeed / round) *moveSpeed;
  player.transform.position = Vector3(Mathf.Clamp(targetPos.x, 0, MaxPos.x), Mathf.Clamp(targetPos.y, 0, MaxPos.y), 0);
  EatBall();
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

function Player.IsShootByBullet(bullet)
  dis2Bullet = Mathf.Sqrt(Mathf.Pow(bullet.transform.position.x - player.transform.position.x, 2) + Mathf.Pow(bullet.transform.position.y - player.transform.position.y, 2));
  if(dis2Bullet < (bullet.transform.localScale.x + player.transform.localScale.x)/10)
  then
    local temp = Mathf.Sqrt(Mathf.Max(0, Mathf.Pow(player.transform.lossyScale.x, 2) - Mathf.Pow(bullet.transform.lossyScale.x * 2, 2)));
    if(temp < 100)
    then
      PlayerManager.DeletePlayerById(PlayerId);
      print("GameObject.Destroy(player)"..PlayerId);
      GameObject.Destroy(Player);
    else
      player.transform.localScale = Vector3(temp,temp,1);
    end
    return true;
  else
    return false;
  end
end

function Player.EatBall()
  for i = 0,10 do
    if(IsInBall(pos))
    then
      float a = Mathf.Sqrt(Mathf.Pow(StarManager.Instance.Stars[i].star.transform.lossyScale.x, 2) + Mathf.Pow(ball.transform.lossyScale.x, 2));
      ball.transform.localScale = new Vector3(a, a, 1);
      GameObject.Destroy(StarManager.Instance.Stars[i].star);
      StarManager.Instance.UnitOffset.Add(StarManager.Instance.Stars[i].OffsetX);
      StarManager.Instance.UnitOffset.Add(StarManager.Instance.Stars[i].OffsetY);
      StarManager.Instance.NewStar();
      StarManager.Instance.Stars.Remove(StarManager.Instance.Stars[i]);
    end
  end
end

function Player.IsInBall(pos)
  local dis = Mathf.Sqrt(Mathf.Pow(pos.x - player.transform.position.x, 2) + Mathf.Pow(pos.y - player.transform.position.y, 2));
  return dis < player.transform.localScale.x /10;
end


