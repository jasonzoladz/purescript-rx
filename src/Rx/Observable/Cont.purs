module Rx.Observable.Cont
  ( liftCont
  )
  where

import Prelude
import Control.Monad.Eff
import Control.Monad.Cont.Trans
import Rx.Observable
import Rx.Notification

liftCont :: forall eff a. ContT Unit (Eff eff) (Notification a) -> Eff eff (Observable a)
liftCont (ContT f) = _liftCont f

foreign import _liftCont
  :: forall eff a. (((Notification a) -> Eff eff Unit) -> Eff eff Unit) -> Eff eff (Observable a)
