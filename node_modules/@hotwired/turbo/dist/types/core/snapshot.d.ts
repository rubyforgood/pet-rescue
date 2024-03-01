export declare class Snapshot<E extends Element = Element> {
    readonly element: E;
    constructor(element: E);
    get activeElement(): Element | null;
    get children(): Element[];
    hasAnchor(anchor: string | undefined): boolean;
    getElementForAnchor(anchor: string | undefined): Element | null;
    get isConnected(): boolean;
    get firstAutofocusableElement(): Element | null;
    get permanentElements(): NodeListOf<Element>;
    getPermanentElementById(id: string): Element | null;
    getPermanentElementMapForSnapshot(snapshot: Snapshot): PermanentElementMap;
}
export declare function getPermanentElementById(node: ParentNode, id: string): Element | null;
export declare function queryPermanentElementsAll(node: ParentNode): NodeListOf<Element>;
export type PermanentElementMap = Record<string, [Element, Element]>;
