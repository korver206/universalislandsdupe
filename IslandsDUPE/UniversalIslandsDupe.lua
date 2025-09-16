-- Universal Roblox Islands Item Duplicator
-- Based on provided remote exploit, generalized for any item ID and amount
-- Fires client_request_35 with itemId and amount for server-side addition
-- Includes persistence via save remote
-- UI for easy input, toggle with 'D' key
-- Not bannable if used sparingly; relog to verify persistence

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local player = Players.LocalPlayer


local enabled = true
local gui = nil
local frame = nil
local currentMainTab = "remotes"  -- "remotes", "duping"
local currentDupeTab = "all"  -- "all", "combat", "minerals", "industrial", etc.
local amountInput = nil
local tabFrames = {}
local mainTabButtons = {}
local dupeTabButtons = {}
local itemCategories = {
    "all", "combat", "minerals", "industrial", "tools & benches",
    "animals", "blocks", "decor", "misc", "food", "crops", "lumber",
    "flowers", "totems"
}

-- Enhanced remote discovery with island selector detection
local allRemotes = {}
local inventoryNames = {"AddItem", "GiveItem", "InventoryAdd", "AddToInventory", "GiveTool", "EquipItem", "ReceiveItem", "ItemAdd", "UpdateInventory", "Award", "ProcessItem", "GrantItem", "AddToBackpack", "GiveAward", "Purchase", "Buy", "SpawnItem", "CreateItem"}
local islandNames = {"Island", "SelectIsland", "IslandSelector", "ChooseIsland", "SetIsland", "IslandSelect"}

