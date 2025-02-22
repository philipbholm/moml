@value
struct Value:
    var data: Float64
    var grad: Float64
    var _prev: List[Value]
