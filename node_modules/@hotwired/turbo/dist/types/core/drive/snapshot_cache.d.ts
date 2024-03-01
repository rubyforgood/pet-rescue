import { PageSnapshot } from "./page_snapshot";
export declare class SnapshotCache {
    readonly keys: string[];
    readonly size: number;
    snapshots: {
        [url: string]: PageSnapshot;
    };
    constructor(size: number);
    has(location: URL): boolean;
    get(location: URL): PageSnapshot | undefined;
    put(location: URL, snapshot: PageSnapshot): PageSnapshot;
    clear(): void;
    read(location: URL): PageSnapshot;
    write(location: URL, snapshot: PageSnapshot): void;
    touch(location: URL): void;
    trim(): void;
}
