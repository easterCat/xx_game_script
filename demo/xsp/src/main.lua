
function clickPos(i)
	toast("等待第"..i.."次点击")
	x1,y1 = catchTouchPoint()
	toast("x:"..x1.." y:"..y1)
	setNumberConfig("x"..i,x1)
	mSleep(1000)
end

function tap(x, y)
	math.randomseed(tostring(os.time()):reverse():sub(1, 6))  --设置随机数种子
	local index = math.random(1,5)
	x = x + math.random(-2,2)
	y = y + math.random(-2,2)
	touchDown(index,x, y)
	mSleep(math.random(60,80))                --某些特殊情况需要增大延迟才能模拟点击效果
	touchUp(index, x, y)
	mSleep(50)
end

function getUserClick()
	
	for i = 1, 6, 1 do
		clickPos(i)
		mSleep(50)
	end
	
	while(true)
	do
		mSleep(1000)
		for j = 1,6,1 do
			x = getNumberConfig("x"..j,18);
			y = getNumberConfig("y"..j,18);
			
			tap(x,y)
			toast("第"..j.."点击x:"..x.."点击y:"..y)
			mSleep(2000)
		end
	end
end

init("0", 2); --以当前应用 Home 键在左边初始化
toast("欢迎使用demo脚本!")
setTimer(1000,getUserClick())


