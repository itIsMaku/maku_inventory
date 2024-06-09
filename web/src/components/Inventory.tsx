import { InventoryData, InventoryItem } from "~/types";
import Item from "./Item";

interface InventoryProps {
    inventoryData: InventoryData;
}

const Inventory: React.FC<InventoryProps> = ({ inventoryData }) => {
    return <div className="flex flex-col w-[300px] gap-2">
        <div className="flex justify-center items-center border-b-2 border-yellow-500 text-white relative text-shadow-sm shadow-black">
            <span className="font-semibold">{inventoryData.title || '?'}</span>
            <span className="text-sm absolute right-0">{inventoryData.weight / 1000}kg/{inventoryData.maxWeight / 1000}kg</span>
        </div>
        <div className="flex flex-col gap-1 max-h-[840px] overflow-y-auto">
            {inventoryData.items.map((item, index) => <Item key={index} item={item} />)}
        </div>
    </div>
};

export default Inventory;