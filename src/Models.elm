module Models exposing (Driver, FrequencyResponse, Manufacturer, Model)


type alias Driver = {
  frequency_response : FrequencyResponse,
  id : Int,
  manufacturer : Manufacturer,
  model : String,
  nominal_impedance : Maybe Int,
  resonant_frequency : Maybe Float,
  sensitivity : Maybe Float
}


type alias FrequencyResponse = {
  lower : Maybe Int,
  upper : Maybe Int
}


type alias Manufacturer = {
  name : String,
  website : Maybe String
}


type alias Model = { drivers: List Driver }
