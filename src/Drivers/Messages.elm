module Drivers.Messages exposing (..)

import Http
import Table

import Drivers.Models exposing (Driver)
import Rest exposing (HttpListResponse)


type Msg =
  GetDriverDone (Result Http.Error Driver) |
  GetDriversDone (Result Http.Error (HttpListResponse Driver)) |
  NewUrl String |
  NextPageClicked |
  PrevPageClicked |
  QueryBuilderCleared |
  QueryBuilderHelpClicked |
  QueryBuilderSubmitted |
  QueryBuilderUpdated String |
  SetTableState Table.State
