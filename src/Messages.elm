module Messages exposing (..)

import Http
import Navigation exposing (Location)
import Table

import Models exposing (Driver)
import Rest exposing (HttpListResponse)


type Msg =
  ErrorDismissed |
  Fail Http.Error |
  GetDriverDone (Result Http.Error Driver) |
  GetDriversDone (Result Http.Error (HttpListResponse Driver)) |
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
