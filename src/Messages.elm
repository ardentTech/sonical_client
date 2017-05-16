module Messages exposing (..)

import Http
import Navigation exposing (Location)
import Table

import Models exposing (Driver)
import Rest exposing (HttpListResponse)


type Msg =
  ErrorDismissed |
  Fail Http.Error |
  GetDriversDone (Result Http.Error (HttpListResponse Driver)) |
  NewUrl String |
  NextPageClicked |
  NoOp |
  PrevPageClicked |
  QueryBuilderCleared |
  QueryBuilderSubmitted |
  QueryBuilderUpdated String |
  SetTableState Table.State |
  UrlChange Location
