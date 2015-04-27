package plda.prolog.typeclasses

object Main extends App {
  import Test.configJson
  import Test.configJson2
  
  val config = Config("localhost", 8080)
  Network.sendOver(config)
}

object Network {
  //def sendOver[T](t: T)(implicit json : JsonSerialization) = {
//  json.toJson(t)
//}
  def sendOver[T: JsonSerialization](t: T) = {
    println {
      implicitly[JsonSerialization[T]].toJson(t)
    }
  }
}