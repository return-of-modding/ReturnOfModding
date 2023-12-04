local demo_mod = {} -- The main table

function demo_mod.hello()
    log.info("Hi from some library that you require")
end

return demo_mod