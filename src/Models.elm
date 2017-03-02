module Models exposing (Driver, Manufacturer, Model)


type alias Driver = {
  id : Int,
  manufacturer : Manufacturer,
  model : String,
  nominal_impedance : Maybe Int
}


type alias Manufacturer = {
  name : String,
  website : Maybe String
}


type alias Model = { drivers: List Driver }
