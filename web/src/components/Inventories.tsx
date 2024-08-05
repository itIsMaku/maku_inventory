import Inventory from "./Inventory";
import { InventoriesData, InventoryItem } from "~/types";
import { hotbarSlots } from "~/App";
import { cn } from "~/utils/cn";
interface InventoriesProps {
    title?: string;
    inventoriesData: InventoriesData;
    moveItems: (dragIndex: number, hoverIndex: number, item: InventoryItem) => void;
}

const getShortedInventory = (inventoryData: InventoriesData['playerInventory']) => {
    const shortSlots = hotbarSlots;
    const items = inventoryData.items.filter((item) => item.slot > shortSlots);
    return { ...inventoryData, items };
}

const Inventories: React.FC<InventoriesProps> = ({ title, inventoriesData, moveItems }) => {

    return <div className="flex flex-col gap-10">
        {title && <div className="flex justify-center">
            <h1 className="mt-5 text-2xl font-semibold text-white text-center border-b-2 border-opacity-60 border-white px-80">{title}</h1>
        </div>}
        <div className={cn(
            "flex gap-4 mx-20 select-none",
            !title && "mt-20"
        )}>
            <Inventory inventoryData={getShortedInventory(inventoriesData.playerInventory)} moveItems={moveItems} />
            {inventoriesData.otherInventories.map((inventory, index) => {
                return <Inventory key={index} inventoryData={inventory} moveItems={moveItems} />
            })}
        </div>
    </div>
}

export default Inventories;