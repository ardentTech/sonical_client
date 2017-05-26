module Manufacturing.Models exposing (Manufacturer, Material)


type alias Manufacturer = {
  id : Int,
  name : String,
  website : String
}


type alias Material = {
  id : Int,
  name : String
}
