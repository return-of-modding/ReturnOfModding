local demo_mod = {} -- The main table

local hi, there = ...

log.info(nil, hi, there)

function demo_mod.hello()
    log.info("Hi from some library that you require")
end

return demo_mod