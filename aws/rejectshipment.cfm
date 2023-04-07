
<cfinclude template = "./includes/header.cfm">

<cfscript>

	// Get date and Time
	datetime = dateConvert("Local2UTC", now())
	amzDate=	dateFormat( datetime, "yyyymmdd" ) &	"T" & timeFormat( datetime, "HHmmss" ) &	"Z"
	dateStamp=	dateFormat( datetime, "yyyymmdd" )

	data={
		referenceId: "cancellation-reference-identifier1",
		lineItems: [
			{
				lineItem: {
					id: "1",
					quantity: 1
				},
				reason: "OUT_OF_STOCK"
			}
		]
		}
	// Define a struct for arguments
	args={requestParams={operation='REJECT'},
	requestBody=data
	}


	// Input fields
	args.requestMethod='POST'
	args.hostName='sellingpartnerapi-na.amazon.com'
	args.requestURI='/externalFulfillment/shipments/2021-01-06/shipments/#url.shipment_id#'
	args.requestHeaders={}
	
	args.signedPayload=true
	args.excludeHeaders=[]
	args.amzDate=#amzDate#
	args.dateStamp=dateStamp
	
	// create object of externalFulfillment
	externalFulfillment = createObject("component","src.components.externalFulfillment");
	shipment = createObject("component","src.components.shipments");

	// Get Signatured Data
	signatureData=externalFulfillment.generateSignatureData(argumentCollection=args)
	
	args.updateTargetUrl='https://sellingpartnerapi-na.amazon.com/externalFulfillment/shipments/2021-01-06/shipments/#url.shipment_id#?operation=REJECT'
	// Get Access and Refresh Data
	
	args.tokens=externalFulfillment.getToken(amzDate)
</cfscript>
<cfscript>

	orders=shipment.rejectshipment(args.updateTargetUrl,args.tokens.access_token,amzDate,signatureData.authHeader,args.requestBody);
</cfscript>
	<cfoutput>

	<cfdump var="#orders#">
	
	
	
	
	</cfoutput>

	<cfinclude template = "./includes/footer.cfm">
