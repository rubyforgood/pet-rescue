export declare class DOMTestCase {
    fixtureElement: HTMLElement;
    setup(): Promise<void>;
    teardown(): Promise<void>;
    append(node: Node): void;
    find(selector: string): Element | null;
    get fixtureHTML(): string;
    set fixtureHTML(html: string);
}
