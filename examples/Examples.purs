module Examples where

import Control.MonadPlus.Partial
import Data.Tuple (Tuple(..))
import Data.Maybe
import Debug.Trace

import Rx.Observable
import Rx.Observable.Aff

main = do
  a <- return $ fromArray [1,2,3]
  b <- return $ fromArray [4,5,6]

  subscribe (a <> b) $ trace <<< show

  subscribe (combineLatest (+) a b) $ trace <<< show

  subscribe (zip (+) a b) (\n -> trace $ "zip: " ++ show n)

  subscribe (reduce (+) 0 (zip (+) a b)) $ trace <<< show

  subscribe (delay 1000 a) $ trace <<< show

  v <- liftAff $ pure "hello"
  runObservable $ trace <$> v
  
  -- Plus
  (Tuple smaller bigger) <- return $ mpartition ((>) 5) (fromArray [2,3,4,5,6,8,9,10,100])

  trace "smaller:"
  subscribe smaller $ trace <<< show

  trace "bigger:"
  subscribe bigger $ trace <<< show

  subscribe (mcatMaybes $ fromArray [Just 1, Just 2, Nothing, Just 4]) $ trace <<< show