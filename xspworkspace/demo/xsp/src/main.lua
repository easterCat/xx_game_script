function clickPos(i)
	toast("等待第"..i.."次点击")
	x1,y1 = catchTouchPoint()
	local screen_w = getNumberConfig("screen_w",1)
	local screen_h = getNumberConfig("screen_h",1)
	local mx = screen_h - y1
	local my = x1
	toast("x:"..mx.." y:"..my)
	setNumberConfig("x"..i,mx)
	setNumberConfig("y"..i,my)
	mSleep(1000)
end


function tap(x, y)
	
	math.randomseed(tostring(os.time()):reverse():sub(1, 6))
	local index = math.random(1,5)
	local screen_h = getNumberConfig("screen_h",1)
	x = x + math.random(-2,2)
	y = y + math.random(-2,2)
	
	--http://bbs.xxzhushou.cn/forum.php?mod=viewthread&tid=88897365&extra=page%3D1%26filter%3Dtypeid%26typeid%3D332
	touchDown(index,x, y)
	local id = createHUD() --创建HUD用于显示点击位置圆点
	local s = screen_h * 0.018 --用于按屏幕大小缩放显示圆点大小
	showHUD(id,"",1,"0xffff0000","d.png",0,x-s,y-s,s*2,s*2) ---d.png为圆点图片，可以用PS做一个
	mSleep(math.random(60,100))
	touchUp(index, x, y)
	mSleep(500)
	hideHUD(id)
	mSleep(math.random(60,100))
end

function getUserClick(times)
	
	for i = 1, times, 1 do
		clickPos(i)
		mSleep(50)
	end
	
	str = ""
	
	for i = 1, times ,1 do
		str = str .. "\r\nx"..i..":"..getNumberConfig("x"..i.."",18).."_y1:"..getNumberConfig("y"..i.."",18)
	end
	
	dialog(str, 3)
	
	while(true)
	do
		mSleep(1000)
		for j = 1,times,1 do
			x = getNumberConfig("x"..j,18);
			y = getNumberConfig("y"..j,18);
			
			tap(x,y)
			toast("第"..j.."点击x:"..x.."点击y:"..y)
			mSleep(2000)
		end
	end
end

function detectScreen()
	w,h = getScreenSize()
	-- https://www.zybuluo.com/xxzhushou/note/726742#ios
	if (w == 1125 and h == 2001) or (w == 1125 and h==2001) then --8p
		jixing = "8p"
	else
		toast("暂不支持此设备,sorry~") --暂不支持此设备
		lua_exit()
	end
	
	toast("当前设备:"..jixing)
end


function initApplication()
	init("0", 2); --以当前应用 Home 键在左边初始化
	toast("欢迎使用demo脚本!")
	mSleep(1000)
	detectScreen()
	mSleep(1000)
end

function uiSelectOptions()
	ret,results = showUI("ui.json")
	
	if ret == 0 then
		toast("您选择了取消，停止脚本运行")
		lua_exit()
	end
	
	if results["selectClickTimes"] == "" or results["selectClickTimes"] == nil then
		option1 = "";
	else
		option1 ="开启点击"
	end
end

function runApplication()
	if option1 == "开启点击" then
		toast("开始执行自动闯关")
		
		toast("您的设备宽高:".."("..w..","..h..")") -- (1125,2001)
		setNumberConfig("screen_w",w)
		setNumberConfig("screen_h",h)
		mSleep(2000)
		
		local times = results["selectClickTimes"]
		
		toast(times)
		
		mSleep(2000)
		
		getUserClick(times)
	end
end

initApplication()
uiSelectOptions()
runApplication()


