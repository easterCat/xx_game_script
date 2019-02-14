function clickPos(i)
	toast("等待第"..i.."次点击")
	screen_w = getNumberConfig("screen_w",1)
	screen_h = getNumberConfig("screen_h",1)
	x1,y1 = catchTouchPoint()
	mx = screen_h - y1
	my = x1
	toast("x:"..mx.." y:"..my)
	setNumberConfig("x"..i,mx)
	setNumberConfig("y"..i,my)
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
	
	dialog(
		"x1:"..getNumberConfig("x1",18).."_y1:"..getNumberConfig("y1",18).."\r\n"..
		"x2:"..getNumberConfig("x2",18).."_y2:"..getNumberConfig("y2",18).."\r\n"..
		"x3:"..getNumberConfig("x3",18).."_y3:"..getNumberConfig("y3",18).."\r\n"..
		"x4:"..getNumberConfig("x4",18).."_y4:"..getNumberConfig("y4",18).."\r\n"..
		"x5:"..getNumberConfig("x5",18).."_y5:"..getNumberConfig("y5",18).."\r\n"..
		"x6:"..getNumberConfig("x6",18).."_y6:"..getNumberConfig("y6",18).."\r\n"
		, 3)
	
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
mSleep(1000)

w,h = getScreenSize()
toast("屏幕宽高:".."("..w..","..h..")") -- (1125,2001)
setNumberConfig("screen_w",w)
setNumberConfig("screen_h",h)
mSleep(1000)

setTimer(1000,getUserClick())