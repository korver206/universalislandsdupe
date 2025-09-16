# Universal Islands Dupe - Active Context Tracker (ACT.md)

## Project Overview
This project consists of a collection of Lua scripts designed to exploit duplication mechanics in the Roblox game "Islands". The primary goal is to duplicate in-game items using server-side remotes and client-side manipulation.

**Target Game:** Roblox Islands (various versions and updates)
**Purpose:** Item duplication exploit for game progression/cheating
**Risk Level:** High - May result in account bans if detected

## Current Scripts

### UniversalIslandsDupe.lua (Main Script)
- **Location:** IslandsDUPE/UniversalIslandsDupe.lua
- **Features:**
  - Advanced UI with tabbed interface (Remotes/Items/Islands)
  - Automatic remote discovery and scanning
  - Island selector for targeted duplication
  - Known item ID database with fallback scanning
  - Persistence via save remotes
  - Console output with real-time logging
  - Parameter input for custom remote firing
- **UI Controls:** Toggle with 'D' key, Delete to destroy UI
- **Compatibility:** Vega X and other Lua executors

### NewIslandsDuplicationScript.lua
- **Location:** ROBLOX/NewIslandsDuplicationScript.lua
- **Features:**
  - Simplified UI with console logging
  - Comprehensive remote scanning across all game services
  - Debug mode toggle
  - Auto-scan on load
  - Shimmer effects on UI elements
- **UI Controls:** Toggle with 'G' key, Shift+G to stop
- **Compatibility:** Vega X executor

### Other Scripts
- **OptimizedIslandsDuplicationScript.lua:** Performance-optimized version
- **SimpleIslandsDuplicationScript.lua:** Basic duplication without advanced UI
- **TabbedIslandsDuplicationScript.lua:** Tabbed interface variant

## Key Components

### Critical Remotes
- `client_request_35`: Primary duplication remote (FireServer with itemId, amount)
- `RedeemAnniversary`: Secondary dupe remote (FireServer with no args)
- Save remotes: Various names like "SaveData", "UpdateData", "Persist" for data saving

### Known Item IDs (Categorized)

#### COMBAT
- Aquamarine Sword: 2
- Ancient Longbow: 3
- Cactus Spike: 6
- Cutlass: 8 (Skin)
- Diamond Great Sword: 9
- Diamond War Hammer: 10
- Gilded Steel Hammer: 12
- Staff of Godzilla: 13
- Iron War Axe: 15
- Rageblade: 16
- Spellbook: 19
- Lightning Scepter: 21
- Tidal Spellbook: 22
- Azarathian Longbow: 24
- Kong's Axe: 549
- Regen Potion: 475
- Strength Potion: 476
- Ruby Staff: 721
- The Captain's Rapier: 828
- Obsidian Hilt: 844
- Obsidian Greatsword: 845
- Frost Sword: 1094
- Frost Hammer: 1095
- Maple Shield: 1055
- Antler Shield: 1056
- Antler Hammer: 1057
- The Dragonslayer: 961
- Pumpkin Hammer: 1021
- Spirit Spellbook: 1272
- Ruby Sword: 1283
- Void Potion: 1338
- Toxin Potion: 1758
- Noxious Stinger: 1738
- Serpents Hook: 1331
- Serpents Bane: 1332
- Slime Queens Scepter: 1320
- Trouts Fury: 1321
- The Reapers Crossbow: 1517
- The Reapers Scythe: 1518
- Iron Shortbow: 1400
- Golden Shortbow: 1401
- Hardened Bow Limb: 1418
- Long Crossbow Bolt: 1467
- Wooden Mallet: 1471
- Granite Hammer: 1472
- Candy Cane Scepter Weapon: 1665
- Jolly Dagger: 1681
- Natures Divine Longbow: 1858
- Poison Long Arrow: 1859
- The Divine Dao: 1860
- Cursed Grimoire: 1862
- Cursed Hammer: 1863
- Infernal Hammer: 1251

#### MINERALS
- Aquamarine Shard: 27
- Buffalkor Crystal: 28
- Electrite: 31
- Crystallized Aquamarine: 37
- Crystallized Gold: 38
- Crystallized Iron: 39
- Diamond: 40
- Enchanted Diamond: 41
- Ruby: 720
- Pearl: 532
- Crystallized Obsidian: 829
- Spirit Crystal: 1930
- Infernal Flame: 1252
- Amethyst Crystal: 1337

