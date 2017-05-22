module Router exposing (..)

import UrlParser exposing ((</>), (<?>), Parser, int, map, oneOf, s, intParam, top)


type Route = DriverList (Maybe Int) (Maybe Int) | DriverDetail Int | ManufacturerList


route : Parser (Route -> a) a
route =
  oneOf [
    map (DriverList Nothing Nothing) top,
    map DriverList (s "drivers" <?> intParam "limit" <?> intParam "offset"),
    map DriverDetail (s "drivers" </> int),
    map ManufacturerList (s "manufacturers")]
