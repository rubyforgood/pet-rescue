import { Session } from "./session";
export declare class Cache {
    readonly session: Session;
    constructor(session: Session);
    clear(): void;
    resetCacheControl(): void;
    exemptPageFromCache(): void;
    exemptPageFromPreview(): void;
    private setCacheControl;
}