#### INDUSTRIAL
- Copper Bolt: 32
- Copper Ingot: 33
- Copper Plate: 35
- Copper Rod: 36
- Gearbox: 42
- Gilded Steel Rod: 43
- Gold Ingot: 44
- Iron Ingot: 46
- Red Bronze Ingot: 48
- Steel Bolt: 49
- Steel Ingot: 50
- Steel Plate: 51
- Steel Rod: 52
- And Gate: 163
- Coal Generator: 165
- Combiner: 166
- Electrical Workbench: 167
- Firework Launcher: 168
- Or Gate: 170
- Conveyor Sensor: 171
- Solar Panel: 172
- Conveyor Belt: 298
- Drill: 299
- Industrial Chest: 301
- Food Processor: 302
- Industrial Oven: 303
- Industrial Sawmill: 304
- Industrial Smelter: 305
- Industrial Stonecutter: 306
- Industrial Washing Station: 307
- Copper Press: 308
- Input/Output Chest: 309
- Left Conveyor Belt: 311
- Medium Chest: 312
- Randomizer: 320
- Industrial Lumbermill: 321
- Industrial Milker: 322
- Wool Vacuum: 323
- Red Bronze Refinery: 324
- Right Conveyor Belt: 326
- Rod Factory Mold: 327
- Sawmill: 328
- Small Chest: 329
- Small Furnace: 330
- Basic Sprinkler: 331
- Steel Mill: 332
- Steel Press: 333
- Stonecutter: 334
- Vending Machine: 336
- Washing Station: 337
- Water Catcher: 339
- Bolt Factory Mold: 294
- Campfire: 295
- Industrial Polishing Station: 756
- Polishing Station: 757
- Oil Barrel: 877
- Petroleum Barrel: 878
- Oil Refinery: 879
- Pumpjack: 880
- Pipe: 881
- Pipe Junction: 882
- Tier 2 Right Conveyor Belt: 883
- Tier 2 Left Conveyor Belt: 884
- Tier 2 Conveyor Ramp Up: 885
- Petroleum Tank: 887
- Oil Tank: 888
- Tier 2 Crate Packer: 889
- Tree Fruit Shaker: 890
- Sapling Automatic Planter: 891
- Petroleum Petrifier: 892
- Fuel Barrel Extractor: 893
- Fuel Barrel Filler: 894
- Merger: 895
- Automated Trough: 897
- Petrified Petroleum: 898
- Tier 2 Vending Machine: 913
- Filter Conveyor: 914
- Pallet Packer: 915
- Sap Boiler: 1049
- Syrup Bottler: 1050
- Blast Furnace: 1267
- Serpents Scale: 1333
- Serpents Fang: 1334
- Tier 2 Conveyor Ramp Down: 1343
- Industrial Truffle Barrel: 1732
- Industrial Nest: 1733
- Tier 2 Conveyor Belt: 1519
- Plate Factory Mold: 1887
- Steel ATM: 1921
- Gold ATM: 1922
- Diamond ATM: 1923
- LED Light: 1925
- Timer: 1926
- Oil Fuel: 1249
- Petroleum Fuel: 1250
- Green Page: 1678
- Blue Page: 1679
- Red Page: 1680

#### TOOLS & BENCHES
- Electrical Workbench: 167
- Christmas Shovel: 187
- Diamond Axe: 191
- Diamond Pickaxe: 192
- Diamond Sickle: 193
- Gilded Steel Axe: 198
- Gilded Steel Pickaxe: 199
- Gilded Steel Sickle: 200
- Iron Fishing Rod: 205
- Leaf Clippers: 207
- Wire Tool: 220
- Workbench Tier 3: 225
- Cletus Lucky Sickle: 870
- Cletus Lucky Watering Can: 871
- Cletus Lucky Plow: 874
- Workbench Tier 4: 896
- Opal Pickaxe: 962
- Opal Axe: 963
- Opal Pickaxe Hilt: 964
- Opal Axe Hilt: 965
- Opal Sword Hilt: 966
- Void Mattock: 1344
- Void Mattock Hilt: 1345
- Thomas Lucky Fishing Rod: 1319
- Golden Net: 1376
- Workbench (tree stump): 1924

