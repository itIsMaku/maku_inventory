import { useNuiEvent } from "~/hooks/useNuiEvent";
import Inventory from "./Inventory";
import { InventoriesData } from "~/types";
import { useState } from "react";
import { hotbarSlots } from "~/App";

interface InventoriesProps {
    inventoriesData: InventoriesData;
}

const getShortedInventory = (inventoryData: InventoriesData['playerInventory']) => {
    const shortSlots = hotbarSlots;
    const items = inventoryData.items.filter((item) => item.slot > shortSlots);
    return { ...inventoryData, items };
}

const Inventories: React.FC<InventoriesProps> = ({ inventoriesData }) => {
    return <div className="flex gap-4 h-full p-20 select-none">
        <Inventory inventoryData={getShortedInventory(inventoriesData.playerInventory)} />
        {inventoriesData.otherInventories.map((inventory, index) => {
            return <Inventory key={index} inventoryData={inventory} />
        })}
    </div>
}

export default Inventories;