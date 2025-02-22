struct Value:
    var data: Float64
    var grad: Float64
    var _prev: List[Value]

    fn __init__(out self, data: Float64):
        self.data = data
        self.grad = 0.0
        self._prev = List[Value]()

    fn __init__(out self, data: Float64, _prev: List[Value]):
        self.data = data
        self.grad = 0.0
        self._prev = _prev

    fn __copyinit__(out self, existing: Self):
        self.data = existing.data
        self.grad = existing.grad
        self._prev = existing._prev

    fn __moveinit__(out self, owned existing: Self):
        self.data = existing.data
        self.grad = existing.grad
        self._prev = existing._prev^

    fn __add__(self, other: Self) -> Self:
        res = self.data + other.data
        return Value(res, List(self, other))

    fn write_to[W: Writer](self, mut writer: W):
        var string = "Value"
        writer.write_bytes(string.as_bytes())
        writer.write("(", self.data, ")")


fn print_list(prefix: StringLiteral, list: List[Value]):
    print(prefix, end=" ")
    for el in list:
        print(el[], end=", ")
    print("")


fn main():
    var a = Value(-4.0)
    var b = Value(2.0)
    var c = a + b

    print("a:", a)
    print("b:", b)
    print("c:", c)
    print_list("c._prev:", c._prev)
