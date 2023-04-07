<cfinclude template = "./includes/header.cfm">

<cfscript>
	// Get date and Time
	datetime = dateConvert("Local2UTC", now())
	amzDate=	dateFormat( datetime, "yyyymmdd" ) &	"T" & timeFormat( datetime, "HHmmss" ) &	"Z"
	dateStamp=	dateFormat( datetime, "yyyymmdd" )

	// Define a struct for arguments
	args={requestParams={quantity:15}}
	// Input fields
	args.requestMethod='PUT'
	args.hostName='sandbox.sellingpartnerapi-na.amazon.com'
	args.requestURI='/externalFulfillment/inventory/2021-01-06/locations/43cd8cd4-a944-4fa8-a584-5e3b3efdb045/skus/efptestsku2/'
	args.requestBody=""
	args.requestHeaders={}
	
	args.signedPayload=true
	args.excludeHeaders=[]
	args.amzDate=#amzDate#
	args.dateStamp=dateStamp

	// create object of externalFulfillment
	externalFulfillment = createObject("component","src.components.externalFulfillment");
	inventory = createObject("component","src.components.inventory");

	// Get Signatured Data
	signatureData=externalFulfillment.generateSignatureData(argumentCollection=args)

	args.updateTargetUrl='https://sandbox.sellingpartnerapi-na.amazon.com/externalFulfillment/inventory/2021-01-06/locations/43cd8cd4-a944-4fa8-a584-5e3b3efdb045/skus/efptestsku2/?quantity=15'
	// Get Access and Refresh Data
	args.tokens=externalFulfillment.getToken(amzDate)
	updateInventoryres=inventory.updateInventory(args.updateTargetUrl,args.tokens.access_token,amzDate,signatureData.authHeader)

</cfscript>
	<cfoutput>
		<div class="container-fluid">
				<h2 class='w-100 text-center'>Update Inventory</h2>
		<h3 class='w-100 text-center'>Input Data</h3>
			<cfdump var = "#args#">
		<h3 class='w-100 text-center mt-3'>Response</h3>
			<cfdump var = "#updateInventoryres#">
		</div>
	</cfoutput>
<cfinclude template = "./includes/footer.cfm">
    
