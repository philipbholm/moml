struct Value(CollectionElement):
    var data: Float64
    var grad: Float64
    # var _backward: fn() -> None
    var _prev: List[Value]

    fn __init__(out self, data: Float64, _children: List[Value]):
        self.data = data
        self.grad = 0
        # self._backward = lambda: None
        self._prev = _children

    fn __moveinit__(mut self, owned existing: Self):
        self.data = existing.data
        self.grad = existing.grad
        self._prev = existing._prev^

    fn __copyinit__(out self, existing: Self):
        self.data = existing.data
        self.grad = existing.grad
        self._prev = existing._prev