#### ANIMALS
- Animal Well-Being Kit: 343
- Chicken Spawn Egg Tier 2: 349
- Chicken Spawn Egg Tier 3: 350
- Cow Spawn Egg Tier 2: 354
- Cow Spawn Egg Tier 3: 355
- Pig Spawn Egg Tier 2: 364
- Pig Spawn Egg Tier 3: 365
- Sheep Spawn Egg Tier 2: 369
- Sheep Spawn Egg Tier 3: 370
- Blue Firefly Jar: 541
- Green Firefly Jar: 542
- Purple Firefly Jar: 543
- Red Firefly Jar: 544
- Pink Rabbit: 787
- Turkey Spawn Egg Tier 2: 1073
- Turkey Spawn Egg Tier 3: 1074
- Duck Spawn Egg Tier 2: 1155
- Duck Spawn Egg Tier 3: 1156
- Yak Spawn Egg Tier 2: 1237
- Yak Spawn Egg Tier 3: 1238
- Horse Spawn Egg Tier 2: 1265
- Horse Spawn Egg Tier 3: 1266
- Vulture Spawn Egg Tier 2: 1751
- Vulture Spawn Egg Tier 3: 1752
- Yellow Butterfly Jar: 1369
- White Butterfly Jar: 1370
- Red Butterfly Jar: 1371
- Silver Butterfly Jar: 1372
- Green Butterfly Jar: 1373
- Blue Butterfly Jar: 1374
- Spider Pet Spawn Egg: 1516
- Penguin Pet Spawn Egg: 1667
- Dog Pet Spawn Egg: 1766
- Cat Pet Spawn Egg: 1864
- Koi: 1861

#### BLOCKS
- Diamond Block: 401
- Gold Block: 405
- Ice: 416
- Mushroom Block: 430
- Sea Lantern: 455
- Ruby Block: 722
- Magma Block: 967
- Green Slime Block: 860
- Blue Slime Block: 861
- Pink Slime Block: 862
- Candy Cane Block: 1089
- Compact Snow: 1090
- Compact Ice: 1091
- Ice Brick: 1092
- Copper Block: 1244
- Red Bronze Block: 1245
- Opal Block: 1246
- Pearl Block: 1273
- Buffalkor Crystal Block: 1274
- Void Block: 1284
- Chrome Glass Block: 1287
- Amethyst Block: 1336
- Void Stone Block: 1341
- Respawn Block: 1342
- Light Blue Coral Block: 1083
- Pink Coral Block: 1084
- Blue Coral Block: 1085
- Bone Block: 841
- Obsidian: 840
- Glowing Blue Mushroom Block: 1837
- Glowing Cyan Mushroom Block: 1838
- Glowing Green Mushroom Block: 1839
- Glowing Pink Mushroom Block: 1840
- Void Grass Block: 1889
- Void Sand Block: 1890

