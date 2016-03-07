
module Ontology where

import Data.RDF.Types

goalTaskType :: Text
goalTaskType = "goalTask"

goalTask :: Text -> LValue
goalTask name = typedL name goalTaskType

dependsOn :: Predicate 
dependsOn = lnode . plainL $ "dependsOn"

hasDescription :: Predicate
hasDescription = lnode . plainL $ "hasDescription"