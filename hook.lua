hook = {links = {}} -- Starts a Hook


function hook.CreateBS(hookname)
	if hook.links[hookname] == nil then hook.links[hookname] = {} end
end
function hook.Add(hookname,id,funct) -- Add a Hook
	hook.CreateBS(hookname)
	hook.links[hookname][id] = funct 
end

function hook.Run(hookname,priority,...)
	hook.CreateBS(hookname)
	local returnvalues = {}
	for id,_ in ipairs(hook.links[hookname]) do 
		if IsValid(hook.links[hookname][id]) then
			returnvalues[#returnvalues+1] = hook.links[hookname][id](...)
		end
	end
	return returnvalues,hook.test_priority(returnvalues,priority)
end

function hook.Remove(hookname,id)
	hook.links[hookname][id] = nil
end

-- It is like table.match
-- If the table have the value: (priority)
-- Will call a function
function hook.test_priority(tabley,priority)
	for i,v in pairs(tabley) do 
		if v == priority then
			return true
		end
	end
end