init("0", 2); --以当前应用 Home 键在左边初始化
toast("欢迎使用demo脚本!")
mSleep(1000)

w,h = getScreenSize()
toast("屏幕宽高:".."("..w..","..h..")") -- (1125,2001)
mSleep(1000)

x1,y1 = catchTouchPoint()
toast("x:"..x1.." y:"..y1)
mSleep(1000)


-- 在iphone8plus上获取的宽高不正确
-- x = screen_w - touch_y
-- y = touch_x
mx = h - y1
my = x1
toast("实际坐标:".."("..mx..","..my..")")
mSleep(1000)

while(true)
do
	tap(mx,my)
	mSleep(1000)
end