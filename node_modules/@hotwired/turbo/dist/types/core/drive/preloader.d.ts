import { Navigator } from "./navigator";
import { SnapshotCache } from "./snapshot_cache";
export interface PreloaderDelegate {
    readonly navigator: Navigator;
}
export declare class Preloader {
    readonly delegate: PreloaderDelegate;
    readonly selector: string;
    constructor(delegate: PreloaderDelegate);
    get snapshotCache(): SnapshotCache;
    start(): void;
    preloadOnLoadLinksForView(element: Element): void;
    preloadURL(link: HTMLAnchorElement): Promise<void>;
}