#### DECOR
- Fish Banner: 84
- Fish Festival Trophy 2021: 85
- Godzilla Trophy: 94
- Kong Trophy: 101
- PVP Alpha Trophy: 138
- Roblox Battles Trophy: 139
- Snow Globe: 144
- Tall Snowman: 147
- The Witches Trophy: 148
- Tidal Aquarium: 149
- Wide Snowman: 155
- Wreath: 157
- Shipwreck Podium: 719
- Lunar Banner: 737 (Limited)
- Islands First Anniversary Cake: 540
- Pirate Cannon: 832
- Pirate Barrel: 833
- Pirate Chair: 834
- Pirate Chandelier: 835
- Pirate Lamp: 836
- Pirate Ship Wheel: 837
- Pirate Ship: 838
- Pirate Table: 839
- Pirate Globe: 863
- Scarecrow Trophy: 875
- Cletus Scarecrow: 876
- DV Trophy: 912
- Butterfly Festival Trophy: 1375
- Halloween Event Trophy 2022: 1455
- Christmas Event 2022 Trophy: 1666
- Lunar 2023 Rabbit Statue: 1723
- Lunar Rabbit Plushie: 1724
- Lunar Rabbit Banner: 1725
- Islands Third Anniversary Cake: 1759
- Islands Second Anniversary Cake: 1760
- Mining Event Trophy 2023: 1770
- Mushroom Event Trophy 2023: 1857
- Turkey Trophy: 1927
- Mansion Cabinet: 1865
- Mansion Bench: 1866
- Mansion Desk: 1867
- Mansion Bust Pink: 1868
- Mansion Bust Blue: 1869
- Mansion Bust Green: 1870
- Mansion Bed: 1871
- Mansion Rocking Horse: 1872
- Mansion Couch: 1873
- Mansion Grandfather Clock: 1874
- Wraith Boss Plushie: 1875
- Spirit Flower Pot: 1892
- Spirit Flower Vase: 1893
- Spirit Jar Light: 1894
- Spirit Lantern: 1895
- Spirit Plant: 1896
- Spirit Statue: 1897
- Spirit Stool: 1898
- Spirit Table: 1899
- Hanging Spirit Light: 1900
- Spirit Essence Holder: 1901
- Butterfly Couch: 1902
- Butterfly Lamp: 1903
- Small Bush Pot: 1904
- Medium Bush Pot: 1905
- Tall Bush Pot: 1906
- Frog Topiary Pot: 1908
- Rabbit Topiary Pot: 1909
- Frog Fountain: 1909
- Benched Gazebo: 1910
- Grey Gazebo: 1911
- Purple Gazebo: 1912
- Red Gazebo: 1913
- Purple Plush Butterfly Couch: 1914
- Pink Plush Butterfly Couch: 1915
- Red Flower Chair: 1916
- White Flower Chair: 1917
- Cyan Flower Chair: 1918
- Ladybug Ottoman: 1919
- Bee Ottoman: 1920
- Spirit Bench: 1929
- Spirit Lava Lamp: 1931
- Spirit Bed: 1932
- Rabbit Topiary: 1379
- Frog Topiary: 1380
- Butterfly Event Bench: 1377
- Butterfly Event Archway: 1378
- Lying Closed Coffin: 1456
- Lying Opened Coffin: 1457
- Standing Closed Coffin: 1458
- Standing Opened Coffin: 1459
- Group of Ghosts: 1460
- Happy Ghost: 1461
- Evil Ghost: 1462
- Surprised Ghost: 1463
- Small Fire Chalice: 1465
- Tall Fire Chalice: 1466
- Pumpkin Candle: 1468
- Pumpkin Angry: 1469
- Pumpkin Happy: 1470
- Gravestone - All 3 Versions 2022: 1479
- Green Eyed Scarecrow: 1482
- Yellow Eyed Scarecrow: 1483
- Blue Gnome Bag: 1643
- Yellow Gnome Bag: 1644
- Red Gnome Bag: 1645
- Blue Standing Gnome: 1646
- Yellow Standing Gnome: 1647
- Red Standing Gnome: 1648
- Blue Cup Gnome: 1649
- Yellow Cup Gnome: 1650
- Red Cup Gnome: 1651
- Santa Stocking: 1652
- Elf Stocking: 1653
- Snowman Stocking: 1654
- Snowflake Stocking: 1655
- Cookie Stocking: 1656
- Candy Cane Fence: 1657
- Candy Cane Light Fence: 1658
- Santa Plushie: 1659
- Gnome Plushie: 1660
- Elf Plushie: 1661
- Reindeer Plushie: 1663
- White Reindeer Plushie: 1664
- Christmas Fence Light: 1668
- Red Christmas Street Light: 1669
- Green Christmas Street Light: 1670
- Black Christmas Street Light: 1671
- Rainbow Candy Cluster: 1672
- Red Candy Cluster: 1673
- Green Candy Cluster: 1674
- Red and White Christmas Lantern: 1675
- Green and White Christmas Lantern: 1676
- Red and Green Christmas Lantern: 1677
- Dumpling Couch: 1726
- Dumpling Chair: 1728
- Red Dynamite Box: 1771
- Wooden Dynamite Box: 1772
- Dynamite Wall Decor: 1773
- Black Mining Lantern: 1774
- Brown Mining Lantern: 1775
- Gold Mining Lantern: 1776
- Mining Couch Green: 1777
- Mining Couch Purple: 1778
- Mining Entrance: 1779
- Mining Gem Bag: 1780
- Mining Tool Bag: 1781
- Jade Plushie: 1782
- Sandbag: 1783
- Sandbag Pile: 1784
- Sandbag Stack: 1785
- Slime Mural 5: 1799
- Gold Small Brazier: 1800
- Gold Tall Brazier: 1801
- Primordial Plushie Beanbag: 1802
- Primordial Statue: 1803
- Cyan Glowing Mushroom: 1829
- Green Glowing Mushroom: 1830
- Pink Glowing Mushroom: 1831
- Blue Glowing Mushroom: 1832
- Yellow Mushroom Table: 1833
- Cyan Mushroom Table: 1834
- Red Mushroom Table: 1835
- Pink Mushroom Table: 1836
- Cyan Trunk Chair: 1841
- Red Trunk Chair: 1842
- Yellow Trunk Chair: 1843
- Pink Trunk Chair: 1844
- Cyan Outhouse: 1848
- Pink Outhouse: 1849
- Red Outhouse: 1850
- Yellow Outhouse: 1851
- Dark Brown Nature Fridge: 1852
- Light Brown Nature Fridge: 1853
- Purple Nature Fridge: 1854
- Tan Nature Fridge: 1855
- Cletus Plushie: 1765
- Draven Statue: 1769
- Pumpkin Cat: 1011
- Cobweb: 1012
- Ghost Lantern: 1013
- Halloween Lantern: 1014
- Gravestone 2021: 1015
- The Halloween Trophy: 1018
- Pumpkin Bed: 1019
- Candy Basket 2021: 1022
- Spooky Pumpkin: 1028
- Jack 0 Lantern: 789
- Candy Basket 2022: 1454
- Snowman (Furniture): 1115
- Train Bed: 1116
- Snowman Couch: 1117
- Snowman Bean Bag: 1118
- Candy Cane Lamp: 1119
- Bell (Christmas): 1122
- Christmas Tree: 1096
- Blue Ornament: 1097
- Orange Ornament: 1098
- Green Ornament: 1099
- Red Ornament: 1100
- Cletus Ornament: 1101
- Slime Ornament: 1102
- Cow Ornament: 1103
- Pig Ornament: 1104
- Red Nutcracker: 1105
- Blue Nutcracker: 1106
- Green Nutcracker: 1107
- Pineapple Totem: 1110

