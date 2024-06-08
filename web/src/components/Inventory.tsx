import { InventoryData, InventoryItem } from "~/types";

interface InventoryProps {
    inventoryData: InventoryData;
}

const Inventory: React.FC<InventoryProps> = ({ inventoryData }) => {
    return <div className="flex flex-col w-[400px] gap-2">
        <div className="flex justify-center items-center border-b-2 border-yellow-500 text-white relative text-shadow-sm shadow-black">
            <span className="font-semibold">{inventoryData.title || '?'}</span>
            <span className="text-sm absolute right-0">{inventoryData.weight / 1000}kg/{inventoryData.maxWeight / 1000}kg</span>
        </div>
        <div className="flex flex-col gap-1 max-h-[840px] overflow-y-auto">
            {inventoryData.items.map((item, index) => {
                return <div key={index} className="flex items-center gap-2 bg-primary-gray/60 min-h-20">
                    <div className="flex items-center justify-center h-full w-32 relative bg-secondary-gray/60">
                        <img src={`https://api.tror.eu/inventory/${item.name}`} alt={item.name} className="h-16" />
                        <span className="text-sm absolute right-1 bottom-0 text-white/50">x{item.amount}</span>
                    </div>
                    <div className="flex flex-col">
                        <span className="text-sm text-white">{item.label}</span>
                        <span className="text-xs text-white/60">Weight: {item.weight / 1000}kg</span>
                    </div>
                </div>
            })}
        </div>
    </div>
};

export default Inventory;