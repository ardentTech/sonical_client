module Router exposing (..)

import UrlParser exposing ((</>), Parser, int, map, oneOf, s, top)


type Route = DriverList | DriverDetail Int | ManufacturerList


route : Parser (Route -> a) a
route =
  oneOf [
    map DriverList top,
    map DriverList (s "drivers"),
    map DriverDetail (s "drivers" </> int),
    map ManufacturerList (s "manufacturers")]
