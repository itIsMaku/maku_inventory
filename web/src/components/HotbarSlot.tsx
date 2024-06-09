import { imagePath } from "~/App";
import { InventoryItem } from "~/types";

interface HotbarSlotProps {
    slot: number;
    item: InventoryItem | null;
}

const HotbarSlot: React.FC<HotbarSlotProps> = ({ slot, item }) => {
    return <div key={slot} className="h-32 w-32 bg-secondary-gray/60">
        <div className="flex items-center justify-center h-full w-32 relative">
            {item ? <img src={`${imagePath}/${item.name}`} alt={item.name} className="h-24" /> : null}
            <span className="text-sm absolute right-1 bottom-0 text-white/50">{slot}</span>
        </div>

    </div>
}

export default HotbarSlot;