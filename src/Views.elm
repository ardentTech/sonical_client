module Views exposing (view)

import Html exposing (Html, button, div, table, tbody, td, text, thead, th, tr)
import Html.Attributes exposing (class, disabled, id, title)
import Html.Events exposing (onClick)
import List exposing (map, length)

import Messages exposing (Msg (NextPageClicked, PrevPageClicked))
import Models exposing (Driver, FrequencyResponse, Model)
import TypeConverters exposing (maybeNumToStr)
import Units exposing (decibels, hertz, ohms, watts)


view : Model -> Html Msg
view model = 
  div [ class "row" ] [
    div [ class "col-12", id "drivers" ] [
      table [ class "table table-responsive table-sm table-striped" ] [
        thead [] [ tableHeaderRow ],
        tbody [] (map tableBodyRow model.drivers)
      ]
    ],
    div [ class "col-6", id "pagination-info" ] [
      paginationInfo model
    ],
    div [ class "col-6", id "pagination-controls" ] [
      paginationControls model
    ]
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
  page model.driversNextPage NextPageClicked "»"


nominalImpedanceCell : Driver -> Html Msg
nominalImpedanceCell driver =
  let
    str = (maybeNumToStr driver.nominal_impedance) ++ ohms
  in
    td [] [ text str ]


page : Maybe String -> Msg -> String -> Html Msg
page endpoint msg txt =
  let
    disabledVal =
      case endpoint of
        Nothing -> True
        Just v -> False
  in
    button [
      class "btn btn-secondary btn-sm",
      disabled disabledVal,
      onClick msg
    ] [ text txt ]


paginationControls : Model -> Html Msg
paginationControls model =
  let
    prev = prevPage model
    next = nextPage model
  in
    div [ class "btn-group float-right", id "pagination" ] [ prev, next ]


paginationInfo : Model -> Html Msg
paginationInfo model =
  let
    currentCount = (toString <| length model.drivers)
    totalCount = (toString model.driversCount)
  in
    text <| "Showing " ++ currentCount ++ " of " ++ totalCount ++ " items"


power : Maybe number -> String
power n =
  maybeNumToStr n ++ watts


powerCell : Driver -> Html Msg
powerCell driver =
  let
    str = (power driver.max_power) ++ ", " ++ (power driver.rms_power)
  in
    td [ ] [ text str ]


prevPage : Model -> Html Msg
prevPage model =
  page model.driversPreviousPage PrevPageClicked "«"


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
