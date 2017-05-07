module Views.Table exposing (appendUnit, manufacturerColumn, maybeFloatColumn, maybeIntColumn)

import Table

import Messages exposing (Msg)
import Models exposing (Driver)
import TypeConverters exposing (maybeFloatToFloat, maybeIntToInt)


manufacturerColumn : Table.Column Driver Msg
manufacturerColumn =
  Table.stringColumn "Manufacturer" ((\m -> m.name) << .manufacturer)

maybeFloatColumn : String -> (Driver -> Maybe Float) -> String -> Table.Column Driver Msg
maybeFloatColumn name toData unit =
  let
    data = maybeFloatToFloat << toData
    formatData = (\d -> if d > 0 then (appendUnit d unit) else "-")
    vData = (\v -> formatData (data v))
  in
    Table.customColumn {
      name = name,
      viewData = vData,
      sorter = Table.increasingOrDecreasingBy data 
    }

maybeIntColumn : String -> (Driver -> Maybe Int) -> String -> Table.Column Driver Msg
maybeIntColumn name toData unit =
  let
    data = maybeIntToInt << toData
    formatData = (\d -> if d > 0 then (appendUnit d unit) else "-")
    vData = (\v -> formatData (data v))
  in
    Table.customColumn {
      name = name,
      viewData = vData,
      sorter = Table.increasingOrDecreasingBy data 
    }


appendUnit : number -> String -> String
appendUnit n unit =
  (toString n) ++ " " ++ unit
