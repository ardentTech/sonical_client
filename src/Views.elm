module Views exposing (view)

import Html exposing (Html, button, div, table, tbody, td, text, thead, th, tr)
import Html.Attributes exposing (class, id, title)
import Html.Events exposing (onClick)
import List exposing (map)

import Messages exposing (Msg (NoOp))
import Models exposing (Driver, FrequencyResponse, Model)
import TypeConverters exposing (maybeNumToStr)
import Units exposing (decibels, hertz, ohms, watts)


view : Model -> Html Msg
view model = 
  div [ id "drivers" ] [
    table [ class "table table-responsive table-sm table-striped" ] [
      thead [] [ tableHeaderRow ],
      tbody [] (map tableBodyRow model.drivers)
    ],
    pagination model
  ]


-- PRIVATE

emptyHtml : Html Msg
emptyHtml =
  text ""

frequencyResponseCell : Driver -> Html Msg
frequencyResponseCell driver =
  let
    lower = maybeNumToStr <| driver.frequency_response.lower
    upper = maybeNumToStr <| driver.frequency_response.upper
    str = lower ++ "-" ++ upper ++ hertz
  in
    td [] [ text str ] 


manufacturerCell : Driver -> Html Msg
manufacturerCell driver =
  td [] [ text driver.manufacturer.name ]


modelCell : Driver -> Html Msg
modelCell driver =
  td [] [ text driver.model ]


nextPage : Model -> Html Msg
nextPage model =
  case model.driversNextPage of
    Nothing -> emptyHtml
    Just t -> button [ class "btn btn-secondary", onClick NoOp ] [ text "»" ]    


nominalImpedanceCell : Driver -> Html Msg
nominalImpedanceCell driver =
  let
    str = (maybeNumToStr driver.nominal_impedance) ++ ohms
  in
    td [] [ text str ]


pagination : Model -> Html Msg
pagination model =
  let
    prev = previousPage model
    next = nextPage model
  in
    div [ class "btn-group" ] [ prev, next ]


powerCell : Driver -> Html Msg
powerCell driver =
  let
    max_power = (maybeNumToStr driver.max_power) ++ watts
    rms_power = (maybeNumToStr driver.rms_power) ++ watts
    str = max_power ++ ", " ++ rms_power
  in
    td [ ] [ text str ]


previousPage : Model -> Html Msg
previousPage model =
  case model.driversPreviousPage of
    Nothing -> emptyHtml
    Just t -> button [ class "btn btn-secondary", onClick NoOp ] [ text "«" ]    


resonantFrequencyCell : Driver -> Html Msg
resonantFrequencyCell driver =
  let
    str = (maybeNumToStr driver.resonant_frequency) ++ hertz
  in
    td [] [ text str ]


sensitivityCell : Driver -> Html Msg
sensitivityCell driver =
  let
    str = (maybeNumToStr driver.sensitivity) ++ decibels
  in
    td [] [ text str ]


tableBodyRow : Driver -> Html Msg
tableBodyRow driver =
  let
    cells = [
      manufacturerCell,
      modelCell,
      nominalImpedanceCell,
      resonantFrequencyCell,
      frequencyResponseCell,
      sensitivityCell,
      powerCell
    ]
  in
    tr [] (map (\c -> c driver) cells)


tableHeaderRow : Html Msg
tableHeaderRow =
  tr [] [
    th [] [ text "Manufacturer" ],
    th [] [ text "Model" ],
    th [ title "Nominal Impedance" ] [ text "Z" ],
    th [ title "Resonant Frequency" ] [ text "Fs" ],
    th [] [ text "Sensitivity" ],
    th [ title "Frequency Response" ] [ text "Fr" ],
    th [ title "Max, RMS" ] [ text "Power"]
  ]
