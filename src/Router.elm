module Router exposing (..)

import UrlParser exposing ((</>), Parser, int, map, oneOf, s)


type Route = DriverList | DriverDetail Int


route : Parser (Route -> a) a
route =
  oneOf [
    -- @todo might need to use 'top' here...
    map DriverDetail (s "drivers" </> int),
    map DriverList (s "drivers")]
