
local mg = ju.mobility_gear
local _os = os
local time = _os.date

function mg.log(message)
    
    local tag = '[ JuMG - ' .. time('%H:%M:%S') .. ' ] >>   '

    if istable(message) then
        print(tag)
        print '\n\n\n<< START >>\n\n\n'
        PrintTable(message)
        print '\n\n\n<< END >>\n\n\n'
        
        return
    end

    print(tag .. message)

end
