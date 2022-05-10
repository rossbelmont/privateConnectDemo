global class RandomNumbers {
    @InvocableMethod(label='Get Random Number' description='Returns a random decimal value between 0 and 1.' callout=true)
    public static List<RandomNumberResults> getRandomNumber() {            
        RandomNumberResults res = new RandomNumberResults();
        res.predictionValue = makeSecureCallout();
        
        List<RandomNumberResults> returnValues = new List<RandomNumberResults>();
        returnValues.add(res);

        return returnValues;
    }
    
    private static Decimal makeSecureCallout() {
        // Prepare callout
        HttpRequest req = new HttpRequest();
        req.setEndpoint('callout:pcCalloutTest');
        req.setMethod('GET');
        Http http = new Http();
        
        // Make callout, get raw string response
        HTTPResponse res = http.send(req);
        String resp = res.getBody();
        System.debug('Response from AWS: ' + resp);
        
        // Convert String to Decimal
        Decimal dec = Decimal.valueOf(resp);
        dec = dec.setScale(2);
        
        return dec;
    }
    
    global class RandomNumberResults {
        @InvocableVariable
        global Decimal predictionValue;
    }
}