module Tests where

import Debug.Trace (trace)
import Test.Assert.Simple (assertEqual, assertBool)
import Test.Mocha (
    Describe(..), It(..), Done(..)
  , beforeEach
  , describe, it, itAsync, itIs, itIsNot
)

import Data.Either(either)
import Data.Foldable(foldl)
import Control.Monad.Eff.Exception(throwException)
import qualified Node.Path as Path
import qualified Node.FS.Async as FS.Async

resolveFixture = Path.resolve [ "tests", "fixtures" ]

main = describe "Node.FS.Async" do

  describe ".exists" do
    let fixture = resolveFixture "test-exists"
        resolve = Path.resolve [ fixture ]

    itAsync "returns `true` if the path exists " \done -> do
      FS.Async.exists (resolve "a")  \exists -> do
        assertEqual exists true
        itIs done

    itAsync "returns `false` if the path does not exists " \done -> do
      FS.Async.exists (resolve "b") \exists -> do
        assertEqual exists false
        itIs done
