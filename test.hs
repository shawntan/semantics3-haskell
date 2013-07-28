import Network.OAuth.Consumer
import Network.OAuth.Http.Request
import Network.OAuth.Http.Response
import Network.OAuth.Http.HttpClient
import Network.OAuth.Http.CurlHttpClient
import Network.OAuth.Http.PercentEncoding
import Data.Maybe
import Data.List
import Control.Monad.IO.Class
import Data.Aeson
import Data.Attoparsec
import Data.ByteString
 
srvUrl   = fromJust $ parseURL "https://api.semantics3.com/v1/products?q=%7B%22search%22:%22Apple%20Macb*%22%7D"
app      = Application "" "" OOB
token    = fromApplication app
 
main = do
		response1 <- liftIO $ runOAuthM token $ do
				request_ <- signRq2 HMACSHA1 Nothing srvUrl
				serviceRequest CurlClient request_
		print (Data.Aeson.decode (rspPayload response1)::Maybe Value)
