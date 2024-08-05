import React, { useEffect, useState } from 'react';
import { debugData } from '~/utils/debugData';
import { DEBUG_DATA } from './constants/debugData';
import Inventories from './components/Inventories';
import { isEnvBrowser } from './utils/misc';
import { useNuiEvent } from './hooks/useNuiEvent';
import { fetchNui } from './utils/fetchNui';
import Hotbar from './components/Hotbar';
import { InventoriesData, InventoryData, InventoryItem, Visibility } from './types';
import { useDragDropManager } from 'react-dnd';
import DragPreview from './components/dnd/DragPreview';
import { cn } from './utils/cn';
import debugImage from './assets/web_debug.png';

debugData(DEBUG_DATA);

export let hotbarSlots = 6;

export const emptyInventory: InventoryData = {
    type: '',
    title: '',
    name: '',
    maxWeight: 0,
    weight: 0,
    items: [],
};

const App: React.FC = () => {
    const dropManager = useDragDropManager();

    const [visibility, setVisibility] = useState<Visibility | null>(null);
    const [inventoriesData, setInventoriesData] = useState<InventoriesData>({
        playerInventory: emptyInventory,
        otherInventories: []
    });
    const [inventoriesTitle, setInventoriesTitle] = useState<string | undefined>(undefined);

    useNuiEvent('setVisibility', setVisibility);
    useNuiEvent('openInventory', setInventoriesData);
    useNuiEvent('closeInventory', () => {
        dropManager.dispatch({
            type: 'dnd-core/END_DRAG'
        });
    });

    useNuiEvent('load', (data: any) => {
        imagePath = data.imagePath || 'images';
        hotbarSlots = data.hotbarSlots || 6;

        setInventoriesTitle(data.inventoriesTitle);
        setInventoriesData(data.inventories);
    });

    useEffect(() => {
        fetchNui('loaded')
    }, []);

    useEffect(() => {
        if (visibility != Visibility.INVENTORIES) return;

        const keyHandler = (e: KeyboardEvent) => {
            if (['Escape'].includes(e.code)) {
                if (!isEnvBrowser()) fetchNui('close');
                else setVisibility(null);
            }
        };

        window.addEventListener('keydown', keyHandler);
        return () => window.removeEventListener('keydown', keyHandler);
    }, [visibility]);

    const moveItems = (dragIndex: number, hoverIndex: number, item: InventoryItem) => {
        console.log('moveItems', dragIndex, hoverIndex, item);
        const inventoryName = item.inventory;
        let inventory = inventoriesData.otherInventories.find((inv) => inv.name === inventoryName);
        if (!inventory) {
            if (inventoryName !== inventoriesData.playerInventory.name) return;

            inventory = inventoriesData.playerInventory;
        }

        const dragItem = inventory.items[dragIndex];
        const newItems = [...inventory.items];
        newItems.splice(dragIndex, 1);
        newItems.splice(hoverIndex, 0, dragItem);

        setInventoriesData({
            ...inventoriesData,
            playerInventory: inventoryName === inventoriesData.playerInventory.name ? { ...inventory, items: newItems } : inventoriesData.playerInventory,
            otherInventories: inventoryName !== inventoriesData.playerInventory.name ? inventoriesData.otherInventories.map((inv) => inv.name === inventoryName ? { ...inv, items: newItems } : inv) : inventoriesData.otherInventories
        });
    };

    return <div
        className='h-full w-full font-main'
        style={
            isEnvBrowser() ? {
                backgroundImage: `url(${debugImage})`,
            } : {}
        }
    >
        {visibility === Visibility.INVENTORIES ? <Inventories title={inventoriesTitle} inventoriesData={inventoriesData} moveItems={moveItems} /> : null}
        {(visibility === Visibility.HOTBAR || visibility === Visibility.INVENTORIES) ? <Hotbar playerInventory={inventoriesData.playerInventory} /> : null}
        <DragPreview />
    </div>
};

export default App;