-- Known item IDs for fallback if scanning fails (name -> ID) - Complete list from ACT.md
local knownItems = {
    -- COMBAT
    ["Aquamarine Sword"] = 2,
    ["Ancient Longbow"] = 3,
    ["Cactus Spike"] = 6,
    ["Cutlass"] = 8,
    ["Diamond Great Sword"] = 9,
    ["Diamond War Hammer"] = 10,
    ["Gilded Steel Hammer"] = 12,
    ["Staff of Godzilla"] = 13,
    ["Iron War Axe"] = 15,
    ["Rageblade"] = 16,
    ["Spellbook"] = 19,
    ["Lightning Scepter"] = 21,
    ["Tidal Spellbook"] = 22,
    ["Azarathian Longbow"] = 24,
    ["Kong's Axe"] = 549,
    ["Regen Potion"] = 475,
    ["Strength Potion"] = 476,
    ["Ruby Staff"] = 721,
    ["The Captain's Rapier"] = 828,
    ["Obsidian Hilt"] = 844,
    ["Obsidian Greatsword"] = 845,
    ["Frost Sword"] = 1094,
    ["Frost Hammer"] = 1095,
    ["Maple Shield"] = 1055,
    ["Antler Shield"] = 1056,
    ["Antler Hammer"] = 1057,
    ["The Dragonslayer"] = 961,
    ["Pumpkin Hammer"] = 1021,
    ["Spirit Spellbook"] = 1272,
    ["Ruby Sword"] = 1283,
    ["Void Potion"] = 1338,
    ["Toxin Potion"] = 1758,
    ["Noxious Stinger"] = 1738,
    ["Serpents Hook"] = 1331,
    ["Serpents Bane"] = 1332,
    ["Slime Queens Scepter"] = 1320,
    ["Trouts Fury"] = 1321,
    ["The Reapers Crossbow"] = 1517,
    ["The Reapers Scythe"] = 1518,
    ["Iron Shortbow"] = 1400,
    ["Golden Shortbow"] = 1401,
    ["Hardened Bow Limb"] = 1418,
    ["Long Crossbow Bolt"] = 1467,
    ["Wooden Mallet"] = 1471,
    ["Granite Hammer"] = 1472,
    ["Candy Cane Scepter Weapon"] = 1665,
    ["Jolly Dagger"] = 1681,
    ["Natures Divine Longbow"] = 1858,
    ["Poison Long Arrow"] = 1859,
    ["The Divine Dao"] = 1860,
    ["Cursed Grimoire"] = 1862,
    ["Cursed Hammer"] = 1863,
    ["Infernal Hammer"] = 1251,

    -- MINERALS
    ["Aquamarine Shard"] = 27,
    ["Buffalkor Crystal"] = 28,
    ["Electrite"] = 31,
    ["Crystallized Aquamarine"] = 37,
    ["Crystallized Gold"] = 38,
    ["Crystallized Iron"] = 39,
    ["Diamond"] = 40,
    ["Enchanted Diamond"] = 41,
    ["Ruby"] = 720,
    ["Pearl"] = 532,
    ["Crystallized Obsidian"] = 829,
    ["Spirit Crystal"] = 1930,
    ["Infernal Flame"] = 1252,
    ["Amethyst Crystal"] = 1337,

    -- INDUSTRIAL
    ["Formula 86"] = 11,
    ["Copper Bolt"] = 32,
    ["Copper Ingot"] = 33,
    ["Copper Plate"] = 35,
    ["Copper Rod"] = 36,
    ["Gearbox"] = 42,
    ["Gilded Steel Rod"] = 43,
    ["Gold Ingot"] = 44,
    ["Iron Ingot"] = 46,
    ["Red Bronze Ingot"] = 48,
    ["Steel Bolt"] = 49,
    ["Steel Ingot"] = 50,
    ["Steel Plate"] = 51,
    ["Steel Rod"] = 52,
    ["And Gate"] = 163,
    ["Coal Generator"] = 165,
    ["Combiner"] = 166,
    ["Electrical Workbench"] = 167,
    ["Firework Launcher"] = 168,
    ["Or Gate"] = 170,
    ["Conveyor Sensor"] = 171,
    ["Solar Panel"] = 172,
    ["Conveyor Belt"] = 298,
    ["Drill"] = 299,
    ["Industrial Chest"] = 301,
    ["Food Processor"] = 302,
    ["Industrial Oven"] = 303,
    ["Industrial Sawmill"] = 304,
    ["Industrial Smelter"] = 305,
    ["Industrial Stonecutter"] = 306,
    ["Industrial Washing Station"] = 307,
    ["Copper Press"] = 308,
    ["Input/Output Chest"] = 309,
    ["Left Conveyor Belt"] = 311,
    ["Medium Chest"] = 312,
    ["Randomizer"] = 320,
    ["Industrial Lumbermill"] = 321,
    ["Industrial Milker"] = 322,
    ["Wool Vacuum"] = 323,
    ["Red Bronze Refinery"] = 324,
    ["Right Conveyor Belt"] = 326,
    ["Rod Factory Mold"] = 327,
    ["Sawmill"] = 328,
    ["Small Chest"] = 329,
    ["Small Furnace"] = 330,
    ["Basic Sprinkler"] = 331,
    ["Steel Mill"] = 332,
    ["Steel Press"] = 333,
    ["Stonecutter"] = 334,
    ["Vending Machine"] = 336,
    ["Washing Station"] = 337,
    ["Water Catcher"] = 339,
    ["Bolt Factory Mold"] = 294,
    ["Campfire"] = 295,
    ["Industrial Polishing Station"] = 756,
    ["Polishing Station"] = 757,
    ["Oil Barrel"] = 877,
    ["Petroleum Barrel"] = 878,
    ["Oil Refinery"] = 879,
    ["Pumpjack"] = 880,
    ["Pipe"] = 881,
    ["Pipe Junction"] = 882,
    ["Tier 2 Right Conveyor Belt"] = 883,
    ["Tier 2 Left Conveyor Belt"] = 884,
    ["Tier 2 Conveyor Ramp Up"] = 885,
    ["Petroleum Tank"] = 887,
    ["Oil Tank"] = 888,
    ["Tier 2 Crate Packer"] = 889,
    ["Tree Fruit Shaker"] = 890,
    ["Sapling Automatic Planter"] = 891,
    ["Petroleum Petrifier"] = 892,
    ["Fuel Barrel Extractor"] = 893,
    ["Fuel Barrel Filler"] = 894,
    ["Merger"] = 895,
    ["Automated Trough"] = 897,
    ["Petrified Petroleum"] = 898,
    ["Tier 2 Vending Machine"] = 913,
    ["Filter Conveyor"] = 914,
    ["Pallet Packer"] = 915,
    ["Sap Boiler"] = 1049,
    ["Syrup Bottler"] = 1050,
    ["Blast Furnace"] = 1267,
    ["Serpents Scale"] = 1333,
    ["Serpents Fang"] = 1334,
    ["Tier 2 Conveyor Ramp Down"] = 1343,
    ["Industrial Truffle Barrel"] = 1732,
    ["Industrial Nest"] = 1733,
    ["Tier 2 Conveyor Belt"] = 1519,
    ["Plate Factory Mold"] = 1887,
    ["Steel ATM"] = 1921,
    ["Gold ATM"] = 1922,
    ["Diamond ATM"] = 1923,
    ["LED Light"] = 1925,
    ["Timer"] = 1926,
    ["Oil Fuel"] = 1249,
    ["Petroleum Fuel"] = 1250,
    ["Green Page"] = 1678,
    ["Blue Page"] = 1679,
    ["Red Page"] = 1680,

    -- TOOLS & BENCHES
    ["Christmas Shovel"] = 187,
    ["Diamond Axe"] = 191,
    ["Diamond Pickaxe"] = 192,
    ["Diamond Sickle"] = 193,
    ["Gilded Steel Axe"] = 198,
    ["Gilded Steel Pickaxe"] = 199,
    ["Gilded Steel Sickle"] = 200,
    ["Iron Fishing Rod"] = 205,
    ["Leaf Clippers"] = 207,
    ["Wire Tool"] = 220,
    ["Workbench Tier 3"] = 225,
    ["Cletus Lucky Sickle"] = 870,
    ["Cletus Lucky Watering Can"] = 871,
    ["Cletus Lucky Plow"] = 874,
    ["Workbench Tier 4"] = 896,
    ["Opal Pickaxe"] = 962,
    ["Opal Axe"] = 963,
    ["Opal Pickaxe Hilt"] = 964,
    ["Opal Axe Hilt"] = 965,
    ["Opal Sword Hilt"] = 966,
    ["Void Mattock"] = 1344,
    ["Void Mattock Hilt"] = 1345,
    ["Thomas Lucky Fishing Rod"] = 1319,
    ["Golden Net"] = 1376,
    ["Workbench (tree stump)"] = 1924,

    -- ANIMALS
    ["Animal Well-Being Kit"] = 343,
    ["Chicken Spawn Egg Tier 2"] = 349,
    ["Chicken Spawn Egg Tier 3"] = 350,
    ["Cow Spawn Egg Tier 2"] = 354,
    ["Cow Spawn Egg Tier 3"] = 355,
    ["Pig Spawn Egg Tier 2"] = 364,
    ["Pig Spawn Egg Tier 3"] = 365,
    ["Sheep Spawn Egg Tier 2"] = 369,
    ["Sheep Spawn Egg Tier 3"] = 370,
    ["Blue Firefly Jar"] = 541,
    ["Green Firefly Jar"] = 542,
    ["Purple Firefly Jar"] = 543,
    ["Red Firefly Jar"] = 544,
    ["Pink Rabbit"] = 787,
    ["Turkey Spawn Egg Tier 2"] = 1073,
    ["Turkey Spawn Egg Tier 3"] = 1074,
    ["Duck Spawn Egg Tier 2"] = 1155,
    ["Duck Spawn Egg Tier 3"] = 1156,
    ["Yak Spawn Egg Tier 2"] = 1237,
    ["Yak Spawn Egg Tier 3"] = 1238,
    ["Horse Spawn Egg Tier 2"] = 1265,
    ["Horse Spawn Egg Tier 3"] = 1266,
    ["Vulture Spawn Egg Tier 2"] = 1751,
    ["Vulture Spawn Egg Tier 3"] = 1752,
    ["Yellow Butterfly Jar"] = 1369,
    ["White Butterfly Jar"] = 1370,
    ["Red Butterfly Jar"] = 1371,
    ["Silver Butterfly Jar"] = 1372,
    ["Green Butterfly Jar"] = 1373,
    ["Blue Butterfly Jar"] = 1374,
    ["Spider Pet Spawn Egg"] = 1516,
    ["Penguin Pet Spawn Egg"] = 1667,
    ["Dog Pet Spawn Egg"] = 1766,
    ["Cat Pet Spawn Egg"] = 1864,
    ["Koi"] = 1861,

    -- BLOCKS
    ["Spawn Block"] = 173,
    ["Diamond Block"] = 401,
    ["Gold Block"] = 405,
    ["Ice"] = 416,
    ["Mushroom Block"] = 430,
    ["Sea Lantern"] = 455,
    ["Ruby Block"] = 722,
    ["Magma Block"] = 967,
    ["Green Slime Block"] = 860,
    ["Blue Slime Block"] = 861,
    ["Pink Slime Block"] = 862,
    ["Candy Cane Block"] = 1089,
    ["Compact Snow"] = 1090,
    ["Compact Ice"] = 1091,
    ["Ice Brick"] = 1092,
    ["Copper Block"] = 1244,
    ["Red Bronze Block"] = 1245,
    ["Opal Block"] = 1246,
    ["Pearl Block"] = 1273,
    ["Buffalkor Crystal Block"] = 1274,
    ["Void Block"] = 1284,
    ["Chrome Glass Block"] = 1287,
    ["Amethyst Block"] = 1336,
    ["Void Stone Block"] = 1341,
    ["Respawn Block"] = 1342,
    ["Light Blue Coral Block"] = 1083,
    ["Pink Coral Block"] = 1084,
    ["Blue Coral Block"] = 1085,
    ["Bone Block"] = 841,
    ["Obsidian"] = 840,
    ["Glowing Blue Mushroom Block"] = 1837,
    ["Glowing Cyan Mushroom Block"] = 1838,
    ["Glowing Green Mushroom Block"] = 1839,
    ["Glowing Pink Mushroom Block"] = 1840,
    ["Void Grass Block"] = 1889,
    ["Void Sand Block"] = 1890,

    -- DECOR
    ["Fish Banner"] = 84,
    ["Fish Festival Trophy 2021"] = 85,
    ["Godzilla Trophy"] = 94,
    ["Kong Trophy"] = 101,
    ["PVP Alpha Trophy"] = 138,
    ["Roblox Battles Trophy"] = 139,
    ["Snow Globe"] = 144,
    ["Tall Snowman"] = 147,
    ["The Witches Trophy"] = 148,
    ["Tidal Aquarium"] = 149,
    ["Wide Snowman"] = 155,
    ["Wreath"] = 157,
    ["Shipwreck Podium"] = 719,
    ["Lunar Banner"] = 737,
    ["Islands First Anniversary Cake"] = 540,
    ["Pirate Cannon"] = 832,
    ["Pirate Barrel"] = 833,
    ["Pirate Chair"] = 834,
    ["Pirate Chandelier"] = 835,
    ["Pirate Lamp"] = 836,
    ["Pirate Ship Wheel"] = 837,
    ["Pirate Ship"] = 838,
    ["Pirate Table"] = 839,
    ["Pirate Globe"] = 863,
    ["Scarecrow Trophy"] = 875,
    ["Cletus Scarecrow"] = 876,
    ["DV Trophy"] = 912,
    ["Butterfly Festival Trophy"] = 1375,
    ["Halloween Event Trophy 2022"] = 1455,
    ["Christmas Event 2022 Trophy"] = 1666,
    ["Lunar 2023 Rabbit Statue"] = 1723,
    ["Lunar Rabbit Plushie"] = 1724,
    ["Lunar Rabbit Banner"] = 1725,
    ["Islands Third Anniversary Cake"] = 1759,
    ["Islands Second Anniversary Cake"] = 1760,
    ["Mining Event Trophy 2023"] = 1770,
    ["Mushroom Event Trophy 2023"] = 1857,
    ["Turkey Trophy"] = 1927,
    ["Mansion Cabinet"] = 1865,
    ["Mansion Bench"] = 1866,
    ["Mansion Desk"] = 1867,
    ["Mansion Bust Pink"] = 1868,
    ["Mansion Bust Blue"] = 1869,
    ["Mansion Bust Green"] = 1870,
    ["Mansion Bed"] = 1871,
    ["Mansion Rocking Horse"] = 1872,
    ["Mansion Couch"] = 1873,
    ["Mansion Grandfather Clock"] = 1874,
    ["Wraith Boss Plushie"] = 1875,
    ["Spirit Flower Pot"] = 1892,
    ["Spirit Flower Vase"] = 1893,
    ["Spirit Jar Light"] = 1894,
    ["Spirit Lantern"] = 1895,
    ["Spirit Plant"] = 1896,
    ["Spirit Statue"] = 1897,
    ["Spirit Stool"] = 1898,
    ["Spirit Table"] = 1899,
    ["Hanging Spirit Light"] = 1900,
    ["Spirit Essence Holder"] = 1901,
    ["Butterfly Couch"] = 1902,
    ["Butterfly Lamp"] = 1903,
    ["Small Bush Pot"] = 1904,
    ["Medium Bush Pot"] = 1905,
    ["Tall Bush Pot"] = 1906,
    ["Frog Topiary Pot"] = 1907,
    ["Rabbit Topiary Pot"] = 1908,
    ["Frog Fountain"] = 1909,
    ["Benched Gazebo"] = 1910,
    ["Grey Gazebo"] = 1911,
    ["Purple Gazebo"] = 1912,
    ["Red Gazebo"] = 1913,
    ["Purple Plush Butterfly Couch"] = 1914,
    ["Pink Plush Butterfly Couch"] = 1915,
    ["Red Flower Chair"] = 1916,
    ["White Flower Chair"] = 1917,
    ["Cyan Flower Chair"] = 1918,
    ["Ladybug Ottoman"] = 1919,
    ["Bee Ottoman"] = 1920,
    ["Spirit Bench"] = 1929,
    ["Spirit Lava Lamp"] = 1931,
    ["Spirit Bed"] = 1932,
    ["Rabbit Topiary"] = 1379,
    ["Frog Topiary"] = 1380,
    ["Butterfly Event Bench"] = 1377,
    ["Butterfly Event Archway"] = 1378,
    ["Lying Closed Coffin"] = 1456,
    ["Lying Opened Coffin"] = 1457,
    ["Standing Closed Coffin"] = 1458,
    ["Standing Opened Coffin"] = 1459,
    ["Group of Ghosts"] = 1460,
    ["Happy Ghost"] = 1461,
    ["Evil Ghost"] = 1462,
    ["Surprised Ghost"] = 1463,
    ["Small Fire Chalice"] = 1465,
    ["Tall Fire Chalice"] = 1466,
    ["Pumpkin Candle"] = 1468,
    ["Pumpkin Angry"] = 1469,
    ["Pumpkin Happy"] = 1470,
    ["Gravestone - All 3 Versions 2022"] = 1479,
    ["Green Eyed Scarecrow"] = 1482,
    ["Yellow Eyed Scarecrow"] = 1483,
    ["Large Diamond Chest"] = 1509,
    ["Expanded Diamond Chest"] = 1510,
    ["Blue Gnome Bag"] = 1643,
    ["Yellow Gnome Bag"] = 1644,
    ["Red Gnome Bag"] = 1645,
    ["Blue Standing Gnome"] = 1646,
    ["Yellow Standing Gnome"] = 1647,
    ["Red Standing Gnome"] = 1648,
    ["Blue Cup Gnome"] = 1649,
    ["Yellow Cup Gnome"] = 1650,
    ["Red Cup Gnome"] = 1651,
    ["Santa Stocking"] = 1652,
    ["Elf Stocking"] = 1653,
    ["Snowman Stocking"] = 1654,
    ["Snowflake Stocking"] = 1655,
    ["Cookie Stocking"] = 1656,
    ["Candy Cane Fence"] = 1657,
    ["Candy Cane Light Fence"] = 1658,
    ["Santa Plushie"] = 1659,
    ["Gnome Plushie"] = 1660,
    ["Elf Plushie"] = 1661,
    ["Reindeer Plushie"] = 1663,
    ["White Reindeer Plushie"] = 1664,
    ["Christmas Fence Light"] = 1668,
    ["Red Christmas Street Light"] = 1669,
    ["Green Christmas Street Light"] = 1670,
    ["Black Christmas Street Light"] = 1671,
    ["Rainbow Candy Cluster"] = 1672,
    ["Red Candy Cluster"] = 1673,
    ["Green Candy Cluster"] = 1674,
    ["Red and White Christmas Lantern"] = 1675,
    ["Green and White Christmas Lantern"] = 1676,
    ["Red and Green Christmas Lantern"] = 1677,
    ["Dumpling Couch"] = 1726,
    ["Dumpling Chair"] = 1728,
    ["Red Envelope 2023"] = 1729,
    ["Gold Envelope 2023"] = 1730,
    ["Red Dynamite Box"] = 1771,
    ["Wooden Dynamite Box"] = 1772,
    ["Dynamite Wall Decor"] = 1773,
    ["Black Mining Lantern"] = 1774,
    ["Brown Mining Lantern"] = 1775,
    ["Gold Mining Lantern"] = 1776,
    ["Mining Couch Green"] = 1777,
    ["Mining Couch Purple"] = 1778,
    ["Mining Entrance"] = 1779,
    ["Mining Gem Bag"] = 1780,
    ["Mining Tool Bag"] = 1781,
    ["Jade Plushie"] = 1782,
    ["Sandbag"] = 1783,
    ["Sandbag Pile"] = 1784,
    ["Sandbag Stack"] = 1785,
    ["Slime Mural 5"] = 1799,
    ["Gold Small Brazier"] = 1800,
    ["Gold Tall Brazier"] = 1801,
    ["Primordial Plushie Beanbag"] = 1802,
    ["Primordial Statue"] = 1803,
    ["Fertile Purple Lavender"] = 1807,
    ["Fertile White Lavender"] = 1808,
    ["Fertile Red Lavender"] = 1809,
    ["Red Lavender"] = 1810,
    ["Fertile Pink Lavender"] = 1811,
    ["Pink Lavender"] = 1812,
    ["Fertile Black Lavender"] = 1813,
    ["Black Lavender"] = 1814,
    ["Fertile Blue Lavender"] = 1815,
    ["Blue Lavender"] = 1816,
    ["Fertile Yellow Lavender"] = 1817,
    ["Yellow Lavender"] = 1818,
    ["Fertile Cyan Lavender"] = 1819,
    ["Cyan Lavender"] = 1820,
    ["Fertile Light Green Lavender"] = 1821,
    ["Light Green Lavender"] = 1822,
    ["Fertile Dark Green Lavender"] = 1823,
    ["Dark Green Lavender"] = 1824,
    ["Fertile Orange Lavender"] = 1825,
    ["Orange Lavender"] = 1826,
    ["Fertile Chrome Lavender"] = 1827,
    ["Chrome Lavender"] = 1828,
    ["Cyan Glowing Mushroom"] = 1829,
    ["Green Glowing Mushroom"] = 1830,
    ["Pink Glowing Mushroom"] = 1831,
    ["Blue Glowing Mushroom"] = 1832,
    ["Yellow Mushroom Table"] = 1833,
    ["Cyan Mushroom Table"] = 1834,
    ["Red Mushroom Table"] = 1835,
    ["Pink Mushroom Table"] = 1836,
    ["Cyan Trunk Chair"] = 1841,
    ["Red Trunk Chair"] = 1842,
    ["Yellow Trunk Chair"] = 1843,
    ["Pink Trunk Chair"] = 1844,
    ["Cyan Outhouse"] = 1848,
    ["Pink Outhouse"] = 1849,
    ["Red Outhouse"] = 1850,
    ["Yellow Outhouse"] = 1851,
    ["Dark Brown Nature Fridge"] = 1852,
    ["Light Brown Nature Fridge"] = 1853,
    ["Purple Nature Fridge"] = 1854,
    ["Tan Nature Fridge"] = 1855,
    ["Cletus Plushie"] = 1765,
    ["Draven Statue"] = 1769,
    ["Pumpkin Cat"] = 1011,
    ["Cobweb"] = 1012,
    ["Ghost Lantern"] = 1013,
    ["Halloween Lantern"] = 1014,
    ["Gravestone 2021"] = 1015,
    ["The Halloween Trophy"] = 1018,
    ["Pumpkin Bed"] = 1019,
    ["Candy Basket 2021"] = 1022,
    ["Spooky Pumpkin"] = 1028,
    ["Jack 0 Lantern"] = 789,
    ["Candy Basket 2022"] = 1454,
    ["Snowman (Furniture)"] = 1115,
    ["Train Bed"] = 1116,
    ["Snowman Couch"] = 1117,
    ["Snowman Bean Bag"] = 1118,
    ["Candy Cane Lamp"] = 1119,
    ["Bell (Christmas)"] = 1122,
    ["Christmas Tree"] = 1096,
    ["Blue Ornament"] = 1097,
    ["Orange Ornament"] = 1098,
    ["Green Ornament"] = 1099,
    ["Red Ornament"] = 1100,
    ["Cletus Ornament"] = 1101,
    ["Slime Ornament"] = 1102,
    ["Cow Ornament"] = 1103,
    ["Pig Ornament"] = 1104,
    ["Red Nutcracker"] = 1105,
    ["Blue Nutcracker"] = 1106,
    ["Green Nutcracker"] = 1107,
    ["Pineapple Totem"] = 1110,

    -- MISC
    ["Desert Portal"] = 158,
    ["Wizard Portal"] = 159,
    ["Slime Portal"] = 160,
    ["Buffalkor Portal"] = 161,
    ["Diamond Mines Portal"] = 162,
    ["Christmas Present 2020"] = 488,
    ["Legacy Food Processor"] = 489,
    ["Portal Crystal"] = 492,
    ["Buffalkor Portal Shard"] = 523,
    ["Desert Portal Shard"] = 524,
    ["Diamond Mines Portal Shard"] = 525,
    ["Frosty Slime Ball"] = 526,
    ["Gold Skorp Claw"] = 527,
    ["Gold Skorp Scale"] = 528,
    ["Green Sticky Gear"] = 529,
    ["Iron Skorp Scale"] = 531,
    ["Pink Sticky Gear"] = 533,
    ["Slime Portal Shard"] = 538,
    ["Wizard Portal Shard"] = 539,
    ["Ancient Slime String"] = 520,
    ["Blue Sticky Gear"] = 521,
    ["Propeller"] = 535,
    ["Ruby Skorp Scale"] = 536,
    ["Ruby Skorp Stinger"] = 537,
    ["Treasure Chest"] = 843,
    ["Desert Chest"] = 864,
    ["Desert Furnace"] = 865,
    ["Chili Pepper Seeds"] = 872,
    ["Cauldron 2021"] = 1010,
    ["Red Envelope 2022"] = 1123,
    ["Tiger Coin Bag"] = 1124,
    ["Lucky Coin Bag"] = 1125,
    ["Confetti Popper"] = 1761,
    ["Sparkler"] = 1762,
    ["Party Horn"] = 1763,
    ["Glow Stick"] = 1764,
    ["Glitterball"] = 1768,
    ["Dungeon Chest"] = 1804,
    ["Serpent Egg"] = 1349,
    ["Christmas Present 2021"] = 1093,
    ["Christmas Present 2022"] = 1642,
    ["Cauldron 2022"] = 1451,
    ["Opened Cauldron 2022"] = 1452,
    ["Cauldron 2023"] = 1877,
    ["Opened Cauldron 2023"] = 1878,
    ["Red Butterfly Lantern"] = 1397,
    ["Green Butterfly Lantern"] = 1398,
    ["Opened Treasure Chest"] = 842,
    ["Opened Cauldron 2021"] = 1260,
    ["Opened Dungeon Chest"] = 1805,
    ["Ruby Skorp Claw"] = 1261,

    -- FOOD
    ["Carrot Cake"] = 266,
    ["Chocolate Bar"] = 269,
    ["Deviled Eggs"] = 270,
    ["Jam Sandwich"] = 275,
    ["Lollipop"] = 279,
    ["Orange Candy"] = 283,
    ["Potato Salad"] = 286,
    ["Starfruit Cake"] = 287,
    ["Tomato Soup"] = 289,
    ["Roasted Honey Carrot"] = 952,
    ["Truffle Avocado Toast"] = 1030,
    ["Truffle Pizza"] = 1031,
    ["Dragon Roll"] = 1032,
    ["Philadelphia Roll"] = 1033,
    ["Tai Nigiri"] = 1035,
    ["Tuna Roll"] = 1036,
    ["Potato and Duck Egg Scramble"] = 1161,
    ["Glass of Milk"] = 1316,
    ["Blueberry Cookie"] = 1317,
    ["Fhanhorns Flower"] = 1069,
    ["Fhanhorns Pancakes"] = 1070,
    ["Bhutan Butter Tea"] = 1240,
    ["Gondo Datshi"] = 1242,
    ["Lunar Mooncake"] = 1722,
    ["Maple Syrup (Glitched)"] = 1253,

    -- CROPS
    ["Red Berry Seeds"] = 230,
    ["Pumpkin Seeds"] = 249,
    ["Radish Seeds"] = 251,
    ["Starfruit Seeds"] = 253,
    ["Watermelon Seeds"] = 257,
    ["Chili Pepper Seeds"] = 872,
    ["Blackberry Seeds"] = 994,
    ["Blueberry Seeds"] = 995,
    ["Rice Seeds"] = 1028,
    ["Pineapple Seeds"] = 1110,
    ["Seaweed Seeds"] = 1888,
    ["Spirit Seeds"] = 1891,
    ["Void Parasite Seeds"] = 1347,
    ["Apple Tree Sapling"] = 505,
    ["Lemon Tree Sapling"] = 511,
    ["Orange Tree Sapling"] = 516,
    ["Palm Tree Sapling"] = 517,
    ["Cherry Blossom Sapling"] = 1713,
    ["Kiwifruit Tree Sapling"] = 1928,
    ["Candy Cane Seed"] = 1087,

    -- LUMBER
    ["Palm Tree Sapling"] = 517,
    ["Spirit Sapling"] = 802,
    ["Cherry Blossom Sapling"] = 1713,
    ["Oak Wood"] = 1880,
    ["Birch Wood"] = 1881,
    ["Cherry Blossom Wood"] = 1882,
    ["Hickory Wood"] = 1883,
    ["Maple Wood"] = 1884,
    ["Pine Wood"] = 1885,
    ["Spirit Wood"] = 1886,

    -- FLOWERS
    ["Fertile White Rose"] = 582,
    ["Fertile White Daffodil"] = 583,
    ["White Daffodil"] = 584,
    ["White Daisy"] = 585,
    ["Fertile White Daisy"] = 586,
    ["Fertile White Hibiscus"] = 587,
    ["White Hibiscus"] = 588,
    ["Fertile Red Daisy"] = 590,
    ["Fertile Red Hyacinth"] = 591,
    ["Red Hyacinth"] = 592,
    ["Red Lily"] = 593,
    ["Fertile Red Lily"] = 594,
    ["Fertile Red Rose"] = 596,
    ["Fertile Red Daffodil"] = 597,
    ["Orange Hibiscus"] = 599,
    ["Fertile Orange Hibiscus"] = 600,
    ["Fertile Orange Daffodil"] = 601,
    ["Orange Daffodil"] = 602,
    ["Orange Hyacinth"] = 603,
    ["Fertile Orange Hyacinth"] = 604,
    ["Fertile Yellow Daffodil"] = 606,
    ["Fertile Yellow Daisy"] = 608,
    ["Fertile Yellow Lily"] = 609,
    ["Yellow Lily"] = 610,
    ["Fertile Yellow Hyacinth"] = 612,
    ["Yellow Daffodil"] = 613,
    ["Fertile Dark Green Daffodil"] = 615,
    ["Dark Green Daisy"] = 617,
    ["Fertile Dark Green Daisy"] = 618,
    ["Fertile Dark Green Lily"] = 619,
    ["Dark Green Lily"] = 620,
    ["Light Green Daffodil"] = 621,
    ["Fertile Light Green Daffodil"] = 622,
    ["Fertile Light Green Hibiscus"] = 624,
    ["Light Green Daisy"] = 625,
    ["Fertile Light Green Daisy"] = 626,
    ["Light Green Hyacinth"] = 627,
    ["Fertile Light Green Hyacinth"] = 628,
    ["Cyan Daisy"] = 629,
    ["Fertile Cyan Daisy"] = 630,
    ["Cyan Hyacinth"] = 631,
    ["Fertile Cyan Hyacinth"] = 632,
    ["Cyan Lily"] = 633,
    ["Fertile Cyan Lily"] = 634,
    ["Blue Hibiscus"] = 635,
    ["Fertile Blue Hibiscus"] = 636,
    ["Fertile Blue Rose"] = 637,
    ["Blue Lily"] = 639,
    ["Fertile Blue Lily"] = 640,
    ["Blue Hyacinth"] = 641,
    ["Fertile Blue Hyacinth"] = 642,
    ["Purple Hibiscus"] = 643,
    ["Fertile Purple Hibiscus"] = 644,
    ["Purple Rose"] = 645,
    ["Fertile Purple Rose"] = 646,
    ["Black Hibiscus"] = 647,
    ["Fertile Black Hibiscus"] = 648,
    ["Black Lily"] = 649,
    ["Fertile Black Lily"] = 650,
    ["Pink Daffodil"] = 651,
    ["Fertile Pink Daffodil"] = 652,
    ["Pink Hibiscus"] = 653,
    ["Fertile Pink Hibiscus"] = 654,
    ["Pink Rose"] = 655,
    ["Fertile Pink Rose"] = 656,
    ["Fertile Red Tulip"] = 1177,
    ["Fertile Yellow Tulip"] = 1179,
    ["Fertile Orange Tulip"] = 1181,
    ["Orange Tulip"] = 1182,
    ["Fertile Light Green Tulip"] = 1183,
    ["Light Green Tulip"] = 1184,
    ["Fertile Dark Green Tulip"] = 1185,
    ["Dark Green Tulip"] = 1186,
    ["Fertile Pink Tulip"] = 1187,
    ["Pink Tulip"] = 1188,
    ["Fertile White Tulip"] = 1189,
    ["White Tulip"] = 1190,
    ["Fertile Purple Lavender"] = 1807,
    ["Fertile White Lavender"] = 1808,
    ["Fertile Red Lavender"] = 1809,
    ["Red Lavender"] = 1810,
    ["Fertile Pink Lavender"] = 1811,
    ["Pink Lavender"] = 1812,
    ["Fertile Black Lavender"] = 1813,
    ["Black Lavender"] = 1814,
    ["Fertile Blue Lavender"] = 1815,
    ["Blue Lavender"] = 1816,
    ["Fertile Yellow Lavender"] = 1817,
    ["Yellow Lavender"] = 1818,
    ["Fertile Cyan Lavender"] = 1819,
    ["Cyan Lavender"] = 1820,
    ["Fertile Light Green Lavender"] = 1821,
    ["Light Green Lavender"] = 1822,
    ["Fertile Dark Green Lavender"] = 1823,
    ["Dark Green Lavender"] = 1824,
    ["Fertile Orange Lavender"] = 1825,
    ["Orange Lavender"] = 1826,
    ["Fertile Chrome Lavender"] = 1827,
    ["Chrome Lavender"] = 1828,
    ["Fertile Black Chrysanthemum"] = 1288,
    ["Fertile Red Chrysanthemum"] = 1289,
    ["Fertile Pink Chrysanthemum"] = 1290,
    ["Fertile Purple Chrysanthemum"] = 1291,
    ["Fertile White Chrysanthemum"] = 1292,
    ["Fertile Chrome Chrysanthemum"] = 1293,
    ["Fertile Blue Chrysanthemum"] = 1294,
    ["Fertile Cyan Chrysanthemum"] = 1295,
    ["Purple Chrysanthemum"] = 1298,
    ["White Chrysanthemum"] = 1299,
    ["Chrome Chrysanthemum"] = 1300,
    ["Blue Chrysanthemum"] = 1301,
    ["Cyan Chrysanthemum"] = 1302,
    ["Light Green Chrysanthemum"] = 1303,
    ["Pink Chrysanthemum"] = 1388,
    ["Yellow Hyacinth"] = 1389,
    ["White Rose"] = 1390,
    ["Blue Rose"] = 1393,
    ["Red Chrysanthemum"] = 1393,
    ["Black Chrysanthemum"] = 1394,
    ["Light Green Hibiscus"] = 1395,
    ["Yellow Daisy"] = 1382,
    ["Yellow Tulip"] = 1383,
    ["Red Daffodil"] = 1384,
    ["Red Daisy"] = 1385,
    ["Red Rose"] = 1386,
    ["Red Tulip"] = 1387,

    -- TOTEMS
    ["Pumpkin Totem"] = 794,
    ["Red Berry Bush Totem"] = 998,
    ["Blackberry Bush Totem"] = 999,
    ["Blueberry Bush Totem"] = 1000,
    ["Pineapple Totem"] = 1110,
    ["Dragonfruit Totem"] = 1330,
    ["Obsidian Totem"] = 989
}