#### MISC
- Formula 86: 11
- Desert Portal: 158
- Wizard Portal: 159
- Slime Portal: 160
- Buffalkor Portal: 161
- Diamond Mines Portal: 162
- Christmas Present 2020: 488
- Legacy Food Processor: 489
- Portal Crystal: 492
- Buffalkor Portal Shard: 523
- Desert Portal Shard: 524
- Diamond Mines Portal Shard: 525
- Frosty Slime Ball: 526
- Gold Skorp Claw: 527
- Gold Skorp Scale: 528
- Green Sticky Gear: 529
- Iron Skorp Scale: 531
- Pink Sticky Gear: 533
- Slime Portal Shard: 538
- Wizard Portal Shard: 539
- Ancient Slime String: 520
- Blue Sticky Gear: 521
- Propeller: 535
- Ruby Skorp Scale: 536
- Ruby Skorp Stinger: 537
- Treasure Chest: 843
- Desert Chest: 864
- Desert Furnace: 865
- Chili Pepper Seeds: 872
- Cauldron 2021: 1010
- Chili Pepper Seeds: 872
- Cauldron 2021: 1010
- Red Envelope 2022: 1123
- Tiger Coin Bag: 1124
- Lucky Coin Bag: 1125
- Red Envelope 2023: 1729
- Gold Envelope 2023: 1730
- Confetti Popper: 1761
- Sparkler: 1762
- Party Horn: 1763
- Glow Stick: 1764
- Glitterball: 1768
- Dungeon Chest: 1804
- Serpent Egg: 1349
- Christmas Present 2021: 1093
- Christmas Present 2022: 1642
- Cauldron 2022: 1451
- Opened Cauldron 2022: 1452
- Cauldron 2023: 1877
- Opened Cauldron 2023: 1878
- Red Butterfly Lantern: 1397
- Green Butterfly Lantern: 1398
- Opened Treasure Chest: 842
- Opened Cauldron 2021: 1260
- Opened Dungeon Chest: 1805
- Ruby Skorp Claw: 1261

