module Messages exposing (..)

import Http
import Navigation exposing (Location)
import Table

import Drivers.Models exposing (Driver)
import Manufacturing.Messages
import Rest exposing (HttpListResponse)


-- @todo generic HttpRequestDone message instead of model-specific ones
type Msg =
  ErrorDismissed |
  Fail Http.Error |
  GetDriverDone (Result Http.Error Driver) |
  GetDriversDone (Result Http.Error (HttpListResponse Driver)) |
  ManufacturingMsg Manufacturing.Messages.Msg |
  NewUrl String |
  NextPageClicked |
  NoOp |
  PrevPageClicked |
  QueryBuilderCleared |
  QueryBuilderHelpClicked |
  QueryBuilderSubmitted |
  QueryBuilderUpdated String |
  SetTableState Table.State |
  UrlChange Location
