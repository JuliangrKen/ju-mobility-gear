
local mg = ju.mobility_gear
local cfg = mg.cfg

function mg.addDefaultTraceParams(paramsTable)
    
    paramsTable.mask = cfg.traceMask
    paramsTable.collisiongroup = cfg.traceCollisionGroup
    paramsTable.ignoreworld = cfg.traceIgnoreWorld
    paramsTable.filter = cfg.traceFilter

    return paramsTable
    
end
