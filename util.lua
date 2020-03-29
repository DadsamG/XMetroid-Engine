local util = {}

-- Putting some globals. it is useless for everything. but for this code can be useful
-- If you can set it as local. put local.
TABLE = {}
STRING = ""
NUMBER = 0
TRUE = true
FALSE = false
BOOLEAN = true

function util.oscillating(period, amplitude, offset)
    period = period or 1
    amplitude = amplitude or 1
    offset = offset or 0
    local t = (offset+love.timer.getTime()) * 2 * math.pi / period
    return (math.sin(t) + 1) * .5 * amplitude
end

-- If val not is the next param. then will go to next param.
--[[
util.switch(value,testrue,frase,value)
]]
function util.switch(val,...)
	local varargs = {...}
	for i,v in pairs(varargs) do 
		if val == v then
			return v
		end
	end
end

-- It will execute the code if the time is ended
util.waitfortime = {}
function util.wait(seconds,functs)
	--if start == 0 then
	--	start = love.timer.getTime()
	--end
	--if finish == 0 then
	--	finish = love.timer.getTime() + 10
	--end
	--math.floor(love.timer.getTime() - math.floor(finish))
	--start = 0
	--finish = 0
end
util.timer = { _timer = TABLE}

--local UTIL_TIMER_HIGH = true
function util.timer.create(id,del,fun,rep)
	local createtimed = love.timer.getTime() 
	local timerfinish = createtimed + delay
	util.timer._timer[idtimer] = {
	func=fun,delay=del,numrepeat=rep,
	starttime=createdtimed,
	finishtime=timerfinish
	}
end

function util.timer.update()
	if util.timer.disabled == true then return end
	for i,v in pairs(util.timer._timer) do
		if v then end
	end
end

-- This system is more clean and "fast".
-- It will create a timer and you can check if timer reached to finish with
-- util.timer.mcheck()
-- For better countdown. use it on love.update
-- Return a [TimerObject]
function util.timer.mcreate(delay)
	local TimerObject = {}
	TimerObject["Delay"] = delay
	TimerObject["CreationTime"] = love.timer.getTime()
	TimerObject["FinishTime"] = love.timer.getTime() + delay
	return TimerObject
end

-- It will return 2 values
-- BOOLEAN | When the code is triggered
-- FLOAT   | How much time is needed to be triggered - If negative then is already
function util.timer.mcheck(TimerObject)
	return love.timer.getTime() == TimerObject["FinishTime"], TimerObject["CreationTime"]-love.timer.getTime()
end

function util.color(r,g,b,a)
	local Color = {}
	Color["red"] = r
	Color["green"] = g
	Color["blue"] = b 
	Color["alpha"] = a
	Color[1] = r
	Color[2] = g
	Color[3] = b 
	Color[4] = a
	return Color
end

function util.getPixelFromColor(dataimg,color)
	local colormatchRED = color.red or color[1]
	local colormatchGREEN = color.green or color[2]
	local colormatchBLUE = color.blue or color[3]
	local colormatchALPHA = color.alpha or color[4]
	local asalpha = colormatchALPHA ~= nil
	local posx = 0
	local posy = 0
	local pxfun = function(x,y,r,g,b,a) 
		if asalpha and r == colormatchRED and g == colormatchGREEN and
		   b == colormatchBLUE and a == colormatchALPHA then
		   	posx = x
		   	posy = y
		end
		return r,g,b,a
	end
	dataimg:mapPixel( pxfun)
	return posx,posy
end

-- It will check if the table as the VALUE
-- If the argument (not_) is true. then it will return any value. but never return the value of param VALUE
-- VALUE can be a table. but the VALUEisTABLE need be a true
function util.priorityCheck(tbl,VALUE,not_,VALUEisTABLE)
	local returnvalues = {}
	for i,v in pairs(tbl) do
		if VALUEisTABLE then
			for v1=1,#VALUE do 
				if v == VALUE[v1] then

				end
			end
		end
	end
	return returnvalues
end

function util.returnmyself(...)
	return ...
end

-- is for i,v in pairs() do end
function util.Filter(tbl,funct)
	for i,v in pairs(tbl) do 
		funct(i,v)
	end
end

function util.IFilter(tbl,funct)
	for k,v in ipairs(tbl) do
		funct(k,v)
	end
end

-- is for i=INITVAL,#tbl do end
function util.ForRepeat(INITVAL,ENDVAL,funct)
	INITVAL = INITVAL or 1
	ENDVAL = ENDVAL or 10
	for i=INITVAL,ENDVAL do
		funct(i)
	end
end

-- Will Print if the Global Var | APPLICATION_MODE is DEBUG |
function util.PrintDebug(...)
	if APPLICATION_MODE == DEBUG then
		print(...)
	end
	return
end

-- Will Print All Table
-- This variable will set how the PrintTable works.
-- key = VALUE
local PrintTable_Type = 0
function util.PrintTable(tbl,isdebug)
	local PRINTHOW = isdebug and util.DebugPrint or print
	if type(tbl) ~= "table" then error("Table expected got " .. type(tbl),2) return end
	for k,v in ipairs(tbl) do
		PRINTHOW(k," = ",v,'\n')
	end
end
return util