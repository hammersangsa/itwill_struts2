
var httpRequest;

function getXMLHttpRequest() {


    if (window.XMLHttpRequest) {  
        return new XMLHttpRequest();
        
    } else if (window.ActiveXObject) {
		try {
			
			return new ActiveXObject("Msxml2.XMLHTTP");
		} catch (e1) {
			try {
				
				return new ActiveXObject("Microsoft.XMLHTTP");
			} catch (e2) {

			}
		}
	}

}

var httpRequest = null;
//4개의 데이터를 던지면 getXML거쳐서 httpRequest생성
function sendRequest(url,params,callback,method) {
	
	httpRequest = getXMLHttpRequest();
	//method 처리
	var httpMethod = method ? method : "GET";//기본값
	
	if(httpMethod!="GET" && httpMethod!="POST"){
		httpMethod = "GET";
	}
	//param처리
	var httpParams = (params==null || params=="") ? null : params;
	//url처리
	var httpUrl = url;
	
	if(httpMethod=="GET"&&httpParams!=null){
		httpUrl = httpUrl + "?" + httpParams;
	}
	//POST방식
	httpRequest.open(httpMethod,httpUrl,true);
	httpRequest.setRequestHeader(
			"Content-Type", "application/x-www-form-urlencoded");
	httpRequest.onreadystatechange = callback;
	httpRequest.send(httpMethod=="POST"?httpParams:null);
}


/*function createXMLHttpRequest() {
    var xmlReq = false;

    if (window.XMLHttpRequest) {    // Non-Microsoft browsers
        xmlReq = new XMLHttpRequest();
    } else if (window.ActiveXObject) {
		try {
			// XMLHttpRequest in later versions of Internet Explorer
			xmlReq = new ActiveXObject("Msxml2.XMLHTTP");
		} catch (e1) {
			try {
				// Try version supported by older versions of Internet Explorer
				xmlReq = new ActiveXObject("Microsoft.XMLHTTP");
			} catch (e2) {
				// Unable to create an XMLHttpRequest with ActiveX
			}
		}
	}

	return xmlReq;
}
*/