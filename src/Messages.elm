module Messages exposing (..)

import Http
import Table

import Models exposing (HttpResponse)


type Msg =
  Fail Http.Error |
  GetDriversDone (Result Http.Error HttpResponse) |
  NextPageClicked |
  NoOp |
  PrevPageClicked |
  SetDriversQuery String |
  SetTableState Table.State
