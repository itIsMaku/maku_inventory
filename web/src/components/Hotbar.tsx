import { hotbarSlots } from "~/App";
import HotbarSlot from "./HotbarSlot";
import { InventoryData } from "~/types";

interface HotbarProps {
    playerInventory: InventoryData
}

const getSlotItem = (slot: number, items: InventoryData['items']) => {
    return items.find((item) => item.slot === slot) || null;
}

const Hotbar: React.FC<HotbarProps> = ({ playerInventory }) => {
    return <div className="flex items-center justify-center absolute bottom-5 right-0 left-0">
        <div className="flex flex-row items-center justify-center gap-1 bg-primary-gray/60 p-1">
            {Array.from({ length: hotbarSlots }).map((_, index) => {
                const slot = index + 1;
                const item = getSlotItem(slot, playerInventory.items);
                return <HotbarSlot key={slot} slot={slot} item={item} />
            })}
        </div>
    </div>
}

export default Hotbar;