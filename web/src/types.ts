export type InventoriesData = {
    playerInventory: InventoryData;
    otherInventories: InventoryData[];
};

export interface InventoryItem {
    inventory: string;
    id: string;
    name: string;
    label: string;
    amount: number;
    slot: number;
    weight: number;
    data: {};
}

export interface InventoryData {
    type: string;
    title: string;
    name: string;
    maxWeight: number;
    weight: number;
    items: InventoryItem[];
}

export interface DragSource {
    inventoryName: string;
    item: InventoryItem | null;
}

export enum Visibility {
    INVENTORIES = 'inventories',
    HOTBAR = 'hotbar',
}
