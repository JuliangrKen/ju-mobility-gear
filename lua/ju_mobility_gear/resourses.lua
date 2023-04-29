local resources = ju.mobility_gear.resources

resources.weaponIcons = {
    ['classic'] = 'materials/ju_mobility_gear/ui/ju_modity_gear_classic.png',
}

if SERVER then

    for _, v1 in pairs(resources) do

        for _, v2 in pairs(v1) do
            resource.AddFile(v2)
        end
        
    end
    
end