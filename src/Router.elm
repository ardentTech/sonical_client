module Router exposing (..)

import UrlParser exposing ((</>), Parser, int, map, oneOf, s, top)


type Route = DriverList | DriverDetail Int


route : Parser (Route -> a) a
route =
  oneOf [
    map DriverList top,
    map DriverDetail (s "drivers" </> int)]
