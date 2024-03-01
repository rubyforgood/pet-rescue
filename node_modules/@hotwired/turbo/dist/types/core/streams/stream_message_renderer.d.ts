import { StreamMessage } from "./stream_message";
import { BardoDelegate } from "../bardo";
export declare class StreamMessageRenderer implements BardoDelegate {
    render({ fragment }: StreamMessage): void;
    enteringBardo(currentPermanentElement: Element, newPermanentElement: Element): void;
    leavingBardo(): void;
}
