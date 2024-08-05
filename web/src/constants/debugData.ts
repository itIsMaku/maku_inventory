import { Visibility } from "~/types";

export const DEBUG_DATA = [
    {
        action: 'setVisible',
        data: true
    },
    {
        action: 'setVisibility',
        data: Visibility.INVENTORIES
    },
    {
        action: 'openInventory',
        data: {
            playerInventory: {
                type: 'player',
                title: 'Player',
                name: 'char1:d983f8f701e37ac87c9ba7e04c7759215e1efe32',
                maxWeight: 30000,
                weight: 70,
                items: [
                    {
                        name: 'weapon_pistol',
                        id: 1,
                        label: 'Pistol',
                        amount: 1,
                        slot: 7,
                        weight: 10,
                        data: {}
                    },
                    {
                        name: 'weapon_pistol',
                        label: 'Pistol',
                        amount: 1,
                        id: 2,
                        slot: 2,
                        weight: 10,
                        data: {}
                    },
                    {
                        name: 'weapon_pistol',
                        label: 'Pistol',
                        amount: 1,
                        id: 3,
                        slot: 3,
                        weight: 10,
                        data: {}
                    },
                    {
                        name: 'cash',
                        label: 'Cash',
                        amount: 1,
                        slot: 4,
                        id: 4,
                        weight: 10,
                        data: {}
                    },
                    {
                        name: 'gameboy',
                        label: 'Gameboy',
                        amount: 1,
                        slot: 5,
                        id: 5,
                        weight: 50,
                        data: {}
                    },
                    {
                        name: 'weapon_rpg',
                        label: 'RPG',
                        amount: 1,
                        slot: 6,
                        id: 6,
                        weight: 50,
                        data: {}
                    },
                    {
                        name: 'gameboy',
                        label: 'Gameboy',
                        amount: 1,
                        slot: 9,
                        id: 7,
                        weight: 50,
                        data: {}
                    },
                    {
                        name: 'gameboy',
                        label: 'Gameboy',
                        amount: 1,
                        slot: 8,
                        id: 8,
                        weight: 50,
                        data: {}
                    },
                    {
                        name: 'weapon_assaultrifle',
                        label: 'AK47',
                        amount: 1,
                        slot: 1,
                        id: 9,
                        weight: 50,
                        data: {}
                    },
                ]
            },
            otherInventories: [
                {
                    type: 'trunk',
                    title: 'Trunk',
                    name: 'ABC123',
                    maxWeight: 50000,
                    weight: 1800,
                    items: [
                        {
                            name: 'weapon_carbinerifle',
                            label: 'Carbine Rifle',
                            amount: 1,
                            id: 11,
                            slot: 1,
                            weight: 500,
                            data: {}
                        },
                        {
                            name: '9mm250',
                            label: 'Náboje 9mm (250)',
                            amount: 1,
                            id: 13,
                            slot: 2,
                            weight: 1300,
                            data: {}
                        }
                    ]
                },
                {
                    type: 'stash',
                    title: 'Storage',
                    name: 'Police Evidence',
                    maxWeight: 100000,
                    weight: 300,
                    items: [
                        {
                            name: 'bread',
                            label: 'Bread',
                            id: 15,
                            amount: 1,
                            slot: 1,
                            weight: 300,
                            data: {}
                        },
                    ]
                }
            ]
        } as any
    }
];
