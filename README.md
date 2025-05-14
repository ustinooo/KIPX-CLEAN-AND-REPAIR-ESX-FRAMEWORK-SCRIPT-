📦 kipxcleanandrepair - Installation Guide

Author: kipx
Description: Adds vehicle repair and cleaning kit functionality with progress bars and animations.

🔁 Requirements

✅ ESX (1.8+, legacy, or extendedmode) or
✅ QBCore (latest) or
✅ ox_inventory
✅ ox_lib (required for notifications & progress bars)

📁 Files Overview

kipxcleanandrepair/
├── fxmanifest.lua
├── client.lua
├── server.lua
└── README.md (this file)

⚙️ Installation Steps

1. 📥 Add the Script
Place the kipxcleanandrepair folder into your resources directory.
2. 🧩 Add to server.cfg or resources.cfg

ensure ox_lib
ensure kipxcleanandrepair

📌 Item Setup

Depending on your framework and inventory, follow the correct section below:

🧰 A. ox_inventory Installation

1. Edit ox_inventory/data/items.lua
Add the following:


['repairkit'] = {
    label = 'Repair Kit',
    weight = 1000,
    description = 'Used to repair vehicles'
},

['cleaningkit'] = {
    label = 'Cleaning Kit',
    weight = 500,
    description = 'Used to clean vehicles'
},

🧰 B. ESX Installation

Option 1: Using shared/items.lua
Edit es_extended/shared/items.lua and add:

['repairkit'] = {
    label = 'Repair Kit',
    weight = 1000,
    rare = false,
    canRemove = true,
    description = 'Used to repair vehicles'
},

['cleaningkit'] = {
    label = 'Cleaning Kit',
    weight = 500,
    rare = false,
    canRemove = true,
    description = 'Used to clean vehicles'
},

Option 2: Using SQL
If you're not using shared/items.lua, execute this SQL:

INSERT INTO items (name, label, weight) VALUES
('repairkit', 'Repair Kit', 1),
('cleaningkit', 'Cleaning Kit', 1);

🧰 C. QBCore Installation

1. Edit qb-core/shared/items.lua
Add the following:

['repairkit'] = {
    name = 'repairkit',
    label = 'Repair Kit',
    weight = 1000,
    type = 'item',
    image = 'repairkit.png',
    unique = false,
    useable = true,
    shouldClose = true,
    combinable = nil,
    description = 'Used to repair vehicles'
},

['cleaningkit'] = {
    name = 'cleaningkit',
    label = 'Cleaning Kit',
    weight = 500,
    type = 'item',
    image = 'cleaningkit.png',
    unique = false,
    useable = true,
    shouldClose = true,
    combinable = nil,
    description = 'Used to clean vehicles'
},

🔄 How to Use

Use a repair kit or cleaning kit from your inventory.
A progress bar will appear with animations.
After the animation completes:
repairkit repairs vehicle
cleaningkit cleans dirt and decals
Item is removed automatically after use.

🔔 Notifications

This script uses lib.notify for notifications.

Make sure ox_lib is started before this script.

💡 Cooldown Support

A cooldown system can be added with a simple timer to prevent repeated use. If you want that included, 
let me know and I’ll update the code with a working cooldown.

