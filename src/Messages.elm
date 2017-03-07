module Messages exposing (..)

import Http

import Models exposing (HttpResponse)


type Msg =
  Fail Http.Error |
  FetchDriversDone (Result Http.Error HttpResponse) |
  NextPageClicked |
  NoOp |
  PrevPageClicked
