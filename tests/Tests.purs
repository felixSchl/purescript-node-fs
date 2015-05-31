module Tests where

import Prelude
import Control.Monad.Eff
import qualified Node.FS as FS
import qualified Test.Mocha as Mocha
import Test.Mocha (
    Describe(..), It(..), Done(..)
  , describe, it, itAsync, itIs, itIsNot
)

main = describe "a test with mocha" $ do
    itAsync "passes" \done -> do
        itIs done
