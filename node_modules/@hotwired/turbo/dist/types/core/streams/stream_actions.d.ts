import { StreamElement } from "../../elements/stream_element";
export type TurboStreamAction = (this: StreamElement) => void;
export type TurboStreamActions = {
    [action: string]: TurboStreamAction;
};
export declare const StreamActions: TurboStreamActions;
