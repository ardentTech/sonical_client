module Messages exposing (..)

import Navigation exposing (Location)

import Drivers.Messages
import Manufacturing.Messages


type Msg =
  ErrorDismissed |
  DriversMsg Drivers.Messages.Msg |
  ManufacturingMsg Manufacturing.Messages.Msg |
  NewUrl String |
  UrlChange Location
