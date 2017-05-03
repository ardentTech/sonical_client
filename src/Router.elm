module Router exposing (Route, route)

import UrlParser exposing ((</>), Parser, int, map, oneOf, s)


type Route = DriverList | DriverDetail Int


route : Parser (Route -> a) a
route =
  oneOf [
    -- @todo might need to use 'top' here...
    map DriverList (s "drivers"),
    map DriverDetail (s "drivers" </> int)]
