import { StreamSource } from "../core/types";
export declare class StreamSourceElement extends HTMLElement {
    streamSource: StreamSource | null;
    connectedCallback(): void;
    disconnectedCallback(): void;
    get src(): string;
}
