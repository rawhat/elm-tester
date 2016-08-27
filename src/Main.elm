module Main exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Html.App as App exposing (program)
import Http exposing (..)
import Json.Decode as Json exposing (..)
import Task exposing (..)


-- model


type alias Model =
    { posts : List Post
    , lastPost : Int
    }


type alias Post =
    { id : Int
    , title : String
    , body : String
    }


initModel : Model
initModel =
    { posts = []
    , lastPost = 0
    }



-- update


type Msg
    = NextPost
    | FetchFail Http.Error
    | FetchSuccess Post


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        NextPost ->
            ( model, fetchNextPost model )

        FetchSuccess resp ->
            let
                newPost =
                    Post resp.id resp.title resp.body

                newPosts =
                    List.append model.posts [ newPost ]
            in
                ( { model | posts = newPosts, lastPost = model.lastPost + 1 }, Cmd.none )

        FetchFail _ ->
            ( model, Cmd.none )


fetchNextPost : Model -> Cmd Msg
fetchNextPost model =
    let
        nextIndex =
            model.lastPost + 1

        url =
            "https://jsonplaceholder.typicode.com/posts/" ++ (toString nextIndex)
    in
        Task.perform FetchFail FetchSuccess (Http.get decodePostJson url)


decodePostJson : Decoder Post
decodePostJson =
    Json.object3
        Post
        ("id" := Json.int)
        ("title" := Json.string)
        ("body" := Json.string)



-- view


view : Model -> Html.Html Msg
view model =
    div []
        [ h2 []
            [ text "Post List"
            , button [ type' "button", onClick NextPost ] [ text "New Post" ]
            , div [ class "container-fluid" ]
                (List.map
                    (\post ->
                        div [ class "panel panel-default" ]
                            [ div [ class "panel-heading" ] [ text post.title ]
                            , div [ class "panel-body" ] [ text post.body ]
                            ]
                    )
                    model.posts
                )
            ]
        ]


main : Program Never
main =
    App.program
        { init = ( initModel, Cmd.none )
        , subscriptions = \_ -> Sub.none
        , view = view
        , update = update
        }
