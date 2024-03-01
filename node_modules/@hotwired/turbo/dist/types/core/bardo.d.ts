import { PermanentElementMap } from "./snapshot";
export interface BardoDelegate {
    enteringBardo(currentPermanentElement: Element, newPermanentElement: Element): void;
    leavingBardo(currentPermanentElement: Element): void;
}
export declare class Bardo {
    readonly permanentElementMap: PermanentElementMap;
    readonly delegate: BardoDelegate;
    static preservingPermanentElements(delegate: BardoDelegate, permanentElementMap: PermanentElementMap, callback: () => void): Promise<void>;
    constructor(delegate: BardoDelegate, permanentElementMap: PermanentElementMap);
    enter(): void;
    leave(): void;
    replaceNewPermanentElementWithPlaceholder(permanentElement: Element): void;
    replaceCurrentPermanentElementWithClone(permanentElement: Element): void;
    replacePlaceholderWithPermanentElement(permanentElement: Element): void;
    getPlaceholderById(id: string): HTMLMetaElement | undefined;
    get placeholders(): HTMLMetaElement[];
}
