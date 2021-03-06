module Messages exposing (..)

import Navigation exposing (Location)

import Drivers.Messages
import Manufacturing.Messages


type Msg =
  ErrorDismissed |
  DriversMsg Drivers.Messages.InternalMsg |
  ManufacturingMsg Manufacturing.Messages.InternalMsg |
  NewUrl String |
  UrlChange Location


childTranslator : Manufacturing.Messages.Translator Msg
childTranslator =
  Manufacturing.Messages.translator { onInternalMessage = ManufacturingMsg }


driversTranslator : Drivers.Messages.Translator Msg
driversTranslator =
  Drivers.Messages.translator {
    onInternalMessage = DriversMsg,
    onNewUrl = NewUrl
  }
