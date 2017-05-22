module Router exposing (..)

import UrlParser exposing ((</>), (<?>), Parser, int, map, oneOf, s, stringParam, top)


type Route = DriverList (Maybe String) | DriverDetail Int | ManufacturerList


route : Parser (Route -> a) a
route =
  oneOf [
    map (DriverList Nothing) top,
    map DriverList (s "drivers" <?> stringParam "limit"),
    map DriverDetail (s "drivers" </> int),
    map ManufacturerList (s "manufacturers")]
