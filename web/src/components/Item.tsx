import { imagePath } from "~/App";
import { InventoryItem } from "~/types";

interface ItemProps {
    item: InventoryItem;
}

const Item: React.FC<ItemProps> = ({ item }) => {
    return <div className="flex items-center gap-2 bg-primary-gray/60 min-h-20">
        <div className="flex items-center justify-center h-full w-32 relative bg-secondary-gray/60">
            <img src={`${imagePath}/${item.name}`} alt={item.name} className="h-16" />
            <span className="text-sm absolute right-1 bottom-0 text-white/50">x{item.amount}</span>
        </div>
        <div className="flex flex-col">
            <span className="text-sm text-white">{item.label}</span>
            <span className="text-xs text-white/60">Weight: {item.weight / 1000}kg</span>
        </div>
    </div>
};

export default Item;