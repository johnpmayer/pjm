module Lib
    ( initialize
    ) where

import Data.RDF (empty, hWriteRdf, parseFile, parseString)
import Data.Text (Text)
import Data.Text.IO (hGetContents)
import Data.RDF.TriplesGraph (TriplesGraph)
import System.IO (IOMode(ReadWriteMode), openFile, withFile)
import Text.RDF.RDF4H.NTriplesParser (NTriplesParser(NTriplesParser))
import Text.RDF.RDF4H.NTriplesSerializer (NTriplesSerializer(NTriplesSerializer))

-- Single code-point to change RDF back-end
type RDFBackend = TriplesGraph

serializer :: NTriplesSerializer
serializer = NTriplesSerializer

parser :: NTriplesParser
parser = NTriplesParser

data ProjectSpace = ProjectSpace
  { metadata :: RDFBackend
  }

readProjectSpace ::  FilePath -> IO ProjectSpace
readProjectSpace path =
  do
    Right rdf <- parseFile parser path
    return $ ProjectSpace { metadata = rdf }

writeProjectSpace :: ProjectSpace -> FilePath -> IO ()
writeProjectSpace space path =
  do
    handle <- openFile path ReadWriteMode
    hWriteRdf serializer handle (metadata space)

withProjectSpace :: FilePath -> (ProjectSpace -> IO (ProjectSpace, a)) -> IO a
withProjectSpace path action =
  do
    withFile path ReadWriteMode $ \handle ->
      do
        contents <- hGetContents handle
        let Right rdf = parseString parser contents
        let space = ProjectSpace rdf
        undefined -- not sure how this is useful, hold the lock on the "DB"
        

initialize :: FilePath -> IO ()
initialize path = undefined