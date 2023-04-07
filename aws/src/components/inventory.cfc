<cfcomponent name="inventory">
	<cfscript> 

		//GET INVENTORY
		public function getInventory(
			required any targetUrl
			,required any access_token
			,required any amzDate
			,required any authHeader
		)
		{
			cfhttp(method="get", url=targetUrl, result="result" , charset = "utf-8") {
				cfhttpparam(name="x-amz-access-token", type="header", value=access_token);
				cfhttpparam(name="X-Amz-Date", type="header", value=amzDate);
				cfhttpparam(name="Authorization", type="header", value=authHeader);
			}
			res=result.filecontent;
			return deSerializeJSON(res)
		}

		//UPDATE INVENTORY
		public function updateInventory(
			required any targetUrl
			,required any access_token
			,required any amzDate
			,required any authHeader
		)
		{
			cfhttp(method="put", url=targetUrl, result="result" , charset = "utf-8") {
				cfhttpparam(name="x-amz-access-token", type="header", value=access_token);
				cfhttpparam(name="X-Amz-Date", type="header", value=amzDate);
				cfhttpparam(name="Authorization", type="header", value=authHeader);
			}
			res=result.filecontent;
			return deSerializeJSON(res)
		}
	</cfscript>
 </cfcomponent>