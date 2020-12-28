module Pagination exposing (State, init, view)

import Html exposing (Html, button, div, input, span, text)
import Html.Attributes exposing (type_, value)
import Html.Events exposing (onClick, onInput)


type State
    = State InternalState


type alias InternalState =
    { current : Int
    , total : Int
    }


init : InternalState -> State
init internal =
    State
        { current = internal.current
        , total = internal.total
        }


type Msg
    = Prev
    | Next
    | PageChanged String


update : Msg -> State -> State
update msg (State internal) =
    case msg of
        Prev ->
            State { current = internal.current - 1, total = 10 }

        Next ->
            State { current = internal.current + 1, total = 10 }

        PageChanged str ->
            let
                page =
                    String.toInt str
            in
            State { current = page |> Maybe.withDefault 0, total = 10 }


view : (State -> msg) -> State -> Html msg
view toMsg (State internal) =
    div []
        [ button [ onClick <| toMsg (update Prev (State internal)) ] [ text "<" ]
        , span [] [ text " " ]
        , input
            [ type_ "text"
            , value <| String.fromInt internal.current
            , onInput (\s -> toMsg (update (PageChanged s) (State internal)))
            ]
            []
        , span [] [ text " / " ]
        , span [] [ text (String.fromInt internal.total) ]
        , span [] [ text " " ]
        , button [ onClick <| toMsg (update Next (State internal)) ] [ text ">" ]
        ]
