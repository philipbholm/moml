from memory import UnsafePointer

struct Value:
    var data: Float64
    var grad: Float64
    var _prev: List[Value]
    var _op: String

    fn __init__(out self, data: Float64):
        self.data = data
        self.grad = 0.0
        self._prev = List[Value]()
        self._op = String("")

    fn __init__(out self, data: Float64, _prev: List[Value], _op: String):
        self.data = data
        self.grad = 0.0
        self._prev = _prev
        self._op = _op

    fn __copyinit__(out self, existing: Self):
        self.data = existing.data
        self.grad = existing.grad
        self._prev = existing._prev
        self._op = existing._op

    fn __moveinit__(out self, owned existing: Self):
        self.data = existing.data
        self.grad = existing.grad
        self._prev = existing._prev^
        self._op = existing._op^

    fn __add__(self, other: Self) -> Self:
        res = self.data + other.data
        return Value(res, List(self, other), String("+"))

    fn backward(mut self):
        self.grad = 1.0

        for child in self._prev:
            if self._op == "+":
                ptr = UnsafePointer.address_of(child[].grad)
                ptr.store(1.0)

    fn write_to[W: Writer](self, mut writer: W):
        var string = "Value"
        writer.write_bytes(string.as_bytes())
        writer.write("(data=", self.data, ", grad=", self.grad, ")")


fn print_list(prefix: StringLiteral, list: List[Value]):
    print(prefix, end=" ")
    for el in list:
        print(el[], end=", ")
    print("")


fn main():
    var a = Value(-4.0)
    var b = Value(2.0)
    var c = a + b
    c.backward()

    print("a:", a)
    print("b:", b)
    print("c:", c)
    # print_list("c._prev:", c._prev)
