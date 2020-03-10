local hook = {links = {}}

function hook.add(hookname,id,func)
    hook.links[hookname] = hook.links[hookname] or {} 
    hook.links[hookname][id] = func
    if hook.links[hookname][id] then
        return hook.links[hookname]
    end
end

function hook.remove(hookname,id)
    local savedfunc = hook.links[hookname][id]
    hook.links[hookname][id]
    
    return savedfunc    
end


function hook.run(hookname,returnablefunc,...)
  local varargs = {}
  local function addtovarargs(packed)
    varargs[#varargs+1] = packed
  end
  for i,v in ipairs(hook.links[hookname]) do
    varargs = table.pack(hook.links[hookname][i](...))
  end
  if not returnablefunc == nil then
  returnablefunc(table.unpack(varargs))
  else
    return varargs
  end
 end
