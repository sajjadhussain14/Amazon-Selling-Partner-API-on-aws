<cfinclude template = "./includes/header.cfm">


<cfscript>
	// Get date and Time
	datetime = dateConvert("Local2UTC", now())
	amzDate=	dateFormat( datetime, "yyyymmdd" ) &	"T" & timeFormat( datetime, "HHmmss" ) &	"Z"
	dateStamp=	dateFormat( datetime, "yyyymmdd" )

	// Define a struct for arguments
	args={}
	// Input fields
	args.requestMethod='GET'
	args.hostName='sellingpartnerapi-na.amazon.com'
	args.requestURI='/externalFulfillment/shipments/2021-01-06/shipments'
	args.requestBody=""
	args.requestHeaders={}
	args.requestParams={locationId='270b36ad-469e-4491-947b-eb28dd5f4954',status='CANCELLED'}
	args.signedPayload=true
	args.excludeHeaders=[]
	args.amzDate=#amzDate#
	args.dateStamp=dateStamp
	// create object of externalFulfillment
	externalFulfillment = createObject("component","src.components.externalFulfillment");
	shipment = createObject("component","src.components.shipments");

	// Get Signatured Data
	signatureData=externalFulfillment.generateSignatureData(argumentCollection=args)

	args.updateTargetUrl='https://sellingpartnerapi-na.amazon.com/externalFulfillment/shipments/2021-01-06/shipments?locationId=270b36ad-469e-4491-947b-eb28dd5f4954&status=CANCELLED'
	// Get Access and Refresh Data
	args.tokens=externalFulfillment.getToken(amzDate)
	orders=shipment.getshipments(args.updateTargetUrl,args.tokens.access_token,amzDate,signatureData.authHeader)

</cfscript>
	<cfoutput>
		<div class="container-fluid">
		<h2 class='w-100 text-center'>Display Inventory</h2>
		<h3 class='w-100 text-center'>Input Data</h3>
			<cfdump var = "#args#">
		<h3 class='w-100 text-center mt-3'>Response</h3>
			<cfdump var = "#orders#">
		</div>
	</cfoutput>
<cfinclude template = "./includes/footer.cfm">
    