-- Item category lookup by ID (from ACT.md categorized list)
local itemCategories = {
    -- COMBAT
    [2] = "combat", [3] = "combat", [6] = "combat", [8] = "combat", [9] = "combat",
    [10] = "combat", [12] = "combat", [13] = "combat", [15] = "combat", [16] = "combat",
    [19] = "combat", [21] = "combat", [22] = "combat", [24] = "combat", [719] = "decor",
    [1860] = "combat",
    -- MINERALS
    [27] = "minerals", [28] = "minerals", [31] = "minerals", [37] = "minerals",
    [38] = "minerals", [39] = "minerals", [40] = "minerals", [41] = "minerals",
    -- INDUSTRIAL
    [32] = "industrial", [33] = "industrial", [35] = "industrial", [36] = "industrial",
    [42] = "industrial", [43] = "industrial", [44] = "industrial", [46] = "industrial",
    [48] = "industrial", [49] = "industrial", [50] = "industrial", [51] = "industrial",
    [52] = "industrial",
    -- Add more categories as needed from the full list in ACT.md
}

-- Find island selector if it exists
local islandSelector = nil
local function findIslandSelector()
    local selectorNames = {"IslandSelector", "SelectIsland", "IslandChooser", "IslandSelect"}
    for _, name in ipairs(selectorNames) do
        local selector = ReplicatedStorage:FindFirstChild(name, true)
        if selector and (selector:IsA("RemoteEvent") or selector:IsA("RemoteFunction")) then
            islandSelector = selector
            print("Found island selector: " .. selector.Name)
            return selector
        end
    end
    return nil
