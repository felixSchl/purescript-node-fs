module Node.FS.Sync
  ( rename
  , truncate
  , readFile
  , readTextFile
  ) where

import Control.Monad.Eff
import Control.Monad.Eff.Exception
import Data.Function
import Node.Buffer (Buffer(..))
import Node.Encoding
import Node.FS
import Node.FS.Stats
import Node.Path (FilePath())
import Global (Error(..))

foreign import fs "var fs = require('fs');" ::
  { renameSync :: Fn2 FilePath FilePath Unit
  , truncateSync :: Fn2 FilePath Number Unit
  , readFileSync :: forall a opts. Fn2 FilePath { | opts } a
  }

foreign import mkEff
  "function mkEff(x) {\
  \  return x;\
  \}" :: forall eff a. (Unit -> a) -> Eff eff a

-- |
-- Renames a file.
--
rename :: forall eff. FilePath
                   -> FilePath
                   -> Eff (fs :: FS | eff) Unit

rename oldFile newFile = mkEff $ \_ -> runFn2
  fs.renameSync oldFile newFile

-- |
-- Truncates a file to the specified length.
--
truncate :: forall eff. FilePath
                     -> Number
                     -> Eff (fs :: FS | eff) Unit

truncate file len = mkEff $ \_ -> runFn2
  fs.truncateSync file len

-- |
-- Reads the entire contents of a file returning the result as a raw buffer.
--
readFile :: forall eff. FilePath
                     -> Eff (fs :: FS, err :: Exception Error | eff) Buffer

readFile file = mkEff $ \_ -> runFn2
  fs.readFileSync file {}

-- |
-- Reads the entire contents of a text file with the specified encoding.
--
readTextFile :: forall eff. Encoding
                         -> FilePath
                         -> Eff (fs :: FS, err :: Exception Error | eff) String

readTextFile encoding file = mkEff $ \_ -> runFn2
  fs.readFileSync file { encoding: show encoding }
