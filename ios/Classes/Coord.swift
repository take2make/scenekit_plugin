class Coord {
    public let latitude: Float
    public let longitude: Float

    init(lat: Float, long: Float) {
        latitude = lat
        longitude = long
    }

    static func initFromParameters(params: Dictionary<String, Any>) -> Coord{
        return Coord(lat: (params["latitude"] as? Float)!, long: (params["longitude"] as? Float)!)
    }
}