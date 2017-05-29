module DriverGroups.Models exposing (DriverGroup)

import Drivers.Models exposing (Driver)


type alias DriverGroup = {
  drivers : List Driver,
  name : String
}
