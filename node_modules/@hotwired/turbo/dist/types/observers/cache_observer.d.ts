export declare class CacheObserver {
    readonly selector: string;
    readonly deprecatedSelector: string;
    started: boolean;
    start(): void;
    stop(): void;
    removeTemporaryElements: EventListener;
    get temporaryElements(): Element[];
    get temporaryElementsWithDeprecation(): Element[];
}