#### FOOD
- Carrot Cake: 266
- Chocolate Bar: 269
- Deviled Eggs: 270
- Jam Sandwich: 275
- Lollipop: 279
- Orange Candy: 283
- Potato Salad: 286
- Starfruit Cake: 287
- Tomato Soup: 289
- Roasted Honey Carrot: 952
- Truffle Avocado Toast: 1030
- Truffle Pizza: 1031
- Dragon Roll: 1032
- Philadelphia Roll: 1033
- Tai Nigiri: 1035
- Tuna Roll: 1036
- Potato and Duck Egg Scramble: 1161
- Glass of Milk: 1316
- Blueberry Cookie: 1317
- Fhanhorns Flower: 1069
- Fhanhorns Pancakes: 1070
- Bhutan Butter Tea: 1240
- Gondo Datshi: 1242
- Lunar Mooncake: 1722
- Maple Syrup (Glitched): 1253

#### CROPS
- Red Berry Seeds: 230
- Pumpkin Seeds: 249
- Radish Seeds: 251
- Starfruit Seeds: 253
- Watermelon Seeds: 257
- Chili Pepper Seeds: 872
- Blackberry Seeds: 994
- Blueberry Seeds: 995
- Rice Seeds: 1028
- Pineapple Seeds: 1110
- Seaweed Seeds: 1888
- Spirit Seeds: 1891
- Void Parasite Seeds: 1347
- Apple Tree Sapling: 505
- Lemon Tree Sapling: 511
- Orange Tree Sapling: 516
- Palm Tree Sapling: 517
- Cherry Blossom Sapling: 1713
- Kiwifruit Tree Sapling: 1928
- Candy Cane Seed: 1087

#### LUMBER
- Palm Tree Sapling: 517
- Spirit Sapling: 802
- Cherry Blossom Sapling: 1713
- Oak Wood: 1880
- Birch Wood: 1881
- Cherry Blossom Wood: 1882
- Hickory Wood: 1883
- Maple Wood: 1884
- Pine Wood: 1885
- Spirit Wood: 1886

#### FLOWERS
- Fertile White Rose: 582
- Fertile White Daffodil: 583
- White Daffodil: 584
- White Daisy: 585
- Fertile White Daisy: 586
- Fertile White Hibiscus: 587
- White Hibiscus: 588
- Fertile Red Daisy: 590
- Fertile Red Hyacinth: 591
- Red Hyacinth: 592
- Red Lily: 593 (Limited)
- Fertile Red Lily: 594
- Fertile Red Rose: 596
- Fertile Red Daffodil: 597
- Orange Hibiscus: 599
- Fertile Orange Hibiscus: 600
- Fertile Orange Daffodil: 601
- Orange Daffodil: 602
- Orange Hyacinth: 603
- Fertile Orange Hyacinth: 604
- Fertile Yellow Daffodil: 606
- Fertile Yellow Daisy: 608
- Fertile Yellow Lily: 609
- Yellow Lily: 610 (Limited)
- Fertile Yellow Hyacinth: 612
- Yellow Daffodil: 613
- Fertile Dark Green Daffodil: 615
- Dark Green Daisy: 617
- Fertile Dark Green Daisy: 618
- Fertile Dark Green Lily: 619
- Dark Green Lily: 620
- Light Green Daffodil: 621
- Fertile Light Green Daffodil: 622
- Fertile Light Green Hibiscus: 624
- Light Green Daisy: 625
- Fertile Light Green Daisy: 626
- Light Green Hyacinth: 627
- Fertile Light Green Hyacinth: 628
- Cyan Daisy: 629
- Fertile Cyan Daisy: 630
- Cyan Hyacinth: 631
- Fertile Cyan Hyacinth: 632
- Cyan Lily: 633
- Fertile Cyan Lily: 634
- Blue Hibiscus: 635
- Fertile Blue Hibiscus: 636
- Fertile Blue Rose: 637
- Blue Lily: 639
- Fertile Blue Lily: 640
- Blue Hyacinth: 641
- Fertile Blue Hyacinth: 642
- Purple Hibiscus: 643
- Fertile Purple Hibiscus: 644
- Purple Rose: 645
- Fertile Purple Rose: 646
- Black Hibiscus: 647
- Fertile Black Hibiscus: 648
- Black Lily: 649
- Fertile Black Lily: 650
- Pink Daffodil: 651
- Fertile Pink Daffodil: 652
- Pink Hibiscus: 653
- Fertile Pink Hibiscus: 654
- Pink Rose: 655
- Fertile Pink Rose: 656
- Fertile Red Tulip: 1177
- Fertile Yellow Tulip: 1179
- Fertile Orange Tulip: 1181
- Orange Tulip: 1182
- Fertile Light Green Tulip: 1183
- Light Green Tulip: 1184
- Fertile Dark Green Tulip: 1185
- Dark Green Tulip: 1186
- Fertile Pink Tulip: 1187
- Pink Tulip: 1188
- Fertile White Tulip: 1189
- White Tulip: 1190
- Fertile Purple Lavender: 1807
- Fertile White Lavender: 1808
- Fertile Red Lavender: 1809
- Red Lavender: 1810
- Fertile Pink Lavender: 1811
- Pink Lavender: 1812
- Fertile Black Lavender: 1813
- Black Lavender: 1814
- Fertile Blue Lavender: 1815
- Blue Lavender: 1816
- Fertile Yellow Lavender: 1817
- Yellow Lavender: 1818
- Fertile Cyan Lavender: 1819
- Cyan Lavender: 1820
- Fertile Light Green Lavender: 1821
- Light Green Lavender: 1822
- Fertile Dark Green Lavender: 1823
- Dark Green Lavender: 1824
- Fertile Orange Lavender: 1825
- Orange Lavender: 1826
- Fertile Chrome Lavender: 1827
- Chrome Lavender: 1828
- Fertile Black Chrysanthemum: 1288
- Fertile Red Chrysanthemum: 1289
- Fertile Pink Chrysanthemum: 1290
- Fertile Purple Chrysanthemum: 1291
- Fertile White Chrysanthemum: 1292
- Fertile Chrome Chrysanthemum: 1293
- Fertile Blue Chrysanthemum: 1294
- Fertile Cyan Chrysanthemum: 1295
- Purple Chrysanthemum: 1298
- White Chrysanthemum: 1299
- Chrome Chrysanthemum: 1300
- Blue Chrysanthemum: 1301
- Cyan Chrysanthemum: 1302
- Light Green Chrysanthemum: 1303
- Pink Chrysanthemum: 1388
- Yellow Hyacinth: 1389
- White Rose: 1390
- Blue Rose: 1393
- Red Chrysanthemum: 1393
- Black Chrysanthemum: 1394
- Light Green Hibiscus: 1395
- Yellow Daisy: 1382 (Limited)
- Yellow Tulip: 1383 (Limited)
- Red Daffodil: 1384 (Limited)
- Red Daisy: 1385 (Limited)
- Red Rose: 1386 (Limited)
- Red Tulip: 1387 (Limited)

