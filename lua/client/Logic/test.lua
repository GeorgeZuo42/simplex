--local coroutine = require "./client/System/coroutine"
function f1()
  coroutine.start(f2);
  print("f1");
end

function f2()
  coroutine.start(f3);
  print("f2");
end

function f3()
  print("f31");
  coroutine.wait(1);
  print("f2");
end

coroutine.start(f1);