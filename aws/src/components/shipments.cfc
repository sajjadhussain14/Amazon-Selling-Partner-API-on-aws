<cfcomponent name="inventory">
	<cfscript> 

		
		public function getshipments(
			required any targetUrl
			,required any access_token
			,required any amzDate
			,required any authHeader
		)
		{
		//writeoutput(targetUrl);
			cfhttp(method="get", url=targetUrl, result="result" , charset = "utf-8") {
				cfhttpparam(name="x-amz-access-token", type="header", value=access_token);
				cfhttpparam(name="X-Amz-Date", type="header", value=amzDate);
				cfhttpparam(name="Authorization", type="header", value=authHeader);
			}
			res=result.filecontent;
			return deSerializeJSON(res)
		}


	public function confirmshipment(
			required any targetUrl
			,required any access_token
			,required any amzDate
			,required any authHeader
		)
		{
		//writeoutput(targetUrl);
			cfhttp(method="post", url=targetUrl, result="result" , charset = "utf-8") {
				cfhttpparam(name="x-amz-access-token", type="header", value=access_token);
				cfhttpparam(name="X-Amz-Date", type="header", value=amzDate);
				cfhttpparam(name="Authorization", type="header", value=authHeader);
			}
			res=result.filecontent;
			return deSerializeJSON(res)
		}
		
		
			public function rejectshipment(
			required any targetUrl
			,required any access_token
			,required any amzDate
			,required any authHeader
			,required any requestBody
		)
		{

			cfhttp(method="post", url=targetUrl, result="result" , charset = "utf-8") {
				cfhttpparam(name="x-amz-access-token", type="header", value=access_token);
				cfhttpparam(name="X-Amz-Date", type="header", value=amzDate);
				cfhttpparam(name="Authorization", type="header", value=authHeader);
				cfhttpparam(name="body",type="body", value=serializejson(requestBody));
		cfhttpparam(name="content-type", type="header", value="application/json");

			}
			res=result.filecontent;
			return deSerializeJSON(res)
		}


		
	</cfscript>
 </cfcomponent>