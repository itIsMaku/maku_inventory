import { imagePath } from "~/App";
import { DragSource, InventoryData, InventoryItem } from "~/types";
import { XYCoord, useDrag, useDrop } from 'react-dnd';
import { useRef } from "react";

interface ItemProps {
    inventoryType: InventoryData['type'];
    item: InventoryItem;
    moveItems: (dragIndex: number, hoverIndex: number, item: InventoryItem) => void;
}

const Item: React.FC<ItemProps> = ({ inventoryType, item, moveItems }) => {
    const ref = useRef<HTMLDivElement>(null)

    const [{ isOver }, drop] = useDrop<DragSource, void, { isOver: boolean }>(
        () => ({
            accept: 'inventory_slot',
            collect: (monitor) => ({
                isOver: monitor.isOver(),
            }),
            hover: (data, monitor) => {
                if (data.item === undefined || data.item == null) return;
                const item = data.item;
                const dragIndex = item.slot;
                const hoverIndex = item.slot;

                if (dragIndex === hoverIndex) return;

                const hoverBoundingRect = ref.current?.getBoundingClientRect();
                if (hoverBoundingRect === undefined || hoverBoundingRect === null) return;

                const hoverMiddleY = (hoverBoundingRect.bottom - hoverBoundingRect.top) / 2;
                const clientOffset = monitor.getClientOffset();
                const hoverClientY = (clientOffset as XYCoord).y - hoverBoundingRect.top;
                if (dragIndex < hoverIndex && hoverClientY < hoverMiddleY) return;

                if (dragIndex > hoverIndex && hoverClientY > hoverMiddleY) return;

                moveItems(dragIndex, hoverIndex, item)

                data.item.slot = hoverIndex
            },
            canDrop: (source) => {
                return true;
            }
        }),
        []
    );

    const [{ isDragging }, drag] = useDrag<DragSource, void, { isDragging: boolean }>(
        () => ({
            type: 'inventory_slot',
            collect: (monitor) => ({
                isDragging: monitor.isDragging(),
            }),
            item: () => {
                return {
                    inventoryName: inventoryType,
                    item: item
                };
            }
        }),
        [item]
    );
    drag(drop(ref));
    return <div ref={ref}>
        {!isDragging ? (
            <div className="flex items-center gap-2 bg-primary-gray/60 min-h-[70px]">
                <div className="flex items-center justify-center h-full w-32 relative bg-secondary-gray/60">
                    <img src={`${imagePath}/${item.name}`} alt={item.name} className="h-[70px] select-none" />
                    <span className="text-sm absolute right-1 bottom-0 text-white/50">x{item.amount}</span>
                </div>
                <div className="flex flex-col">
                    <span className="text-sm text-white">{item.label}</span>
                    <span className="text-xs text-white/60">Weight: {item.weight / 1000}kg</span>
                </div>
            </div>) : null}
    </div>
};

export default Item;

