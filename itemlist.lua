local d = deepcaves
d.itemlist = {}
local item = d.itemlist

--mortar and pestle
if d.item_exists("farming:mortar_pestle") then
    item.mortar_pestle = "farming:mortar_pestle"
else
    core.register_tool("deepcaves:mortar_pestle", {
        description = "Mortar and Pestle",
        inventory_image = "deepcaves_mortar_pestle.png"
    })

    core.register_craft{
        output = "deepcaves:mortar_pestle",
        recipe = {
            {"default:stone", "default:clay_lump", "default:stone"},
            {"", "default:stone", ""}
        }
    }
    item.mortar_pestle = "deepcaves:mortar_pestle"
end