import Dispatch

public final class Lazy<Value> {
    private let semaphore = DispatchSemaphore(value: 1)

    private let create: () -> Value

    public private(set) lazy var value: Value = { [unowned self] in
        self.semaphore.wait(); defer { self.semaphore.signal() }
        return self.create()
    }()

    public init(_ create: @autoclosure @escaping () -> Value) {
        self.create = create
    }
}