import React, { useEffect, useState } from 'react';
import { debugData } from '~/utils/debugData';
import { DEBUG_DATA } from './constants/debugData';
import Inventories from './components/Inventories';
import { isEnvBrowser } from './utils/misc';
import { useNuiEvent } from './hooks/useNuiEvent';
import { fetchNui } from './utils/fetchNui';
import Hotbar from './components/Hotbar';
import { InventoriesData } from './types';

debugData(DEBUG_DATA);

export let imagePath = 'images';
export let hotbarSlots = 6;

const App: React.FC = () => {
    const [inventoriesData, setInventoriesData] = useState<InventoriesData | null>(null);
    const [showHotbar, setShowHotbar] = useState<boolean>(true);

    useNuiEvent('openInventory', setInventoriesData);
    useNuiEvent('closeInventory', () => setInventoriesData(null));


    useNuiEvent('load', (data: any) => {
        imagePath = data.imagePath || 'images';
        hotbarSlots = data.hotbarSlots || 6;
    });

    useEffect(() => {
        fetchNui('loaded')
    }, []);

    return <div className='h-full w-full font-main' style={
        isEnvBrowser() ? {
            backgroundImage: 'url(https://i.imgur.com/hbA4sX5.png)',
            backgroundSize: 'cover',
        } : {}}>
        {inventoriesData ? <Inventories inventoriesData={inventoriesData} /> : null}
        {(showHotbar && inventoriesData?.playerInventory) ? <Hotbar playerInventory={inventoriesData.playerInventory} /> : null}
    </div>
};

export default App;
