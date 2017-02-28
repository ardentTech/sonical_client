module Messages exposing (..)

import Http

import Models exposing (Driver)


type Msg = Fail Http.Error | FetchDriversDone (Result Http.Error (List Driver)) | NoOp