end

local netManaged = ReplicatedStorage:FindFirstChild("rbxts_include", true)
if netManaged then
    netManaged = netManaged:FindFirstChild("node_modules", true)
    if netManaged then
        netManaged = netManaged:FindFirstChild("@rbxts", true)
        if netManaged then
            netManaged = netManaged:FindFirstChild("net", true)
            if netManaged then
                netManaged = netManaged:FindFirstChild("out", true)
                if netManaged then
                    netManaged = netManaged:FindFirstChild("_NetManaged", true)
                end
            end
        end
    end
end

if netManaged then
    for _, child in ipairs(netManaged:GetDescendants()) do
        if child:IsA("RemoteEvent") or child:IsA("RemoteFunction") then
            local isInventory = false
            local isIsland = false
            for _, name in ipairs(inventoryNames) do
                if string.find(child.Name:lower(), name:lower()) then
                    isInventory = true
                    break
                end
            end
            for _, name in ipairs(islandNames) do
                if string.find(child.Name:lower(), name:lower()) then
                    isIsland = true
                    break
                end
            end
            table.insert(allRemotes, {
                name = child.Name,
                obj = child,
                isEvent = child:IsA("RemoteEvent"),
                isInventory = isInventory,
                isIsland = isIsland
            })
        end
    end
    redeemRemote = netManaged:FindFirstChild("RedeemAnniversary")
    requestRemote = netManaged:FindFirstChild("client_request_35")
