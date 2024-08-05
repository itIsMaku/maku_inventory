// Will return whether the current environment is in a regular browser

import { InventoryItem } from "~/types";

// and not CEF
export const isEnvBrowser = (): boolean => !(window as any).invokeNative;

// Basic no operation function
export const noop = () => { };

export const isSlotOccupied = (items: InventoryItem[], slot: number): boolean => {
    return items.some((item) => item.slot === slot);
}