import { useDrag } from "react-dnd";
import { imagePath } from "~/App";
import { DragSource, InventoryItem } from "~/types";

interface HotbarSlotProps {
    slot: number;
    item: InventoryItem | null;
}

const HotbarSlot: React.FC<HotbarSlotProps> = ({ slot, item }) => {
    const [{ isDragging }, drag] = useDrag<DragSource, void, { isDragging: boolean }>(
        () => ({
            type: 'inventory_slot',
            collect: (monitor) => ({
                isDragging: monitor.isDragging(),
            }),
            item: () => {
                return {
                    inventoryName: 'playerInventory',
                    item: item
                };
            }
        }),
        [item]
    );

    return <div ref={drag}>
        <div key={slot} className="h-28 w-28 bg-secondary-gray/60">
            <div className="flex items-center justify-center h-full w-28 relative">
                {(!isDragging && item) ? <img src={`${imagePath}/${item.name}`} alt={item.name} className="h-24" /> : null}
                <span className="text-sm absolute right-1 bottom-0 text-white/50">{slot}</span>
            </div>
        </div>
    </div>
}

export default HotbarSlot;