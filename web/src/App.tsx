import React, { useEffect, useState } from 'react';
import { debugData } from '~/utils/debugData';
import { DEBUG_DATA } from './constants/debugData';
import Inventories from './components/Inventories';
import { isEnvBrowser } from './utils/misc';
import { useNuiEvent } from './hooks/useNuiEvent';
import { fetchNui } from './utils/fetchNui';

debugData(DEBUG_DATA);

export let imagePath = 'items';

const App: React.FC = () => {
    useNuiEvent('load', (data: any) => {
        imagePath = data.imagePath;
    });

    useEffect(() => {
        fetchNui('loaded')
    }, []);

    return <div className='h-full w-full font-main' style={
        isEnvBrowser() ? {
            backgroundImage: 'url(https://i.imgur.com/hbA4sX5.png)',
            backgroundSize: 'cover',
        } : {}}>
        <Inventories />
    </div>
};

export default App;
