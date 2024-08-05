import { useRef } from "react";
import { useDragLayer } from "react-dnd";
import { imagePath } from "~/App";
import { DragSource } from "~/types";

const DragPreview: React.FC = () => {
    const ref = useRef<HTMLDivElement>(null);
    const { data, isDragging, coords } = useDragLayer<{ data: DragSource, isDragging: boolean, coords: { x: number, y: number } }>((monitor) => ({
        data: monitor.getItem(),
        isDragging: monitor.isDragging(),
        coords: monitor.getSourceClientOffset() || { x: 0, y: 0 }
    }));

    return (isDragging && data.item && coords) ?
        <div
            className="pointer-events-none select-none flex items-center gap-2 bg-primary-gray/60 min-h-[70px] w-[300px]"
            style={{
                position: 'absolute',
                top: coords.y,
                left: coords.x,
                zIndex: 100
            }}
        >
            <div className="flex items-center justify-center h-full w-32 relative bg-secondary-gray/60">
                <img src={`${imagePath}/${data.item.name}`} alt={data.item.name} className="h-[70px]" />
                <span className="text-sm absolute right-1 bottom-0 text-white/50">x{data.item.amount}</span>
            </div>
            <div className="flex flex-col">
                <span className="text-sm text-white">{data.item.label}</span>
                <span className="text-xs text-white/60">Weight: {data.item.weight / 1000}kg</span>
            </div>
        </div>
        : null;
};

export default DragPreview;