else
    print("NetManaged path not found. Searching for remotes directly.")
    redeemRemote = ReplicatedStorage:FindFirstChild("RedeemAnniversary", true)
    requestRemote = ReplicatedStorage:FindFirstChild("client_request_35", true)
end

-- Find island selector
findIslandSelector()

table.sort(allRemotes, function(a, b) return a.name < b.name end)
print("Found " .. #allRemotes .. " remotes in _NetManaged")
if not redeemRemote then
    print("RedeemAnniversary remote not found.")
end
if not requestRemote then
    print("client_request_35 remote not found.")
end
if not redeemRemote or not requestRemote then
    print("Required remotes not found. Dupe may not work, but UI will load.")
end


-- Fire the fixed redeem remote (exact as provided)
local function fireRedeem()
    pcall(function()
        redeemRemote:FireServer()
    end)
    return true
end

-- Fire request remote (with args for any item, no args for fixed dupe)
local function fireRequest(itemId, amount)
    pcall(function()
        if itemId and amount then
            requestRemote:FireServer(itemId, amount)
        else
            requestRemote:FireServer()
        end
    end)
    return true
end

-- Find and fire save remote for persistence
local function saveData()
    local saveNames = {"SaveData", "saveData", "UpdateData", "Persist", "Commit", "RemoteSave", "SaveInventory", "UpdatePlayerData"}
    for _, name in ipairs(saveNames) do
        local saveRemote = ReplicatedStorage:FindFirstChild(name, true)
        if saveRemote and saveRemote:IsA("RemoteEvent") then
            pcall(function()
                saveRemote:FireServer()
            end)
            return true
        end
    end
    return false
end

-- Fire both remotes as in original (for dupe effect)
local function fireBothRemotes()
    fireRedeem()
    wait(0.1)
    fireRequest()
end

-- Scan for available islands
local allIslands = {}
local selectedIsland = nil
local function scanIslands()
    allIslands = {}
    local islandNames = {"Island", "MyIsland", "PlayerIsland", "HomeIsland"}
    for _, area in ipairs({workspace}) do
        for _, child in ipairs(area:GetDescendants()) do
            if child:IsA("Model") or child:IsA("Part") then
                for _, name in ipairs(islandNames) do
                    if string.find(child.Name:lower(), name:lower()) then
                        local found = false
                        for _, existing in ipairs(allIslands) do
                            if existing.name == child.Name then
                                found = true
                                break
                            end
                        end
                        if not found then
                            table.insert(allIslands, {
                                name = child.Name,
                                obj = child
                            })
                        end
                    end
                end
            end
        end
    end
    table.sort(allIslands, function(a, b) return a.name < b.name end)
    print("Scanned " .. #allIslands .. " islands")
    return #allIslands > 0
end

-- Scan and load all obtainable items with enhanced detection
local allItems = {}
local function scanItems()
    allItems = {}
    local areas = {ReplicatedStorage, workspace}
    for _, area in ipairs(areas) do
        for _, child in ipairs(area:GetDescendants()) do
            if child:IsA("Tool") or (child:IsA("Model") and child:FindFirstChild("Handle")) then
                local itemName = child.Name
                local found = false
                for _, existing in ipairs(allItems) do
                    if existing.name == itemName then
                        found = true
                        break
                    end
                end
                if not found then
                    local icon = ""
                    if child:IsA("Tool") and child:FindFirstChild("TextureId") then
                        icon = child.TextureId
                    elseif child:FindFirstChild("Handle") and child.Handle:FindFirstChildOfClass("Decal") then
                        icon = child.Handle.Decal.Texture
                    end
                    if icon == "" then icon = "rbxassetid://0" end

                    -- Try to find item ID from various sources
                    local itemId = nil
                    if child:FindFirstChild("ItemId") then
                        itemId = child.ItemId.Value
                    elseif child:FindFirstChild("ID") then
                        itemId = child.ID.Value
                    elseif child:IsA("Tool") and child:FindFirstChild("ToolTip") then
                        -- Some games store ID in tooltip or other attributes
                        local tooltip = child.ToolTip
                        if tooltip and string.match(tooltip, "%d+") then
                            itemId = tonumber(string.match(tooltip, "%d+"))
                        end
                    end

                    -- If no ID found, try to infer from name or use index
                    if not itemId then
                        -- Check known items table
                        if knownItems[itemName] then
                            itemId = knownItems[itemName]
                            print("Used known ID for " .. itemName .. ": " .. itemId)
                        else
                            -- Look for numeric patterns in name
                            if string.match(itemName, "(%d+)") then
                                itemId = tonumber(string.match(itemName, "(%d+)"))
                            else
                                -- Use a hash or sequential ID as fallback
                                itemId = #allItems + 1
                            end
                        end
                    end

                    table.insert(allItems, {
                        name = itemName,
                        obj = child,
                        icon = icon,
                        id = itemId
                    })
                end
            end
        end
    end
    table.sort(allItems, function(a, b) return a.name < b.name end)
    print("Scanned " .. #allItems .. " items with IDs")
    return #allItems > 0
end

-- Function to find and use proper inventory remotes for legitimate item granting
local function findInventoryRemote()
    -- Look for remotes that can grant items legitimately
    local grantNames = {"GiveItem", "AddItem", "GrantItem", "AwardItem", "ReceiveItem", "AddToInventory", "InventoryAdd", "PurchaseItem", "BuyItem"}
    for _, remoteData in ipairs(allRemotes) do
        if remoteData.isInventory then
            for _, name in ipairs(grantNames) do
                if string.find(remoteData.name:lower(), name:lower()) then
                    return remoteData
                end
            end
        end
    end
    return nil
end

-- Function to try different parameter combinations for item granting
local function tryGrantItem(remote, itemId, amount)
    local success = false
    local result = nil

    -- Try different parameter combinations
    local paramCombos = {
        {itemId, amount},           -- Standard: ID, Amount
        {itemId, amount, player},   -- With player reference
        {amount, itemId},           -- Reversed: Amount, ID
        {itemId},                   -- Just ID
        {amount},                   -- Just amount
        {itemId, amount, "grant"},  -- With action string
        {"grant", itemId, amount}, -- Action first
    }

    for i, params in ipairs(paramCombos) do
        pcall(function()
            if remote:IsA("RemoteEvent") then
                remote:FireServer(unpack(params))
                success = true
                print("Fired " .. remote.Name .. " with params: " .. table.concat(params, ", "))
            else
                result = remote:InvokeServer(unpack(params))
                success = true
                print("Invoked " .. remote.Name .. " with params: " .. table.concat(params, ", ") .. " | Result: " .. tostring(result))
            end
        end)
        if success then break end
        wait(0.1)
    end

    return success, result
end

-- Function to check if item is in backpack
local function checkItemInBackpack(itemData, expectedAmount)
    local backpack = player:FindFirstChild("Backpack")
    if backpack then
        for _, item in ipairs(backpack:GetChildren()) do
            if item.Name == itemData.name or (item:FindFirstChild("ItemId") and item.ItemId.Value == itemData.id) then
                local count = item:FindFirstChild("Amount") and item.Amount.Value or 1
                if count >= expectedAmount then
                    return true
                end
            end
        end
    end
    return false
end

-- Function to legitimately grant items using server-side remotes
local function grantItem(itemData, amount)
    local success = false
    local attempts = 0
    local maxAttempts = 5

    -- First, try to select island if selector exists and selectedIsland
    if islandSelector and selectedIsland then
        pcall(function()
            if islandSelector:IsA("RemoteEvent") then
                islandSelector:FireServer(selectedIsland.obj)
            else
                islandSelector:InvokeServer(selectedIsland.obj)
            end
            print("Selected island: " .. selectedIsland.name .. " for dupe")
        end)
        wait(0.2)
    end

    while not success and attempts < maxAttempts do
        attempts = attempts + 1
        print("Grant attempt " .. attempts .. " for " .. itemData.name)

        -- Try all remotes (not just inventory) with different parameter combinations
        for _, remoteData in ipairs(allRemotes) do
            print("Trying remote: " .. remoteData.name)
            local remoteSuccess, result = tryGrantItem(remoteData.obj, itemData.id, amount)
            if remoteSuccess then
                wait(1)  -- Increased delay
                if checkItemInBackpack(itemData, amount) then
                    print("Successfully granted " .. itemData.name .. " x" .. amount .. " via " .. remoteData.name .. " - verified in backpack")
                    success = true
                    break
                else
                    print("Remote fired but item not in backpack, trying next...")
                end
            end
            wait(0.5)  -- Delay between remote attempts
        end

        -- Fallback: Try client_request_35 with different parameters
        if not success and requestRemote then
            print("Trying client_request_35 with item parameters")
            local remoteSuccess, result = tryGrantItem(requestRemote, itemData.id, amount)
            if remoteSuccess then
                wait(0.5)
                if checkItemInBackpack(itemData, amount) then
                    print("Granted " .. itemData.name .. " x" .. amount .. " via client_request_35 - verified in backpack")
                    success = true
                end
            end
        end

        -- Last resort: Use the original fixed dupe method
        if not success then
            print("Using fallback dupe method for " .. itemData.name)
            fireBothRemotes()
            wait(0.5)
            if checkItemInBackpack(itemData, 3) then  -- fixed dupe gives 3
                success = true
            end
        end

        if not success then
            wait(1)  -- Wait before retry
        end
    end

    -- Always try to save data for persistence multiple times
    for i = 1, 3 do
        wait(0.5)
        local saved = saveData()
        if saved then
            print("Data saved for persistence (attempt " .. i .. ")")
        end
    end

    return success
end

-- Enhanced dupe function that uses permanent item duplication method
local function dupeItem(itemData, amount)
    print("Attempting permanent duplication of " .. itemData.name .. " x" .. amount)

    -- Method 1: Try server-side item substitution (like Divine Dao -> Shipwreck Podium)
    local permanentSuccess = false
    if requestRemote then
        -- Try multiple parameter combinations to trigger item substitution
        local subParams = {
            {1860, amount},  -- Divine Dao ID as trigger
            {itemData.id, 1860, amount},  -- Target + Divine Dao + amount
            {1860, itemData.id, amount},  -- Divine Dao + Target + amount
            {itemData.id, amount, 1860},  -- Target + amount + Divine Dao trigger
        }

        for _, params in ipairs(subParams) do
            pcall(function()
                requestRemote:FireServer(unpack(params))
                print("Tried item substitution with params: " .. table.concat(params, ", "))
            end)
            wait(0.2)

            -- Check if item appeared in backpack (could be substituted item)
            if checkItemInBackpack(itemData, amount) then
                permanentSuccess = true
                print("Item substitution successful - permanent item granted")
                break
            end
        end
    end

    -- Method 2: Fallback to legitimate granting if substitution failed
    if not permanentSuccess then
        print("Item substitution failed, trying legitimate granting...")
        permanentSuccess = grantItem(itemData, amount)
    end

    -- Method 3: Last resort - original fixed dupe method
    if not permanentSuccess then
        print("Legitimate granting failed, using fixed dupe method...")
        fireBothRemotes()
        wait(0.5)
        if checkItemInBackpack(itemData, 3) then
            permanentSuccess = true
            print("Fixed dupe method successful")
        end
    end

    if permanentSuccess then
        print("Successfully duplicated " .. itemData.name .. " x" .. amount .. " (permanent)")
        return amount
    else
        print("Failed to duplicate " .. itemData.name)
        return 0
    end
end


-- Fixed dupe (original method, no args)
local function fixedDupe()
    if consoleOutput then
        consoleOutput.Text = consoleOutput.Text .. "\n[INFO] Firing original remotes for fixed 3 items..."
    end
    local success = fireBothRemotes()
    if success then
        wait(0.5)
        saveData()
        if consoleOutput then
            consoleOutput.Text = consoleOutput.Text .. "\n[SUCCESS] Fixed dupe: 3 items added. Relog to verify."
        end
    else
        if consoleOutput then
            consoleOutput.Text = consoleOutput.Text .. "\n[ERROR] Fixed dupe failed. Check remotes."
        end
    end
end

-- Create simple UI with text list of all remotes (alphabetical)
local consoleOutput = nil
local remoteListFrame = nil
local selectedRemote = nil
local selectedName = ""
local selectedItem = nil
local function createUI()
    gui = Instance.new("ScreenGui")
    gui.Name = "UniversalIslandsDupe"
    gui.Parent = player:WaitForChild("PlayerGui")
    
    frame = Instance.new("Frame")
    frame.Size = UDim2.new(0, 600, 0, 600)
    frame.Position = UDim2.new(0, 10, 0, 10)
    frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    frame.BackgroundTransparency = 0
    frame.BorderSizePixel = 2
    frame.BorderColor3 = Color3.fromRGB(100, 100, 100)
    frame.Active = true
    frame.Draggable = true
    frame.Parent = gui
    frame.Visible = enabled
    
    local title = Instance.new("TextLabel")
    title.Size = UDim2.new(1, 0, 0, 25)
    title.BackgroundTransparency = 1
    title.Text = "Universal Islands Permanent Duplicator"
    title.TextColor3 = Color3.fromRGB(255, 255, 255)
    title.TextScaled = true
    title.Font = Enum.Font.SourceSansBold
    title.Parent = frame

    -- Island Selector Section
    local islandLabel = Instance.new("TextLabel")
    islandLabel.Size = UDim2.new(0.3, 0, 0, 20)
    islandLabel.Position = UDim2.new(0.025, 0, 0, 30)
    islandLabel.BackgroundTransparency = 1
    islandLabel.Text = "Island Selector:"
    islandLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    islandLabel.Font = Enum.Font.SourceSansBold
    islandLabel.TextScaled = true
    islandLabel.Parent = frame

    local islandDropdown = Instance.new("ScrollingFrame")
    islandDropdown.Size = UDim2.new(0.4, 0, 0, 60)
    islandDropdown.Position = UDim2.new(0.35, 0, 0, 30)
    islandDropdown.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    islandDropdown.BorderSizePixel = 1
    islandDropdown.ScrollBarThickness = 6
    islandDropdown.Parent = frame

    local islandLayout = Instance.new("UIListLayout")
    islandLayout.SortOrder = Enum.SortOrder.LayoutOrder
    islandLayout.Padding = UDim.new(0, 2)
    islandLayout.Parent = islandDropdown

    local selectIslandBtn = Instance.new("TextButton")
    selectIslandBtn.Size = UDim2.new(0.2, 0, 0, 20)
    selectIslandBtn.Position = UDim2.new(0.775, 0, 0, 30)
    selectIslandBtn.Text = "Select Island"
    selectIslandBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    selectIslandBtn.BackgroundColor3 = Color3.fromRGB(100, 100, 150)
    selectIslandBtn.BorderSizePixel = 0
    selectIslandBtn.Font = Enum.Font.SourceSansBold
    selectIslandBtn.TextScaled = true
    selectIslandBtn.Parent = frame
    selectIslandBtn.MouseButton1Click:Connect(function()
        if selectedIsland then
            pcall(function()
                if islandSelector then
                    -- Try different parameter combinations for island selection
                    local params = {selectedIsland.name, selectedIsland.obj, player}
                    local selected = false
                    for _, param in ipairs(params) do
                        pcall(function()
                            if islandSelector:IsA("RemoteEvent") then
                                islandSelector:FireServer(param)
                            else
                                islandSelector:InvokeServer(param)
                            end
                            selected = true
                        end)
                        if selected then break end
                        wait(0.1)
                    end
                end
                print("Selected island: " .. selectedIsland.name)
                if consoleOutput then
                    consoleOutput.Text = "Selected island: " .. selectedIsland.name
                end
            end)
        else
            if consoleOutput then
                consoleOutput.Text = "No island selected"
            end
        end
    end)

    -- Function to populate island dropdown
    local function populateIslandDropdown()
        for _, child in ipairs(islandDropdown:GetChildren()) do
            if child:IsA("TextButton") then child:Destroy() end
        end

        for i, islandData in ipairs(allIslands) do
            local btn = Instance.new("TextButton")
            btn.Size = UDim2.new(1, 0, 0, 20)
            btn.BackgroundColor3 = Color3.fromRGB(60, 60, 100)
            btn.BorderSizePixel = 0
            btn.Text = islandData.name
            btn.TextColor3 = Color3.fromRGB(255, 255, 255)
            btn.Font = Enum.Font.SourceSans
            btn.TextScaled = true
            btn.LayoutOrder = i
            btn.Parent = islandDropdown

            btn.MouseButton1Click:Connect(function()
                selectedIsland = islandData
                if consoleOutput then
                    consoleOutput.Text = "Island selected: " .. selectedIsland.name
                end
            end)
        end

        islandDropdown.CanvasSize = UDim2.new(0, 0, 0, islandLayout.AbsoluteContentSize.Y)
    end

    -- Main Tab Buttons
    local mainTabFrame = Instance.new("Frame")
    mainTabFrame.Size = UDim2.new(0.95, 0, 0, 30)
    mainTabFrame.Position = UDim2.new(0.025, 0, 0, 100)
    mainTabFrame.BackgroundTransparency = 1
    mainTabFrame.Parent = frame

    local mainTabLayout = Instance.new("UIListLayout")
    mainTabLayout.FillDirection = Enum.FillDirection.Horizontal
    mainTabLayout.HorizontalAlignment = Enum.HorizontalAlignment.Left
    mainTabLayout.SortOrder = Enum.SortOrder.LayoutOrder
    mainTabLayout.Padding = UDim.new(0, 5)
    mainTabLayout.Parent = mainTabFrame

    -- Create main tab buttons
    local function createMainTab(name, displayName)
        local btn = Instance.new("TextButton")
        btn.Size = UDim2.new(0, 120, 1, 0)
        btn.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
        btn.BorderSizePixel = 1
        btn.BorderColor3 = Color3.fromRGB(150, 150, 150)
        btn.Text = displayName
        btn.TextColor3 = Color3.fromRGB(255, 255, 255)
        btn.Font = Enum.Font.SourceSansBold
        btn.TextScaled = true
        btn.Parent = mainTabFrame

        btn.MouseButton1Click:Connect(function()
            currentMainTab = name
            -- Update button appearances
            for _, tabBtn in ipairs(mainTabButtons) do
                tabBtn.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
            end
            btn.BackgroundColor3 = Color3.fromRGB(120, 120, 150)

            -- Show/hide UI elements based on tab
            if name == "remotes" then
                param1Input.Visible = true
                param2Input.Visible = true
                param3Input.Visible = true
                param4Input.Visible = true
                amountInput.Visible = false
                -- Hide dupe tabs
                for _, dupeBtn in ipairs(dupeTabButtons) do
                    dupeBtn.Visible = false
                end
            else -- duping
                param1Input.Visible = false
                param2Input.Visible = false
                param3Input.Visible = false
                param4Input.Visible = false
                amountInput.Visible = true
                -- Show dupe tabs
                for _, dupeBtn in ipairs(dupeTabButtons) do
                    dupeBtn.Visible = true
                end
                if #allItems == 0 then
                    scanItems()
                end
            end

            populateList()
            if consoleOutput then
                consoleOutput.Text = "Switched to " .. displayName .. " tab"
            end
        end)

        table.insert(mainTabButtons, btn)
        return btn
    end

    -- Create main tabs
    local remotesTab = createMainTab("remotes", "Remotes")
    local dupingTab = createMainTab("duping", "Duping")

    -- Set initial tab
    remotesTab.BackgroundColor3 = Color3.fromRGB(120, 120, 150)

    -- Duping Tab Internal Tabs
    local dupeTabFrame = Instance.new("Frame")
    dupeTabFrame.Size = UDim2.new(0.95, 0, 0, 25)
    dupeTabFrame.Position = UDim2.new(0.025, 0, 0, 135)
    dupeTabFrame.BackgroundTransparency = 1
    dupeTabFrame.Visible = false  -- Initially hidden
    dupeTabFrame.Parent = frame

    local dupeTabLayout = Instance.new("UIListLayout")
    dupeTabLayout.FillDirection = Enum.FillDirection.Horizontal
    dupeTabLayout.HorizontalAlignment = Enum.HorizontalAlignment.Left
    dupeTabLayout.SortOrder = Enum.SortOrder.LayoutOrder
    dupeTabLayout.Padding = UDim.new(0, 3)
    dupeTabLayout.Parent = dupeTabFrame

    -- Create dupe tab buttons
    local function createDupeTab(category)
        local displayName = category == "tools & benches" and "TOOLS" or
                           category == "blocks" and "BLOCKS" or
                           category:upper()
        local btn = Instance.new("TextButton")
        btn.Size = UDim2.new(0, 70, 1, 0)
        btn.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
        btn.BorderSizePixel = 1
        btn.BorderColor3 = Color3.fromRGB(100, 100, 100)
        btn.Text = displayName
        btn.TextColor3 = Color3.fromRGB(255, 255, 255)
        btn.Font = Enum.Font.SourceSansBold
        btn.TextScaled = true
        btn.Visible = false  -- Initially hidden
        btn.Parent = dupeTabFrame

        btn.MouseButton1Click:Connect(function()
            currentDupeTab = category
            -- Update button appearances
            for _, tabBtn in ipairs(dupeTabButtons) do
                tabBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
            end
            btn.BackgroundColor3 = Color3.fromRGB(100, 100, 120)

            populateList()
            if consoleOutput then
                consoleOutput.Text = "Switched to " .. displayName .. " category"
            end
        end)

        table.insert(dupeTabButtons, btn)
        return btn
    end

    -- Create dupe category tabs
    for _, category in ipairs(itemCategories) do
        createDupeTab(category)
    end

    -- Set initial dupe tab
    if #dupeTabButtons > 0 then
        dupeTabButtons[1].BackgroundColor3 = Color3.fromRGB(100, 100, 120)
    end

    -- Amount input for items
    amountInput = Instance.new("TextBox")
    amountInput.Size = UDim2.new(0.3, 0, 0, 25)
    amountInput.Position = UDim2.new(0.35, 0, 0, 100)
    amountInput.Text = "1"
    amountInput.PlaceholderText = "Amount"
    amountInput.TextColor3 = Color3.fromRGB(255, 255, 255)
    amountInput.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    amountInput.BorderSizePixel = 0
    amountInput.Visible = false  -- Initially hidden for remotes tab
    amountInput.Parent = frame

    -- Rescan button
    local rescanBtn = Instance.new("TextButton")
    rescanBtn.Size = UDim2.new(0.3, 0, 0, 25)
    rescanBtn.Position = UDim2.new(0.675, 0, 0, 100)
    rescanBtn.Text = "Rescan"
    rescanBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    rescanBtn.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
    rescanBtn.BorderSizePixel = 0
    rescanBtn.Font = Enum.Font.SourceSansBold
    rescanBtn.TextScaled = true
    rescanBtn.Parent = frame
    rescanBtn.MouseButton1Click:Connect(function()
        if currentMainTab == "remotes" then
            allRemotes = {}
            if netManaged then
                for _, child in ipairs(netManaged:GetDescendants()) do
                    if child:IsA("RemoteEvent") or child:IsA("RemoteFunction") then
                        local isInventory = false
                        local isIsland = false
                        for _, name in ipairs(inventoryNames) do
                            if string.find(child.Name:lower(), name:lower()) then
                                isInventory = true
                                break
                            end
                        end
                        for _, name in ipairs(islandNames) do
                            if string.find(child.Name:lower(), name:lower()) then
                                isIsland = true
                                break
                            end
                        end
                        table.insert(allRemotes, {
                            name = child.Name,
                            obj = child,
                            isEvent = child:IsA("RemoteEvent"),
                            isInventory = isInventory,
                            isIsland = isIsland
                        })
                    end
                end
            end
            table.sort(allRemotes, function(a, b) return a.name < b.name end)
        else
            scanItems()
        end
        scanIslands()
        populateIslandDropdown()
        populateList()
        if consoleOutput then
            consoleOutput.Text = "Rescanned " .. (currentMainTab == "remotes" and #allRemotes or #allItems) .. " " .. currentMainTab .. " and " .. #allIslands .. " islands"
        end
    end)

    -- List frame (dynamic for remotes or items)
    remoteListFrame = Instance.new("ScrollingFrame")
    remoteListFrame.Size = UDim2.new(0.95, 0, 0, 250)
    remoteListFrame.Position = UDim2.new(0.025, 0, 0, 130)
    remoteListFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    remoteListFrame.BorderSizePixel = 0
    remoteListFrame.ScrollBarThickness = 8
    remoteListFrame.Parent = frame

    local listLayout = Instance.new("UIListLayout")
    listLayout.SortOrder = Enum.SortOrder.LayoutOrder
    listLayout.Padding = UDim.new(0, 2)
    listLayout.Parent = remoteListFrame

    -- Parameter inputs (only shown in remotes mode)
    local param1Input = Instance.new("TextBox")
    param1Input.Size = UDim2.new(0.22, 0, 0, 25)
    param1Input.Position = UDim2.new(0.025, 0, 0, 390)
    param1Input.Text = ""
    param1Input.PlaceholderText = "Item ID"
    param1Input.TextColor3 = Color3.fromRGB(255, 255, 255)
    param1Input.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    param1Input.BorderSizePixel = 0
    param1Input.Visible = (currentMode == "remotes")
    param1Input.Parent = frame

    local param2Input = Instance.new("TextBox")
    param2Input.Size = UDim2.new(0.22, 0, 0, 25)
    param2Input.Position = UDim2.new(0.275, 0, 0, 390)
    param2Input.Text = ""
    param2Input.PlaceholderText = "Amount"
    param2Input.TextColor3 = Color3.fromRGB(255, 255, 255)
    param2Input.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    param2Input.BorderSizePixel = 0
    param2Input.Visible = (currentMode == "remotes")
    param2Input.Parent = frame

    local param3Input = Instance.new("TextBox")
    param3Input.Size = UDim2.new(0.22, 0, 0, 25)
    param3Input.Position = UDim2.new(0.525, 0, 0, 390)
    param3Input.Text = ""
    param3Input.PlaceholderText = "Player/User"
    param3Input.TextColor3 = Color3.fromRGB(255, 255, 255)
    param3Input.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    param3Input.BorderSizePixel = 0
    param3Input.Visible = (currentMode == "remotes")
    param3Input.Parent = frame

    local param4Input = Instance.new("TextBox")
    param4Input.Size = UDim2.new(0.22, 0, 0, 25)
    param4Input.Position = UDim2.new(0.775, 0, 0, 390)
    param4Input.Text = ""
    param4Input.PlaceholderText = "Extra Param"
    param4Input.TextColor3 = Color3.fromRGB(255, 255, 255)
    param4Input.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    param4Input.BorderSizePixel = 0
    param4Input.Visible = (currentMode == "remotes")
    param4Input.Parent = frame


    -- Fire button
    local fireBtn = Instance.new("TextButton")
    fireBtn.Size = UDim2.new(0.45, 0, 0, 25)
    fireBtn.Position = UDim2.new(0.5, 0, 0, 420)
    fireBtn.Text = "Fire Selected"
    fireBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    fireBtn.BackgroundColor3 = Color3.fromRGB(0, 150, 0)
    fireBtn.BorderSizePixel = 0
    fireBtn.Font = Enum.Font.SourceSansBold
    fireBtn.TextScaled = true
    fireBtn.Parent = frame
    fireBtn.MouseButton1Click:Connect(function()
        if currentMainTab == "remotes" then
            if not selectedRemote then
                if consoleOutput then consoleOutput.Text = "No remote selected" end
                return
            end
            local params = {}
            local paramInputs = {param1Input, param2Input, param3Input, param4Input}
            for _, input in ipairs(paramInputs) do
                local text = input.Text
                if text ~= "" then
                    local num = tonumber(text)
                    if num then
                        table.insert(params, num)
                    else
                        table.insert(params, text)
                    end
                end
            end
            pcall(function()
                if selectedRemote:IsA("RemoteEvent") then
                    selectedRemote:FireServer(unpack(params))
                else
                    local result = selectedRemote:InvokeServer(unpack(params))
                    if consoleOutput then
                        consoleOutput.Text = "Invoked " .. selectedName .. ", result: " .. tostring(result)
                    end
                end
                if consoleOutput then
                    consoleOutput.Text = "Fired " .. selectedName .. " with " .. #params .. " params"
                end
            end)
        else -- duping tab
            if not selectedItem then
                if consoleOutput then consoleOutput.Text = "No item selected" end
                return
            end
            local amt = tonumber(amountInput.Text) or 1
            local count = dupeItem(selectedItem, amt)
            if consoleOutput then
                consoleOutput.Text = "Duped " .. selectedItem.name .. " x" .. count .. " (permanent)"
            end
        end
    end)

    -- Quick Add button
    local quickBtn = Instance.new("TextButton")
    quickBtn.Size = UDim2.new(0.45, 0, 0, 25)
    quickBtn.Position = UDim2.new(0.025, 0, 0, 450)
    quickBtn.Text = "Quick Add Item (ID:1, Amount:100)"
    quickBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    quickBtn.BackgroundColor3 = Color3.fromRGB(150, 100, 200)
    quickBtn.BorderSizePixel = 0
    quickBtn.Font = Enum.Font.SourceSansBold
    quickBtn.TextScaled = true
    quickBtn.Parent = frame
    quickBtn.MouseButton1Click:Connect(function()
        if currentMainTab == "remotes" then
            if not selectedRemote then
                if consoleOutput then consoleOutput.Text = "No remote selected" end
                return
            end
            pcall(function()
                if selectedRemote:IsA("RemoteEvent") then
                    selectedRemote:FireServer(1, 100)
                else
                    local result = selectedRemote:InvokeServer(1, 100)
                    if consoleOutput then
                        consoleOutput.Text = "Invoked " .. selectedName .. ", result: " .. tostring(result)
                    end
                end
                if consoleOutput then
                    consoleOutput.Text = "Quick added item ID:1, amount:100"
                end
            end)
        else -- duping tab
            if not selectedItem then
                if consoleOutput then consoleOutput.Text = "No item selected" end
                return
            end
            local count = dupeItem(selectedItem, 100)
            if consoleOutput then
                consoleOutput.Text = "Quick duped " .. selectedItem.name .. " x100 (permanent)"
            end
        end
    end)

    -- Fixed dupe
    local fixedBtn = Instance.new("TextButton")
    fixedBtn.Size = UDim2.new(0.45, 0, 0, 25)
    fixedBtn.Position = UDim2.new(0.025, 0, 0, 480)
    fixedBtn.Text = "Fixed Dupe (3 Items)"
    fixedBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    fixedBtn.BackgroundColor3 = Color3.fromRGB(0, 100, 200)
    fixedBtn.BorderSizePixel = 0
    fixedBtn.Font = Enum.Font.SourceSansBold
    fixedBtn.TextScaled = true
    fixedBtn.Parent = frame
    fixedBtn.MouseButton1Click:Connect(fixedDupe)

    -- Retry last dupe
    local retryBtn = Instance.new("TextButton")
    retryBtn.Size = UDim2.new(0.45, 0, 0, 25)
    retryBtn.Position = UDim2.new(0.5, 0, 0, 480)
    retryBtn.Text = "Retry Last Dupe"
    retryBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    retryBtn.BackgroundColor3 = Color3.fromRGB(200, 100, 100)
    retryBtn.BorderSizePixel = 0
    retryBtn.Font = Enum.Font.SourceSansBold
    retryBtn.TextScaled = true
    retryBtn.Parent = frame
    retryBtn.MouseButton1Click:Connect(function()
        if currentMainTab == "duping" and selectedItem then
            local amt = tonumber(amountInput.Text) or 1
            local count = dupeItem(selectedItem, amt)
            if consoleOutput then
                consoleOutput.Text = "Retried duping " .. selectedItem.name .. " x" .. count .. " (permanent)"
            end
        else
            if consoleOutput then
                consoleOutput.Text = "No item selected to retry or not in duping tab"
            end
        end
    end)

    -- Function to get item category from ID
    local function getItemCategory(itemId)
        return itemCategories[itemId] or "misc"
    end

    -- Function to populate list
    function populateList()
        for _, child in ipairs(remoteListFrame:GetChildren()) do
            if child:IsA("TextButton") or child:IsA("TextLabel") then child:Destroy() end
        end

        if currentMainTab == "remotes" then
            for i, remoteData in ipairs(allRemotes) do
                local btn = Instance.new("TextButton")
                btn.Size = UDim2.new(1, 0, 0, 25)
                -- Color coding: Green for inventory, Yellow for island, Gray for others
                if remoteData.isIsland then
                    btn.BackgroundColor3 = Color3.fromRGB(150, 150, 100)
                elseif remoteData.isInventory then
                    btn.BackgroundColor3 = Color3.fromRGB(100, 150, 100)
                else
                    btn.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
                end
                btn.BorderSizePixel = 0
                local tags = {}
                if remoteData.isInventory then table.insert(tags, "[INVENTORY]") end
                if remoteData.isIsland then table.insert(tags, "[ISLAND]") end
                btn.Text = remoteData.name .. (remoteData.isEvent and " (Event)" or " (Function)") .. (#tags > 0 and " " .. table.concat(tags, " ") or "")
                btn.TextColor3 = Color3.fromRGB(255, 255, 255)
                btn.Font = Enum.Font.SourceSans
                btn.TextScaled = true
                btn.LayoutOrder = i
                btn.Parent = remoteListFrame

                btn.MouseButton1Click:Connect(function()
                    selectedRemote = remoteData.obj
                    selectedName = remoteData.name
                    selectedItem = nil
                    if consoleOutput then
                        consoleOutput.Text = "Selected: " .. selectedName
                    end
                    -- Pre-fill params if inventory
                    if remoteData.isInventory then
                        param1Input.Text = "1"  -- itemId
                        param2Input.Text = "100"  -- amount
                        param3Input.Text = ""
                        param4Input.Text = ""
                        if consoleOutput then
                            consoleOutput.Text = consoleOutput.Text .. "\n[INFO] Pre-filled params: itemId=1, amount=100"
                        end
                    end
                end)
            end

            if #allRemotes == 0 then
                local noRemotes = Instance.new("TextLabel")
                noRemotes.Size = UDim2.new(1, 0, 0, 25)
                noRemotes.BackgroundTransparency = 1
                noRemotes.Text = "No remotes found."
                noRemotes.TextColor3 = Color3.fromRGB(200, 200, 200)
                noRemotes.Font = Enum.Font.SourceSans
                noRemotes.TextScaled = true
                noRemotes.Parent = remoteListFrame
            end
        else -- duping tab
            -- Filter items by current category and sort by ID
            local filteredItems = {}
            for _, itemData in ipairs(allItems) do
                local itemCategory = getItemCategory(itemData.id)
                if currentDupeTab == "all" or itemCategory == currentDupeTab then
                    table.insert(filteredItems, itemData)
                end
            end

            -- Sort by ID (numerical order)
            table.sort(filteredItems, function(a, b) return a.id < b.id end)

            for i, itemData in ipairs(filteredItems) do
                local btn = Instance.new("TextButton")
                btn.Size = UDim2.new(1, 0, 0, 25)
                btn.BackgroundColor3 = Color3.fromRGB(60, 100, 150)
                btn.BorderSizePixel = 0
                btn.Text = itemData.name .. " (ID: " .. itemData.id .. ") - Click to dupe"
                btn.TextColor3 = Color3.fromRGB(255, 255, 255)
                btn.Font = Enum.Font.SourceSans
                btn.TextScaled = true
                btn.LayoutOrder = i
                btn.Parent = remoteListFrame

                btn.MouseButton1Click:Connect(function()
                    selectedItem = itemData
                    selectedRemote = nil
                    selectedName = itemData.name
                    if consoleOutput then
                        consoleOutput.Text = "Selected: " .. selectedName .. " (ID: " .. itemData.id .. ")"
                    end
                end)
            end

            if #filteredItems == 0 then
                local noItems = Instance.new("TextLabel")
                noItems.Size = UDim2.new(1, 0, 0, 25)
                noItems.BackgroundTransparency = 1
                noItems.Text = "No items found in " .. currentDupeTab .. " category. Try rescanning."
                noItems.TextColor3 = Color3.fromRGB(200, 200, 200)
                noItems.Font = Enum.Font.SourceSans
                noItems.TextScaled = true
                noItems.Parent = remoteListFrame
            end
        end

        remoteListFrame.CanvasSize = UDim2.new(0, 0, 0, listLayout.AbsoluteContentSize.Y)
    end

    -- Initial scan and populate
    scanIslands()
    populateIslandDropdown()
    populateList()

    -- Console
    consoleOutput = Instance.new("TextLabel")
    consoleOutput.Size = UDim2.new(0.95, 0, 0, 45)
    consoleOutput.Position = UDim2.new(0.025, 0, 0, 510)
    consoleOutput.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
    consoleOutput.BorderSizePixel = 1
    consoleOutput.BorderColor3 = Color3.fromRGB(0, 255, 0)
    consoleOutput.Text = "[CONSOLE] Select island first, then item for permanent duplication. Uses item substitution method for persistent items. Relog to verify."
    consoleOutput.TextColor3 = Color3.fromRGB(0, 255, 0)
    consoleOutput.TextSize = 11
    consoleOutput.TextWrapped = true
    consoleOutput.TextYAlignment = Enum.TextYAlignment.Top
    consoleOutput.Font = Enum.Font.Code
    consoleOutput.Parent = frame

    -- Print override
    local oldPrint = print
    print = function(...)
        local msg = table.concat({...}, " ")
        if consoleOutput then
            local lines = consoleOutput.Text:split("\n")
            table.insert(lines, "[PRINT] " .. msg)
            if #lines > 8 then table.remove(lines, 1) end
            consoleOutput.Text = table.concat(lines, "\n")
        end
        oldPrint(...)
    end
end

-- Toggle UI
UserInputService.InputBegan:Connect(function(input)
    if input.KeyCode == Enum.KeyCode.D then
        enabled = not enabled
        if frame then
            frame.Visible = enabled
        end
        if not gui then
            createUI()
        end
    elseif input.KeyCode == Enum.KeyCode.Delete then
        if gui then
            gui:Destroy()
            gui = nil
        end
    end
end)

-- Initialize
createUI()
print("Universal Islands Permanent Duplicator loaded! Press 'D' to toggle UI. Features permanent item duplication via server substitution.")