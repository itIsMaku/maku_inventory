import { useNuiEvent } from "~/hooks/useNuiEvent";
import Inventory from "./Inventory";
import { InventoriesData } from "~/types";
import { useState } from "react";

interface InventoriesProps { }

const Inventories: React.FC = () => {
    const [inventoriesData, setInventoriesData] = useState<InventoriesData | null>(null);

    useNuiEvent('openInventory', setInventoriesData);

    return inventoriesData ? <div className="flex gap-4 h-full p-20 select-none">
        <Inventory inventoryData={inventoriesData.playerInventory} />
        {inventoriesData.otherInventories.map((inventory, index) => {
            return <Inventory key={index} inventoryData={inventory} />
        })}
    </div> : null;
}

export default Inventories;