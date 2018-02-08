public final class Weak<Value: AnyObject> {
    public private(set) weak var value: Value?

    public init(_ value: Value) {
        self.value = value
    }
}