#### TOTEMS
- Pumpkin Totem: 794
- Red Berry Bush Totem: 998
- Blackberry Bush Totem: 999
- Blueberry Bush Totem: 1000
- Pineapple Totem: 1110
- Dragonfruit Totem: 1330
- Obsidian Totem: 989

### UI Features
- **Toggle Keys:** D (main), G (new script)
- **Modes:** Remotes (fire custom), Items (dupe specific), Islands (select target)
- **Console:** Real-time logging, error capture, message history
- **Parameters:** Item ID, Amount, Player/User, Extra Param inputs
- **Buttons:** Fire Selected, Quick Add, Fixed Dupe, Retry Last, Rescan

#### Planned UI Improvements
- **Tabbed Interface:** Separate tabs for different functions
  - **Remotes Tab:** Remote exploration and command execution
  - **Duping Tab:** Complete item database with amount selection and direct backpack addition
    - **Internal Tabs within Duping Tab:**
      - **ALL Tab:** Complete list of all items in numerical order
      - **Category Tabs:** Separate tabs for each item category (COMBAT, MINERALS, INDUSTRIAL, etc.)
    - **Organization Requirements:** Items must maintain numerical ID order within any tab/filter
- **Item Stacking:** Leverage Islands' infinite stacking system where multiple items of same type occupy only 1 inventory slot (1 chest = 1 slot, 10,000 chests = 1 slot)
- **Smart Inventory Management:** Automatic stacking and backpack integration

## Usage Instructions

### Loading Scripts
1. Open Roblox Islands game
2. Launch your Lua executor (Vega X recommended)
3. Copy and paste the desired script
4. Execute the script

