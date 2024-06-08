export type InventoriesData = {
    playerInventory: InventoryData;
    otherInventories: InventoryData[];
};

export interface InventoryItem {
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