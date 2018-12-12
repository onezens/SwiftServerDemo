import Vapor

let app = try Application()
let router = try app.make(Router.self)



struct PublicUser: Content {
    var id: Int
    var email: String
}

struct User: Content {
    var name: String
    var email: String?
}

struct List: Content {
    var page: Int?
    var size: Int?
}

//plain
router.get("hello") { req in
    return "Hello, world."
}

//query
router.get("list"){ req -> [String: String] in
    let flags = try req.query.decode(List.self)
    let page = flags.page ?? 0
    let size = flags.size ?? 0
    
    return [
        "page": String(page),
        "size": String(size)
    ]
}

//json
router.post("hello") { req in
    return PublicUser(id: 10, email: "123@qq.com")
}

//json
router.post(User.self, at: "user"){ req,u -> [String: String] in
    print("[User] \(req.parameters)")
    print("[User] \(u)")
    let name:[String: String] = [
        "name": u.name,
        "email": u.email ?? ""
    ]
    return  name
}


try app.run()