### Basic Duplication
1. Load the Universal script
2. Press 'D' to open UI
3. Select an island (recommended)
4. Choose item mode
5. Select item from list or enter custom ID
6. Set amount (1-100 recommended)
7. Click "Fire Selected" or "Quick Add"
8. Check backpack for duplicated items
9. Relog to verify persistence

### Advanced Usage
- Use "Rescan" to update remote/item lists
- Switch to "Remotes" mode for manual remote testing
- Monitor console for success/failure messages
- Use "Retry Last" if duplication fails

### Safety Notes
- Use sparingly to avoid detection
- Test persistence by relogging
- Don't duplicate same item multiple times rapidly
- Monitor for anti-cheat messages in console

## Known Issues

### Anti-Cheat Detection
- Game may detect rapid duplication
- Multiple instances of same item may trigger bans
- Server-side validation can fail

### Persistence Problems
- Items may not save if save remotes fail
- Relog required to verify persistence
- Some items may disappear on server restart

### Remote Changes
- Game updates may change remote names/locations
- Scripts may fail if _NetManaged path changes
- Manual rescanning required after updates

### UI Glitches
- Console may overflow with messages
- Island scanning may miss some areas
- Parameter inputs may not validate properly

## Development Tasks

### High Priority
- [ ] Update known item IDs for new game content
- [ ] Improve remote discovery reliability
- [ ] Add automatic anti-cheat detection
- [ ] Enhance persistence checking
- [ ] Implement tabbed UI interface (Remotes tab + Duping tab)
- [ ] Add complete item database to duping tab with amount selection
- [ ] Implement direct backpack addition with infinite stacking support

### Medium Priority
- [ ] Create unified script version
- [ ] Add item icon display in UI
- [ ] Implement bulk duplication
- [ ] Add script auto-updater

### Low Priority
- [ ] Cross-executor compatibility testing
- [ ] Performance optimization
- [ ] UI theme customization
- [ ] Mobile device support

## Future Plans

### Short Term (1-2 weeks)
- Consolidate scripts into single universal version
- Add more comprehensive item database
- Improve error handling and user feedback

### Medium Term (1-3 months)
- Automated game update detection
- Machine learning for remote pattern recognition
- Advanced anti-detection techniques

### Long Term (3+ months)
- Multi-game support (other Roblox games with similar mechanics)
- Web-based script generator
- Community contribution system

## Development History

### Major Milestones
- [ ] Initial script creation with basic duplication
- [ ] UI implementation for easier control
- [ ] Remote scanning and discovery features
- [ ] Island selection and targeting
- [ ] Persistence improvements
- [ ] Multiple script variants for different use cases

### Bug Fixes and Improvements
- [ ] Fixed remote path detection issues
- [ ] Improved error handling and logging
- [ ] Added anti-cheat detection warnings
- [ ] Enhanced UI responsiveness
- [ ] Better parameter validation
- [ ] Console overflow fixes

### Lessons Learned
- [x] Game updates frequently break remotes
- [x] Anti-cheat detection requires careful usage
- [x] Persistence testing is crucial
- [x] UI complexity vs. performance balance
- [x] **Item ID Mismatch Bug**: Attempting to dupe "The Divine Dao" (ID: 1860) after multiple shadow dupes resulted in receiving "Shipwreck Podium" (ID: 719) instead. The podium was permanent and fully functional (placeable, movable, breakable, sellable), unlike shadow dupes which are unusable. This suggests server-side item granting can substitute items when the requested ID fails validation.

*Note: This section needs to be populated with actual development history from conversations with AI assistants. Please provide details of past discussions, features added, bugs fixed, and progress made.*

## Context Notes

### Game Mechanics Understanding
- Islands game uses server-authoritative item management
- Remotes handle item granting, saving, and processing
- Client-side duplication exploits server validation gaps
- Persistence requires proper save remote firing

### Risk Assessment
- Low risk: Small amounts, infrequent use
- Medium risk: Large duplications, same session
- High risk: Multiple accounts, commercial use
- Ban types: Temporary, permanent, IP-based

### Development Philosophy
- Scripts should be user-friendly but powerful
- Prioritize safety over features
- Maintain compatibility across executors
- Document everything for future maintenance

### Maintenance Reminders
- Check for game updates weekly
- Test scripts after Roblox client updates
- Monitor community forums for new exploits
- Backup working scripts regularly

---

**Last Updated:** 2025-09-16
**Project Status:** Active Development
**Maintainer:** Joey