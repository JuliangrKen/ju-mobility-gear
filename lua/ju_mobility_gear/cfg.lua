-- Пользователю аддона нерекомендуется трогать все файлы аддона, кроме этого.
-- Здесь можно конфигурировать всё необходимое.

-- NOTES:
-- 1. длина в всегда в юнитах, 100 юнитов примерно 180 см.



local cfg = ju.mobility_gear.cfg


-- ЛЕСКА

-- Стандартная максимальная длина лески
cfg.maxLength = 2048

-- Стандартная минимальная длина лески
cfg.minLength = 512

-- Дистанция уклона от центра
cfg.defaultSlopeDist = 1024

-- Стандартная длина лески в юнитах
cfg.defaultLength = 1024

-- Стандартная ширина лески
cfg.defaultWidth = 2.5

-- Стандартный материал лески
cfg.defaultMaterial = 'cable/cable2'

-- Стандартный цвет лески
cfg.defaultColor = Color(0, 0, 0, 100)

-- Кость, которая используется для всех моделей по умолчанию
cfg.defaultBone = 'ValveBiped.Bip01_Spine'

-- Выбор кости отдельно для каждой модели:
cfg.customBones = {
    ['model'] = 'bone_name',
}

-- Стандартный подъём или стандартное снижение относительно кости
cfg.defaultLift = 0

-- Выбор подъёма отдельно для каждой модели:
cfg.customBones = {
    ['model'] = 'bone_name',
}


-- ПОЛЁТ

-- Стандартная скорость полёта:
cfg.default_speed = 100


-- КЛИНКИ

-- Показатель разрушаемости клинков:
cfg.default_destructibility_of_blades = 10


-- АНИМАЦИИ

cfg.attack_anim = nil
cfg.fly_anim = nil

-- ОСТАЛЬНОЕ

-- Категория для оружий в Q-меню
cfg.q_menu_category = 'AOT - Ju Modity Gear'


-- Включает дебаг мод для отладки
cfg.debug = true
