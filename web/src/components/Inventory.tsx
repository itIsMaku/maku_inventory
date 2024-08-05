import { DragSource, InventoriesData, InventoryData, InventoryItem } from "~/types";
import Item from "./Item";
import { useDrop } from "react-dnd";
import { useCallback, useState } from "react";

interface InventoryProps {
    inventoryData: InventoryData;
    moveItems: (dragIndex: number, hoverIndex: number, item: InventoryItem) => void;
}

const getSortedBySlots = (items: InventoryItem[]) => {
    return items.sort((a, b) => a.slot - b.slot);
}

const Inventory: React.FC<InventoryProps> = ({ inventoryData, moveItems }) => {
    const [searchQuery, setSearchQuery] = useState('');

    const handleInput = (e: React.ChangeEvent<HTMLInputElement>) => {
        setSearchQuery(e.target.value);
    }

    return <div className="flex flex-col w-[350px]">
        <div className="flex justify-between items-center text-white relative text-shadow-sm shadow-black">
            <span className="font-semibold uppercase">{inventoryData.title || '?'}</span>
            <input
                type="text"
                placeholder={'Search'}
                className="bg-black/20 w-40 placeholder-white/25 px-[4px] text-sm text-white/75 focus-within:text-white outline-none"
                value={searchQuery}
                onChange={handleInput}
            />
            <span className="text-sm">{inventoryData.weight / 1000}kg/{inventoryData.maxWeight / 1000}kg</span>
        </div>
        <div className="mt-[2px] border-b-4 border-yellow-400"></div>
        <div className="flex flex-col gap-1 h-[840px] overflow-y-auto"
            style={{
            }}
        >
            {getSortedBySlots(inventoryData.items)
                .filter((item) => item.label.toLowerCase().includes(searchQuery.toLowerCase()))
                .map((item, index) => {
                    return <Item key={index} inventoryType={inventoryData.type} item={item} moveItems={moveItems} />
                })}
        </div>
    </div>
};

export default Inventory;